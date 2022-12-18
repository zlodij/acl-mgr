package ua.pp.jdev.permits.data;

import java.util.HashSet;
import java.util.Set;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NonNull;
import lombok.Singular;
import ua.pp.jdev.permits.enums.State;
import ua.pp.jdev.permits.util.IDGenerator;

/**
 * A domain object for ACL's Accessor
 * 
 * @author Maksym Shramko
 *
 */
@Data
@Builder(toBuilder = true)
@EqualsAndHashCode(of = {"name"})
@JsonPropertyOrder({ "id", "name", "permit", "alias", "svc", "xPermits", "orgLevels" })
public class Accessor implements Comparable<Accessor> {
	public final static String DM_OWNER = "dm_owner";
	public final static String DM_WORLD = "dm_world";
	
	private String id;

	@NotBlank(message = "{validation.notblank.name}")
	@NonNull
	private String name;
	private boolean alias;
	private boolean svc;
	@Min(1)
	@Max(7)
	private int permit;

	@JsonIgnore
	@NonNull
	private State state;
	@Singular
	private Set<String> xPermits;
	@Singular
	private Set<String> orgLevels;
	
	public Accessor() {
		id = IDGenerator.EMPTY_ID;
		name = "";
		state = State.NEW;
		xPermits = new HashSet<>();
		orgLevels = new HashSet<>();
	}

	private Accessor(String id, String name, boolean alias, boolean svc, int permit, State state, Set<String> xPermits, Set<String> orgLevels) {
		this();
		if (name != null) {
			setName(name);
		}
		if (state != null) {
			setState(state);
		}
		if(IDGenerator.validateID(id)) {
			setId(id);
		}
		setAlias(alias);
		setSvc(svc);
		setPermit(permit);
		setXPermits(xPermits);
		setOrgLevels(orgLevels);
	}
	
	public void setXPermits(Set<String> xPermits) {
		this.xPermits.clear();
		
		if(xPermits != null) {
			this.xPermits.addAll(xPermits);
		}
	}
	
	public void setOrgLevels(Set<String> orgLevels) {
		this.orgLevels.clear();
		
		if(orgLevels != null) {
			this.orgLevels.addAll(orgLevels);
		}
	}

	@Override
	public int compareTo(Accessor o) {
		return getName().compareToIgnoreCase(o.getName());
	}
}
