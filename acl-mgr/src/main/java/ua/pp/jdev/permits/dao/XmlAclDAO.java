package ua.pp.jdev.permits.dao;

import java.io.FileNotFoundException;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Component;

import ua.pp.jdev.permits.dao.xml.XmlDataException;
import ua.pp.jdev.permits.dao.xml.XmlDataProvider;
import ua.pp.jdev.permits.domain.AccessControlList;

@Component
@Profile("xml")
public class XmlAclDAO extends SimpleAclDAO {
	@Value("${data.src}")
	private String dataSource;

	XmlDataProvider provider;

	@Override
	protected String getInitMessage() {
		return "Initializing ACL datasource storing data in XML-file";
	}
	
	@PostConstruct
	protected void populate() {
		try {
			provider = new XmlDataProvider(dataSource);
			provider.read().forEach(acl -> {
				super.create(acl);
			});
		} catch (FileNotFoundException | XmlDataException e) {
			throw new RuntimeException(e);
		}
	}

	protected void saveToXml() {
		try {
			provider.write(readAll());
		} catch (XmlDataException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public void create(AccessControlList acl) {
		super.create(acl);

		// save changes to XML data source
		saveToXml();
	}

	@Override
	public boolean delete(String id) {
		boolean result = super.delete(id);

		// save changes to XML data source
		saveToXml();

		return result;
	}

	@Override
	public void update(AccessControlList acl) {
		super.update(acl);

		// save changes to XML data source
		saveToXml();
	}
}
