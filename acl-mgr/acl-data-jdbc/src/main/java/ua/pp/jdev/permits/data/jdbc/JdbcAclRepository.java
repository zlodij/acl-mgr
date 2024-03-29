package ua.pp.jdev.permits.data.jdbc;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

interface JdbcAclRepository extends PagingAndSortingRepository<TableACL, Long> {
	List<TableACL> findByName(String name);
}
