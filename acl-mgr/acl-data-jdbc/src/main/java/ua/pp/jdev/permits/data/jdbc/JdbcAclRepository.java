package ua.pp.jdev.permits.data.jdbc;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
interface JdbcAclRepository extends CrudRepository<TableACL, Long> {

}