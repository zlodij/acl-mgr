package ua.pp.jdev.permits.data.jdbc;

import java.io.Serializable;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
@Table("XPERMIT")
class TableXPermit implements Serializable {
	private static final long serialVersionUID = -8018322317901356555L;
	
	@Id
	private Long id;
	private Long accessorId;
	@Column("XPERMIT")
	private String xPermit;
}
