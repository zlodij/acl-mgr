package ua.pp.jdev.permits.data.base;

import java.util.Set;

record AclRecord(String id, String name, String description, Set<String> objTypes, Set<String> statuses, Set<AccessorRecord> accessors) {

}