<#import "/spring.ftl" as spring/>
<#import "container.ftlh" as c>
<@c.container>
    <script type="text/javascript">
        function onClickCheckBox(checkbox) {
            checkbox.value = checkbox.checked;
            document.getElementById("refresh").value = true;
            checkbox.form.submit();
        }

        function onDelete() {
            // change current HTTP method on DELETE and submit form
            document.getElementById("_method").value = "delete";
            document.getElementById("editAccessor").submit();
        }
    </script>
    <form id="editAccessor" action="/acls/${acl.id}?accessorName=${accessor.name}" method="post"
          modelAttribute="accessor">
        <input type="hidden" id="refresh" name="refresh" value="false"/>
        <input type="hidden" id="_method" name="_method" value="patch"/>
        <input type="hidden" id="state" name="state" value="${accessor.state}"/>
        <input type="hidden" id="id" name="id" value="<#if accessor.id??>${accessor.id}</#if>"/>
        <input type="hidden" id="aclId" name="aclId" value="<#if accessor.aclId??>${accessor.aclId}</#if>"/>
        <div class="card w-75">
            <h5 class="card-header" style="color: grey"><i
                        class="fa-solid fa-user-shield"></i>&nbsp;<@spring.message "title.editaccessor"/>
                : ${accessor.name}</h5>
            <div class="card-body">
                <#--
                    <div class="form-group row">
                        <label for="id"
                               class="col-sm-2 col-form-label font-weight">-ID-</label>
                        <div class="col-sm-4">
                            <input type="text" readonly class="form-control-plaintext" id="id"
                                   value="<#if accessor.id??>${accessor.id}</#if>">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="state"
                               class="col-sm-2 col-form-label font-weight">-STATE-</label>
                        <div class="col-sm-4">
                            <input type="text" readonly class="form-control-plaintext" id="state"
                                   value="${accessor.state}">
                        </div>
                    </div>
                     -->
                <div class="form-group row">
                    <label for="name"
                           class="col-sm-2 col-form-label font-weight"><@spring.message "label.name"/></label>
                    <div class="col-sm-4">
                        <@spring.bind "accessor.name"/>
                        <input class="form-control ${(spring.status.errorMessages?has_content)?string("is-invalid","")}"
                               type="text" name="${spring.status.expression}" value="${spring.status.value}"/>
                        <@spring.showErrors "<br>" "invalid-feedback"/>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="permit"
                           class="col-sm-2 col-form-label font-weight"><@spring.message "label.permit"/></label>
                    <div class="col-sm-3">
                        <#if dictPermits?has_content>
                            <@spring.bind "accessor.permit"/>
                            <select class="custom-select ${(spring.status.errorMessages?has_content)?string("is-invalid","")}"
                                    id="permit" name="permit">
                                <option value="0"></option>
                                <#list dictPermits?keys as key>
                                    <option value="${dictPermits[key].getValue()}"
                                            <#if dictPermits[accessor.permit?c]??>selected</#if>>${dictPermits[key]}</option>
                                </#list>
                            </select>
                            <@spring.showErrors "<br>" "invalid-feedback"/>
                        <#else>
                            <span><@spring.message "label.notavailable"/></span>
                        </#if>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="XPermits"
                           class="col-sm-2 col-form-label font-weight"><@spring.message "label.xpermits"/></label>
                    <div class="col-sm-4">
                        <#if dictXPermits?has_content>
                            <select class="selectpicker" id="XPermits" name="XPermits" multiple>
                                <#list dictXPermits?keys as key>
                                    <option value="${dictXPermits[key]}"
                                            <#if accessor.XPermits?seq_contains(dictXPermits[key])>selected</#if>>${dictXPermits[key].display}</option>
                                </#list>
                            </select>
                        <#else>
                            <span><@spring.message "label.notavailable"/></span>
                        </#if>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="alias"
                           class="col-sm-2 col-form-label font-weight"><@spring.message "label.alias"/></label>
                    <div class="col-sm-4">
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" id="alias" name="alias"
                                   onclick="onClickCheckBox(this)"
                                   <#if accessor.alias??>value="${accessor.alias?c}"</#if> <#if accessor.alias>checked</#if>/>
                        </div>
                    </div>
                </div>
                <#if accessor.alias>
                    <div class="form-group row">
                        <label for="svc"
                               class="col-sm-2 col-form-label font-weight"><@spring.message "label.svc"/></label>
                        <div class="col-sm-4">
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" id="svc" name="svc"
                                       onclick="onClickCheckBox(this)"
                                       value="${accessor.svc?c}" <#if accessor.svc>checked</#if>/>
                            </div>
                        </div>
                    </div>
                </#if>
                <#if accessor.svc>
                    <div class="form-group row">
                        <label for="orgLevels"
                               class="col-sm-2 col-form-label font-weight"><@spring.message "label.orglevels"/></label>
                        <div class="col-sm-4">
                            <#if dictOrgLevels?has_content>
                                <select class="selectpicker" id="orgLevels" name="orgLevels" multiple>
                                    <#list dictOrgLevels?keys as key>
                                        <option value="${dictOrgLevels[key]}"
                                                <#if accessor.orgLevels?seq_contains(dictOrgLevels[key])>selected</#if>>${dictOrgLevels[key].display}</option>
                                    </#list>
                                </select>
                            <#else>
                                <span><@spring.message "label.notavailable"/></span>
                            </#if>
                        </div>
                    </div>
                </#if>
            </div>
        </div>
        <div class="d-flex">
            <div class="p-2">
                <input class="btn btn-secondary mr-2" name="delete"
                       value="<@spring.message "button.delete"/>" type="button"
                       title="<@spring.message "button.delete"/>" onClick="onDelete()"/>
            </div>
            <div class="p-2">
                <input class="btn btn-secondary mr-2" name="apply"
                       value="<@spring.message "button.apply"/>"
                       title="<@spring.message "button.apply"/>" type="submit"/>
            </div>
            <div class="p-2">
                <input class="btn btn-secondary mr-2" name="cancel"
                       value="<@spring.message "button.cancel"/>"
                       title="<@spring.message "button.cancel"/>" type="button"
                       onClick="location.href='/acls/${acl.id}/edit'"/>
            </div>
        </div>
    </form>
</@c.container>
