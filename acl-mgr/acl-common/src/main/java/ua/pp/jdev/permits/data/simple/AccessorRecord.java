package ua.pp.jdev.permits.data.simple;

import java.util.Set;

record AccessorRecord(String id, String name, boolean alias, boolean svc, int permit, Set<String> xPermits, Set<String> orgLevels) {

}