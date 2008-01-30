From: Tejun Heo <htejun@gmail.com>
Subject: How to verify sht-ops-conversion patch doesn't change anything
Date: Wed, 30 Jan 2008 18:49:49 +0900
Message-ID: <47A0483D.6020101@gmail.com>
References: <12016853433196-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020203070305040007040100"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.238]:44640 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbYA3JuF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jan 2008 04:50:05 -0500
Received: by qb-out-0506.google.com with SMTP id e11so165465qbe.15
        for <linux-ide@vger.kernel.org>; Wed, 30 Jan 2008 01:50:01 -0800 (PST)
In-Reply-To: <12016853433196-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@dyn-67.arm.linux.org.uk, alessandro.zummo@to

This is a multi-part message in MIME format.
--------------020203070305040007040100
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The fifth patch, sht-ops-conversion, can be verified not to change the
final sht and ops by printing out all entries and comparing the values
before and after.

1. Apply till the fourth patch and apply verify-before on top of it.
   Build a kernel with all libata modules enabled.  Boot, cd into
   drivers/ata and run the following command.

   # insmod libata.ko; for i in $(ls *.ko | sort | grep -v libata.ko); do insmod $i; done; dmesg -c | grep -E 'SHT|OPS' | sed -r 's/^\[[ \.0-9]*\] (.*)$/\1/' | sort > ~/out.before

   If you need some libata modules built-in for rootfs, it's okay too.
   It will give the same result.

2. Backout verify-before, apply the sht-ops-conversion patch and
   verify-after on top of it and run the following command.

   # insmod libata.ko; for i in $(ls *.ko | sort | grep -v libata.ko); do insmod $i; done; dmesg -c | grep -E 'SHT|OPS' | sed -r 's/^\[[ \.0-9]*\] (.*)$/\1/' | sort > ~/out.after

3. Use your favorite diff program to compare out.before and out.after.
   Graphical ones which show in-line differences will work best.

verify-{before|after} patches add two dump functions in libata-core.c
and makes all LLDs call them with their sht and ops tables on driver
load.  If the supplied patches are enough for some reason, You can add
those lines using the attached gen-verify.py script.

out.before and out.after are the output files from x86-64.

Thanks.

-- 
tejun

--------------020203070305040007040100
Content-Type: text/x-python;
 name="gen-verify.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gen-verify.py"

#!/usr/bin/env python

import sys
import re

files = sys.argv[1:]
sht_re = re.compile('.*struct\s*scsi_host_template\s*(\w+)\s*(=|$)', re.M);
ops_re = re.compile('.*struct\s*ata_port_operations\s*(\w+)\s*(=|$)', re.M);
init_re = re.compile('^\s*module_init\s*\(\s*(\w*)\s*\)\s*;', re.M);

for f in files:
    srcf = open(f, 'r+')
    src = srcf.read()
    code = '{\n'

    match = init_re.search(src)
    initfn_pattern = '^[^\n]*\s*%s\s*\(\s*void\s*\).*(return[^;]*;)\s*^}' \
                        % match.group(1);
    match = re.compile(initfn_pattern, re.M|re.DOTALL).search(src)
    pos = match.start(1)

    match = sht_re.findall(src)
    for m in match:
        code += '\t\tata_dump_sht(DRV_NAME, &%s);\n' % m[0]

    match = ops_re.findall(src)
    for m in match:
        code += '\t\tata_dump_ops(DRV_NAME, &%s);\n' % m[0]
    code += '\t}\n\t'

    srcf.seek(0)
    srcf.truncate()
    srcf.write(src[:pos] + code + src[pos:])

--------------020203070305040007040100
Content-Type: text/plain;
 name="verify-before"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="verify-before"

---
 drivers/ata/ahci.c              |    6 ++++
 drivers/ata/ata_generic.c       |    4 +++
 drivers/ata/ata_piix.c          |    8 ++++++
 drivers/ata/libata-core.c       |   52 ++++++++++++++++++++++++++++++++++++++++
 drivers/ata/pata_acpi.c         |    4 +++
 drivers/ata/pata_ali.c          |    7 +++++
 drivers/ata/pata_amd.c          |    9 ++++++
 drivers/ata/pata_artop.c        |    5 +++
 drivers/ata/pata_at32.c         |    4 +++
 drivers/ata/pata_atiixp.c       |    4 +++
 drivers/ata/pata_bf54x.c        |    4 +++
 drivers/ata/pata_cmd640.c       |    4 +++
 drivers/ata/pata_cmd64x.c       |    6 ++++
 drivers/ata/pata_cs5520.c       |    4 +++
 drivers/ata/pata_cs5530.c       |    4 +++
 drivers/ata/pata_cs5535.c       |    4 +++
 drivers/ata/pata_cs5536.c       |    4 +++
 drivers/ata/pata_cypress.c      |    4 +++
 drivers/ata/pata_efar.c         |    4 +++
 drivers/ata/pata_hpt366.c       |    4 +++
 drivers/ata/pata_hpt37x.c       |    7 +++++
 drivers/ata/pata_hpt3x2n.c      |    4 +++
 drivers/ata/pata_hpt3x3.c       |    4 +++
 drivers/ata/pata_icside.c       |    4 +++
 drivers/ata/pata_isapnp.c       |    4 +++
 drivers/ata/pata_it8213.c       |    4 +++
 drivers/ata/pata_it821x.c       |    5 +++
 drivers/ata/pata_ixp4xx_cf.c    |    4 +++
 drivers/ata/pata_jmicron.c      |    4 +++
 drivers/ata/pata_legacy.c       |   14 ++++++++++
 drivers/ata/pata_marvell.c      |    4 +++
 drivers/ata/pata_mpc52xx.c      |    4 +++
 drivers/ata/pata_mpiix.c        |    4 +++
 drivers/ata/pata_netcell.c      |    4 +++
 drivers/ata/pata_ninja32.c      |    4 +++
 drivers/ata/pata_ns87410.c      |    4 +++
 drivers/ata/pata_ns87415.c      |    5 +++
 drivers/ata/pata_oldpiix.c      |    4 +++
 drivers/ata/pata_opti.c         |    4 +++
 drivers/ata/pata_optidma.c      |    5 +++
 drivers/ata/pata_pcmcia.c       |    5 +++
 drivers/ata/pata_pdc2027x.c     |    5 +++
 drivers/ata/pata_pdc202xx_old.c |    5 +++
 drivers/ata/pata_platform.c     |    4 +++
 drivers/ata/pata_qdi.c          |    5 +++
 drivers/ata/pata_radisys.c      |    4 +++
 drivers/ata/pata_rz1000.c       |    4 +++
 drivers/ata/pata_sc1200.c       |    4 +++
 drivers/ata/pata_scc.c          |    4 +++
 drivers/ata/pata_serverworks.c  |    5 +++
 drivers/ata/pata_sil680.c       |    4 +++
 drivers/ata/pata_sis.c          |    9 ++++++
 drivers/ata/pata_sl82c105.c     |    4 +++
 drivers/ata/pata_triflex.c      |    4 +++
 drivers/ata/pata_via.c          |    5 +++
 drivers/ata/pata_winbond.c      |    4 +++
 drivers/ata/pdc_adma.c          |    4 +++
 drivers/ata/sata_fsl.c          |    4 +++
 drivers/ata/sata_inic162x.c     |    4 +++
 drivers/ata/sata_mv.c           |    7 +++++
 drivers/ata/sata_nv.c           |   10 +++++++
 drivers/ata/sata_promise.c      |    6 ++++
 drivers/ata/sata_qstor.c        |    4 +++
 drivers/ata/sata_sil.c          |    4 +++
 drivers/ata/sata_sil24.c        |    4 +++
 drivers/ata/sata_sis.c          |    4 +++
 drivers/ata/sata_svw.c          |    4 +++
 drivers/ata/sata_sx4.c          |    4 +++
 drivers/ata/sata_uli.c          |    4 +++
 drivers/ata/sata_via.c          |    6 ++++
 drivers/ata/sata_vsc.c          |    4 +++
 include/linux/libata.h          |    3 ++
 kernel/kallsyms.c               |    1 
 73 files changed, 393 insertions(+)

Index: work/drivers/ata/ahci.c
===================================================================
--- work.orig/drivers/ata/ahci.c
+++ work/drivers/ata/ahci.c
@@ -2293,6 +2293,12 @@ static int ahci_init_one(struct pci_dev 
 
 static int __init ahci_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &ahci_sht);
+		ata_dump_ops(DRV_NAME, &ahci_ops);
+		ata_dump_ops(DRV_NAME, &ahci_vt8251_ops);
+		ata_dump_ops(DRV_NAME, &ahci_p5wdh_ops);
+	}
 	return pci_register_driver(&ahci_pci_driver);
 }
 
Index: work/drivers/ata/ata_generic.c
===================================================================
--- work.orig/drivers/ata/ata_generic.c
+++ work/drivers/ata/ata_generic.c
@@ -228,6 +228,10 @@ static struct pci_driver ata_generic_pci
 
 static int __init ata_generic_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &generic_sht);
+		ata_dump_ops(DRV_NAME, &generic_port_ops);
+	}
 	return pci_register_driver(&ata_generic_pci_driver);
 }
 
Index: work/drivers/ata/ata_piix.c
===================================================================
--- work.orig/drivers/ata/ata_piix.c
+++ work/drivers/ata/ata_piix.c
@@ -1693,6 +1693,14 @@ static int __init piix_init(void)
 	in_module_init = 0;
 
 	DPRINTK("done\n");
+	{
+		ata_dump_sht(DRV_NAME, &piix_sht);
+		ata_dump_ops(DRV_NAME, &piix_pata_ops);
+		ata_dump_ops(DRV_NAME, &ich_pata_ops);
+		ata_dump_ops(DRV_NAME, &piix_sata_ops);
+		ata_dump_ops(DRV_NAME, &piix_vmw_ops);
+		ata_dump_ops(DRV_NAME, &piix_sidpr_sata_ops);
+	}
 	return 0;
 }
 
Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -7660,3 +7660,55 @@ EXPORT_SYMBOL_GPL(ata_cable_80wire);
 EXPORT_SYMBOL_GPL(ata_cable_unknown);
 EXPORT_SYMBOL_GPL(ata_cable_ignore);
 EXPORT_SYMBOL_GPL(ata_cable_sata);
+
+#include <linux/kallsyms.h>
+
+void ata_dump_sht(const char *drv_name, const struct scsi_host_template *sht)
+{
+	const int begin_off = offsetof(struct scsi_host_template, detect);
+	const int end_off = offsetof(struct scsi_host_template, eh_timed_out) + sizeof(void *);
+	char symname[KSYM_NAME_LEN];
+	void **pp;
+
+	if (lookup_symbol_name((unsigned long)sht, symname))
+		snprintf(symname, KSYM_NAME_LEN, "%p", sht);
+	printk("SHT %s %s: %s", drv_name, symname, sht->name);
+
+	for (pp = (void *)sht + begin_off; pp < (void **)((void *)sht + end_off); pp++) {
+		if (lookup_symbol_name((unsigned long)*pp, symname))
+			snprintf(symname, KSYM_NAME_LEN, "%p", *pp);
+		printk(" <%s>", symname);
+	}
+
+	printk(" %s %d %d %u %u %lu %d %u %u %u %u %u %u %u %u %u\n",
+	       sht->proc_name, sht->can_queue, sht->this_id,
+	       sht->sg_tablesize, sht->max_sectors, sht->dma_boundary,
+	       sht->cmd_per_lun, sht->present, sht->supported_mode,
+	       sht->unchecked_isa_dma, sht->use_clustering, sht->emulated,
+	       sht->skip_settle_delay, sht->ordered_tag, sht->use_sg_chaining,
+	       sht->max_host_blocked);
+}
+EXPORT_SYMBOL_GPL(ata_dump_sht);
+
+void ata_dump_ops(const char *drv_name, const struct ata_port_operations *ops)
+{
+	const int begin_off = 0;
+	const int end_off = offsetof(struct ata_port_operations, eng_timeout) + sizeof(void *);
+	struct ata_port_operations my_ops = *ops;
+	char symname[KSYM_NAME_LEN];
+	void **pp;
+
+	if (lookup_symbol_name((unsigned long)ops, symname))
+		snprintf(symname, KSYM_NAME_LEN, "%p", ops);
+	printk("OPS %s %s:", drv_name, symname);
+
+	//ata_finalize_port_ops(&my_ops);
+
+	for (pp = (void *)&my_ops + begin_off; pp < (void **)((void *)&my_ops + end_off); pp++) {
+		if (lookup_symbol_name((unsigned long)*pp, symname))
+			snprintf(symname, KSYM_NAME_LEN, "%p", *pp);
+		printk(" <%s>", symname);
+	}
+	printk("\n");
+}
+EXPORT_SYMBOL_GPL(ata_dump_ops);
Index: work/drivers/ata/pata_acpi.c
===================================================================
--- work.orig/drivers/ata/pata_acpi.c
+++ work/drivers/ata/pata_acpi.c
@@ -335,6 +335,10 @@ static struct pci_driver pacpi_pci_drive
 
 static int __init pacpi_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &pacpi_sht);
+		ata_dump_ops(DRV_NAME, &pacpi_ops);
+	}
 	return pci_register_driver(&pacpi_pci_driver);
 }
 
Index: work/drivers/ata/pata_ali.c
===================================================================
--- work.orig/drivers/ata/pata_ali.c
+++ work/drivers/ata/pata_ali.c
@@ -669,6 +669,13 @@ static struct pci_driver ali_pci_driver 
 
 static int __init ali_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &ali_sht);
+		ata_dump_ops(DRV_NAME, &ali_early_port_ops);
+		ata_dump_ops(DRV_NAME, &ali_20_port_ops);
+		ata_dump_ops(DRV_NAME, &ali_c2_port_ops);
+		ata_dump_ops(DRV_NAME, &ali_c5_port_ops);
+	}
 	return pci_register_driver(&ali_pci_driver);
 }
 
Index: work/drivers/ata/pata_amd.c
===================================================================
--- work.orig/drivers/ata/pata_amd.c
+++ work/drivers/ata/pata_amd.c
@@ -777,6 +777,15 @@ static struct pci_driver amd_pci_driver 
 
 static int __init amd_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &amd_sht);
+		ata_dump_ops(DRV_NAME, &amd33_port_ops);
+		ata_dump_ops(DRV_NAME, &amd66_port_ops);
+		ata_dump_ops(DRV_NAME, &amd100_port_ops);
+		ata_dump_ops(DRV_NAME, &amd133_port_ops);
+		ata_dump_ops(DRV_NAME, &nv100_port_ops);
+		ata_dump_ops(DRV_NAME, &nv133_port_ops);
+	}
 	return pci_register_driver(&amd_pci_driver);
 }
 
Index: work/drivers/ata/pata_artop.c
===================================================================
--- work.orig/drivers/ata/pata_artop.c
+++ work/drivers/ata/pata_artop.c
@@ -519,6 +519,11 @@ static struct pci_driver artop_pci_drive
 
 static int __init artop_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &artop_sht);
+		ata_dump_ops(DRV_NAME, &artop6210_ops);
+		ata_dump_ops(DRV_NAME, &artop6260_ops);
+	}
 	return pci_register_driver(&artop_pci_driver);
 }
 
Index: work/drivers/ata/pata_at32.c
===================================================================
--- work.orig/drivers/ata/pata_at32.c
+++ work/drivers/ata/pata_at32.c
@@ -424,6 +424,10 @@ static struct platform_driver pata_at32_
 
 static int __init pata_at32_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &at32_sht);
+		ata_dump_ops(DRV_NAME, &at32_port_ops);
+	}
 	return platform_driver_probe(&pata_at32_driver, pata_at32_probe);
 }
 
Index: work/drivers/ata/pata_atiixp.c
===================================================================
--- work.orig/drivers/ata/pata_atiixp.c
+++ work/drivers/ata/pata_atiixp.c
@@ -308,6 +308,10 @@ static struct pci_driver atiixp_pci_driv
 
 static int __init atiixp_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &atiixp_sht);
+		ata_dump_ops(DRV_NAME, &atiixp_port_ops);
+	}
 	return pci_register_driver(&atiixp_pci_driver);
 }
 
Index: work/drivers/ata/pata_bf54x.c
===================================================================
--- work.orig/drivers/ata/pata_bf54x.c
+++ work/drivers/ata/pata_bf54x.c
@@ -1608,6 +1608,10 @@ static int __init bfin_atapi_init(void)
 		bfin_port_info[0].udma_mask = ATA_UDMA5;
 	};
 
+	{
+		ata_dump_sht(DRV_NAME, &bfin_sht);
+		ata_dump_ops(DRV_NAME, &bfin_pata_ops);
+	}
 	return platform_driver_register(&bfin_atapi_driver);
 }
 
Index: work/drivers/ata/pata_cmd640.c
===================================================================
--- work.orig/drivers/ata/pata_cmd640.c
+++ work/drivers/ata/pata_cmd640.c
@@ -298,6 +298,10 @@ static struct pci_driver cmd640_pci_driv
 
 static int __init cmd640_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &cmd640_sht);
+		ata_dump_ops(DRV_NAME, &cmd640_port_ops);
+	}
 	return pci_register_driver(&cmd640_pci_driver);
 }
 
Index: work/drivers/ata/pata_cmd64x.c
===================================================================
--- work.orig/drivers/ata/pata_cmd64x.c
+++ work/drivers/ata/pata_cmd64x.c
@@ -518,6 +518,12 @@ static struct pci_driver cmd64x_pci_driv
 
 static int __init cmd64x_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &cmd64x_sht);
+		ata_dump_ops(DRV_NAME, &cmd64x_port_ops);
+		ata_dump_ops(DRV_NAME, &cmd646r1_port_ops);
+		ata_dump_ops(DRV_NAME, &cmd648_port_ops);
+	}
 	return pci_register_driver(&cmd64x_pci_driver);
 }
 
Index: work/drivers/ata/pata_cs5520.c
===================================================================
--- work.orig/drivers/ata/pata_cs5520.c
+++ work/drivers/ata/pata_cs5520.c
@@ -378,6 +378,10 @@ static struct pci_driver cs5520_pci_driv
 
 static int __init cs5520_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &cs5520_sht);
+		ata_dump_ops(DRV_NAME, &cs5520_port_ops);
+	}
 	return pci_register_driver(&cs5520_pci_driver);
 }
 
Index: work/drivers/ata/pata_cs5530.c
===================================================================
--- work.orig/drivers/ata/pata_cs5530.c
+++ work/drivers/ata/pata_cs5530.c
@@ -404,6 +404,10 @@ static struct pci_driver cs5530_pci_driv
 
 static int __init cs5530_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &cs5530_sht);
+		ata_dump_ops(DRV_NAME, &cs5530_port_ops);
+	}
 	return pci_register_driver(&cs5530_pci_driver);
 }
 
Index: work/drivers/ata/pata_cs5535.c
===================================================================
--- work.orig/drivers/ata/pata_cs5535.c
+++ work/drivers/ata/pata_cs5535.c
@@ -263,6 +263,10 @@ static struct pci_driver cs5535_pci_driv
 
 static int __init cs5535_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &cs5535_sht);
+		ata_dump_ops(DRV_NAME, &cs5535_port_ops);
+	}
 	return pci_register_driver(&cs5535_pci_driver);
 }
 
Index: work/drivers/ata/pata_cs5536.c
===================================================================
--- work.orig/drivers/ata/pata_cs5536.c
+++ work/drivers/ata/pata_cs5536.c
@@ -324,6 +324,10 @@ static struct pci_driver cs5536_pci_driv
 
 static int __init cs5536_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &cs5536_sht);
+		ata_dump_ops(DRV_NAME, &cs5536_port_ops);
+	}
 	return pci_register_driver(&cs5536_pci_driver);
 }
 
Index: work/drivers/ata/pata_cypress.c
===================================================================
--- work.orig/drivers/ata/pata_cypress.c
+++ work/drivers/ata/pata_cypress.c
@@ -200,6 +200,10 @@ static struct pci_driver cy82c693_pci_dr
 
 static int __init cy82c693_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &cy82c693_sht);
+		ata_dump_ops(DRV_NAME, &cy82c693_port_ops);
+	}
 	return pci_register_driver(&cy82c693_pci_driver);
 }
 
Index: work/drivers/ata/pata_efar.c
===================================================================
--- work.orig/drivers/ata/pata_efar.c
+++ work/drivers/ata/pata_efar.c
@@ -336,6 +336,10 @@ static struct pci_driver efar_pci_driver
 
 static int __init efar_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &efar_sht);
+		ata_dump_ops(DRV_NAME, &efar_ops);
+	}
 	return pci_register_driver(&efar_pci_driver);
 }
 
Index: work/drivers/ata/pata_hpt366.c
===================================================================
--- work.orig/drivers/ata/pata_hpt366.c
+++ work/drivers/ata/pata_hpt366.c
@@ -470,6 +470,10 @@ static struct pci_driver hpt36x_pci_driv
 
 static int __init hpt36x_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &hpt36x_sht);
+		ata_dump_ops(DRV_NAME, &hpt366_port_ops);
+	}
 	return pci_register_driver(&hpt36x_pci_driver);
 }
 
Index: work/drivers/ata/pata_hpt37x.c
===================================================================
--- work.orig/drivers/ata/pata_hpt37x.c
+++ work/drivers/ata/pata_hpt37x.c
@@ -1187,6 +1187,13 @@ static struct pci_driver hpt37x_pci_driv
 
 static int __init hpt37x_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &hpt37x_sht);
+		ata_dump_ops(DRV_NAME, &hpt370_port_ops);
+		ata_dump_ops(DRV_NAME, &hpt370a_port_ops);
+		ata_dump_ops(DRV_NAME, &hpt372_port_ops);
+		ata_dump_ops(DRV_NAME, &hpt374_port_ops);
+	}
 	return pci_register_driver(&hpt37x_pci_driver);
 }
 
Index: work/drivers/ata/pata_hpt3x2n.c
===================================================================
--- work.orig/drivers/ata/pata_hpt3x2n.c
+++ work/drivers/ata/pata_hpt3x2n.c
@@ -626,6 +626,10 @@ static struct pci_driver hpt3x2n_pci_dri
 
 static int __init hpt3x2n_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &hpt3x2n_sht);
+		ata_dump_ops(DRV_NAME, &hpt3x2n_port_ops);
+	}
 	return pci_register_driver(&hpt3x2n_pci_driver);
 }
 
Index: work/drivers/ata/pata_hpt3x3.c
===================================================================
--- work.orig/drivers/ata/pata_hpt3x3.c
+++ work/drivers/ata/pata_hpt3x3.c
@@ -281,6 +281,10 @@ static struct pci_driver hpt3x3_pci_driv
 
 static int __init hpt3x3_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &hpt3x3_sht);
+		ata_dump_ops(DRV_NAME, &hpt3x3_port_ops);
+	}
 	return pci_register_driver(&hpt3x3_pci_driver);
 }
 
Index: work/drivers/ata/pata_icside.c
===================================================================
--- work.orig/drivers/ata/pata_icside.c
+++ work/drivers/ata/pata_icside.c
@@ -665,6 +665,10 @@ static struct ecard_driver pata_icside_d
 
 static int __init pata_icside_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &pata_icside_sht);
+		ata_dump_ops(DRV_NAME, &pata_icside_port_ops);
+	}
 	return ecard_register_driver(&pata_icside_driver);
 }
 
Index: work/drivers/ata/pata_isapnp.c
===================================================================
--- work.orig/drivers/ata/pata_isapnp.c
+++ work/drivers/ata/pata_isapnp.c
@@ -155,6 +155,10 @@ static struct pnp_driver isapnp_driver =
 
 static int __init isapnp_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &isapnp_sht);
+		ata_dump_ops(DRV_NAME, &isapnp_port_ops);
+	}
 	return pnp_register_driver(&isapnp_driver);
 }
 
Index: work/drivers/ata/pata_it8213.c
===================================================================
--- work.orig/drivers/ata/pata_it8213.c
+++ work/drivers/ata/pata_it8213.c
@@ -347,6 +347,10 @@ static struct pci_driver it8213_pci_driv
 
 static int __init it8213_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &it8213_sht);
+		ata_dump_ops(DRV_NAME, &it8213_ops);
+	}
 	return pci_register_driver(&it8213_pci_driver);
 }
 
Index: work/drivers/ata/pata_it821x.c
===================================================================
--- work.orig/drivers/ata/pata_it821x.c
+++ work/drivers/ata/pata_it821x.c
@@ -819,6 +819,11 @@ static struct pci_driver it821x_pci_driv
 
 static int __init it821x_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &it821x_sht);
+		ata_dump_ops(DRV_NAME, &it821x_smart_port_ops);
+		ata_dump_ops(DRV_NAME, &it821x_passthru_port_ops);
+	}
 	return pci_register_driver(&it821x_pci_driver);
 }
 
Index: work/drivers/ata/pata_ixp4xx_cf.c
===================================================================
--- work.orig/drivers/ata/pata_ixp4xx_cf.c
+++ work/drivers/ata/pata_ixp4xx_cf.c
@@ -242,6 +242,10 @@ static struct platform_driver ixp4xx_pat
 
 static int __init ixp4xx_pata_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &ixp4xx_sht);
+		ata_dump_ops(DRV_NAME, &ixp4xx_port_ops);
+	}
 	return platform_driver_register(&ixp4xx_pata_platform_driver);
 }
 
Index: work/drivers/ata/pata_jmicron.c
===================================================================
--- work.orig/drivers/ata/pata_jmicron.c
+++ work/drivers/ata/pata_jmicron.c
@@ -222,6 +222,10 @@ static struct pci_driver jmicron_pci_dri
 
 static int __init jmicron_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &jmicron_sht);
+		ata_dump_ops(DRV_NAME, &jmicron_ops);
+	}
 	return pci_register_driver(&jmicron_pci_driver);
 }
 
Index: work/drivers/ata/pata_legacy.c
===================================================================
--- work.orig/drivers/ata/pata_legacy.c
+++ work/drivers/ata/pata_legacy.c
@@ -1507,6 +1507,20 @@ static __init int legacy_init(void)
 	}
 	if (ct != 0)
 		return 0;
+	{
+		ata_dump_sht(DRV_NAME, &legacy_sht);
+		ata_dump_ops(DRV_NAME, &simple_port_ops);
+		ata_dump_ops(DRV_NAME, &legacy_port_ops);
+		ata_dump_ops(DRV_NAME, &pdc20230_port_ops);
+		ata_dump_ops(DRV_NAME, &ht6560a_port_ops);
+		ata_dump_ops(DRV_NAME, &ht6560b_port_ops);
+		ata_dump_ops(DRV_NAME, &opti82c611a_port_ops);
+		ata_dump_ops(DRV_NAME, &opti82c46x_port_ops);
+		ata_dump_ops(DRV_NAME, &qdi6500_port_ops);
+		ata_dump_ops(DRV_NAME, &qdi6580_port_ops);
+		ata_dump_ops(DRV_NAME, &qdi6580dp_port_ops);
+		ata_dump_ops(DRV_NAME, &winbond_port_ops);
+	}
 	return -ENODEV;
 }
 
Index: work/drivers/ata/pata_marvell.c
===================================================================
--- work.orig/drivers/ata/pata_marvell.c
+++ work/drivers/ata/pata_marvell.c
@@ -210,6 +210,10 @@ static struct pci_driver marvell_pci_dri
 
 static int __init marvell_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &marvell_sht);
+		ata_dump_ops(DRV_NAME, &marvell_ops);
+	}
 	return pci_register_driver(&marvell_pci_driver);
 }
 
Index: work/drivers/ata/pata_mpc52xx.c
===================================================================
--- work.orig/drivers/ata/pata_mpc52xx.c
+++ work/drivers/ata/pata_mpc52xx.c
@@ -527,6 +527,10 @@ static int __init
 mpc52xx_ata_init(void)
 {
 	printk(KERN_INFO "ata: MPC52xx IDE/ATA libata driver\n");
+	{
+		ata_dump_sht(DRV_NAME, &mpc52xx_ata_sht);
+		ata_dump_ops(DRV_NAME, &mpc52xx_ata_port_ops);
+	}
 	return of_register_platform_driver(&mpc52xx_ata_of_platform_driver);
 }
 
Index: work/drivers/ata/pata_mpiix.c
===================================================================
--- work.orig/drivers/ata/pata_mpiix.c
+++ work/drivers/ata/pata_mpiix.c
@@ -278,6 +278,10 @@ static struct pci_driver mpiix_pci_drive
 
 static int __init mpiix_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &mpiix_sht);
+		ata_dump_ops(DRV_NAME, &mpiix_port_ops);
+	}
 	return pci_register_driver(&mpiix_pci_driver);
 }
 
Index: work/drivers/ata/pata_netcell.c
===================================================================
--- work.orig/drivers/ata/pata_netcell.c
+++ work/drivers/ata/pata_netcell.c
@@ -137,6 +137,10 @@ static struct pci_driver netcell_pci_dri
 
 static int __init netcell_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &netcell_sht);
+		ata_dump_ops(DRV_NAME, &netcell_ops);
+	}
 	return pci_register_driver(&netcell_pci_driver);
 }
 
Index: work/drivers/ata/pata_ninja32.c
===================================================================
--- work.orig/drivers/ata/pata_ninja32.c
+++ work/drivers/ata/pata_ninja32.c
@@ -196,6 +196,10 @@ static struct pci_driver ninja32_pci_dri
 
 static int __init ninja32_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &ninja32_sht);
+		ata_dump_ops(DRV_NAME, &ninja32_port_ops);
+	}
 	return pci_register_driver(&ninja32_pci_driver);
 }
 
Index: work/drivers/ata/pata_ns87410.c
===================================================================
--- work.orig/drivers/ata/pata_ns87410.c
+++ work/drivers/ata/pata_ns87410.c
@@ -219,6 +219,10 @@ static struct pci_driver ns87410_pci_dri
 
 static int __init ns87410_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &ns87410_sht);
+		ata_dump_ops(DRV_NAME, &ns87410_port_ops);
+	}
 	return pci_register_driver(&ns87410_pci_driver);
 }
 
Index: work/drivers/ata/pata_ns87415.c
===================================================================
--- work.orig/drivers/ata/pata_ns87415.c
+++ work/drivers/ata/pata_ns87415.c
@@ -457,6 +457,11 @@ static struct pci_driver ns87415_pci_dri
 
 static int __init ns87415_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &ns87415_sht);
+		//ata_dump_ops(DRV_NAME, &ns87560_pata_ops);
+		ata_dump_ops(DRV_NAME, &ns87415_pata_ops);
+	}
 	return pci_register_driver(&ns87415_pci_driver);
 }
 
Index: work/drivers/ata/pata_oldpiix.c
===================================================================
--- work.orig/drivers/ata/pata_oldpiix.c
+++ work/drivers/ata/pata_oldpiix.c
@@ -323,6 +323,10 @@ static struct pci_driver oldpiix_pci_dri
 
 static int __init oldpiix_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &oldpiix_sht);
+		ata_dump_ops(DRV_NAME, &oldpiix_pata_ops);
+	}
 	return pci_register_driver(&oldpiix_pci_driver);
 }
 
Index: work/drivers/ata/pata_opti.c
===================================================================
--- work.orig/drivers/ata/pata_opti.c
+++ work/drivers/ata/pata_opti.c
@@ -251,6 +251,10 @@ static struct pci_driver opti_pci_driver
 
 static int __init opti_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &opti_sht);
+		ata_dump_ops(DRV_NAME, &opti_port_ops);
+	}
 	return pci_register_driver(&opti_pci_driver);
 }
 
Index: work/drivers/ata/pata_optidma.c
===================================================================
--- work.orig/drivers/ata/pata_optidma.c
+++ work/drivers/ata/pata_optidma.c
@@ -538,6 +538,11 @@ static struct pci_driver optidma_pci_dri
 
 static int __init optidma_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &optidma_sht);
+		ata_dump_ops(DRV_NAME, &optidma_port_ops);
+		ata_dump_ops(DRV_NAME, &optiplus_port_ops);
+	}
 	return pci_register_driver(&optidma_pci_driver);
 }
 
Index: work/drivers/ata/pata_pcmcia.c
===================================================================
--- work.orig/drivers/ata/pata_pcmcia.c
+++ work/drivers/ata/pata_pcmcia.c
@@ -499,6 +499,11 @@ static struct pcmcia_driver pcmcia_drive
 
 static int __init pcmcia_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &pcmcia_sht);
+		ata_dump_ops(DRV_NAME, &pcmcia_port_ops);
+		ata_dump_ops(DRV_NAME, &pcmcia_8bit_port_ops);
+	}
 	return pcmcia_register_driver(&pcmcia_driver);
 }
 
Index: work/drivers/ata/pata_pdc2027x.c
===================================================================
--- work.orig/drivers/ata/pata_pdc2027x.c
+++ work/drivers/ata/pata_pdc2027x.c
@@ -845,6 +845,11 @@ static int __devinit pdc2027x_init_one(s
  */
 static int __init pdc2027x_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &pdc2027x_sht);
+		ata_dump_ops(DRV_NAME, &pdc2027x_pata100_ops);
+		ata_dump_ops(DRV_NAME, &pdc2027x_pata133_ops);
+	}
 	return pci_register_driver(&pdc2027x_pci_driver);
 }
 
Index: work/drivers/ata/pata_pdc202xx_old.c
===================================================================
--- work.orig/drivers/ata/pata_pdc202xx_old.c
+++ work/drivers/ata/pata_pdc202xx_old.c
@@ -412,6 +412,11 @@ static struct pci_driver pdc202xx_pci_dr
 
 static int __init pdc202xx_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &pdc202xx_sht);
+		ata_dump_ops(DRV_NAME, &pdc2024x_port_ops);
+		ata_dump_ops(DRV_NAME, &pdc2026x_port_ops);
+	}
 	return pci_register_driver(&pdc202xx_pci_driver);
 }
 
Index: work/drivers/ata/pata_platform.c
===================================================================
--- work.orig/drivers/ata/pata_platform.c
+++ work/drivers/ata/pata_platform.c
@@ -263,6 +263,10 @@ static struct platform_driver pata_platf
 
 static int __init pata_platform_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &pata_platform_sht);
+		ata_dump_ops(DRV_NAME, &pata_platform_port_ops);
+	}
 	return platform_driver_register(&pata_platform_driver);
 }
 
Index: work/drivers/ata/pata_qdi.c
===================================================================
--- work.orig/drivers/ata/pata_qdi.c
+++ work/drivers/ata/pata_qdi.c
@@ -390,6 +390,11 @@ static __init int qdi_init(void)
 	}
 	if (ct != 0)
 		return 0;
+	{
+		ata_dump_sht(DRV_NAME, &qdi_sht);
+		ata_dump_ops(DRV_NAME, &qdi6500_port_ops);
+		ata_dump_ops(DRV_NAME, &qdi6580_port_ops);
+	}
 	return -ENODEV;
 }
 
Index: work/drivers/ata/pata_radisys.c
===================================================================
--- work.orig/drivers/ata/pata_radisys.c
+++ work/drivers/ata/pata_radisys.c
@@ -289,6 +289,10 @@ static struct pci_driver radisys_pci_dri
 
 static int __init radisys_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &radisys_sht);
+		ata_dump_ops(DRV_NAME, &radisys_pata_ops);
+	}
 	return pci_register_driver(&radisys_pci_driver);
 }
 
Index: work/drivers/ata/pata_rz1000.c
===================================================================
--- work.orig/drivers/ata/pata_rz1000.c
+++ work/drivers/ata/pata_rz1000.c
@@ -179,6 +179,10 @@ static struct pci_driver rz1000_pci_driv
 
 static int __init rz1000_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &rz1000_sht);
+		ata_dump_ops(DRV_NAME, &rz1000_port_ops);
+	}
 	return pci_register_driver(&rz1000_pci_driver);
 }
 
Index: work/drivers/ata/pata_sc1200.c
===================================================================
--- work.orig/drivers/ata/pata_sc1200.c
+++ work/drivers/ata/pata_sc1200.c
@@ -274,6 +274,10 @@ static struct pci_driver sc1200_pci_driv
 
 static int __init sc1200_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &sc1200_sht);
+		ata_dump_ops(DRV_NAME, &sc1200_port_ops);
+	}
 	return pci_register_driver(&sc1200_pci_driver);
 }
 
Index: work/drivers/ata/pata_scc.c
===================================================================
--- work.orig/drivers/ata/pata_scc.c
+++ work/drivers/ata/pata_scc.c
@@ -1189,6 +1189,10 @@ static int __init scc_init (void)
 		return rc;
 
 	DPRINTK("done\n");
+	{
+		ata_dump_sht(DRV_NAME, &scc_sht);
+		ata_dump_ops(DRV_NAME, &scc_pata_ops);
+	}
 	return 0;
 }
 
Index: work/drivers/ata/pata_serverworks.c
===================================================================
--- work.orig/drivers/ata/pata_serverworks.c
+++ work/drivers/ata/pata_serverworks.c
@@ -594,6 +594,11 @@ static struct pci_driver serverworks_pci
 
 static int __init serverworks_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &serverworks_sht);
+		ata_dump_ops(DRV_NAME, &serverworks_osb4_port_ops);
+		ata_dump_ops(DRV_NAME, &serverworks_csb_port_ops);
+	}
 	return pci_register_driver(&serverworks_pci_driver);
 }
 
Index: work/drivers/ata/pata_sil680.c
===================================================================
--- work.orig/drivers/ata/pata_sil680.c
+++ work/drivers/ata/pata_sil680.c
@@ -437,6 +437,10 @@ static struct pci_driver sil680_pci_driv
 
 static int __init sil680_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &sil680_sht);
+		ata_dump_ops(DRV_NAME, &sil680_port_ops);
+	}
 	return pci_register_driver(&sil680_pci_driver);
 }
 
Index: work/drivers/ata/pata_sis.c
===================================================================
--- work.orig/drivers/ata/pata_sis.c
+++ work/drivers/ata/pata_sis.c
@@ -1027,6 +1027,15 @@ static struct pci_driver sis_pci_driver 
 
 static int __init sis_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &sis_sht);
+		ata_dump_ops(DRV_NAME, &sis_133_ops);
+		ata_dump_ops(DRV_NAME, &sis_133_for_sata_ops);
+		ata_dump_ops(DRV_NAME, &sis_133_early_ops);
+		ata_dump_ops(DRV_NAME, &sis_100_ops);
+		ata_dump_ops(DRV_NAME, &sis_66_ops);
+		ata_dump_ops(DRV_NAME, &sis_old_ops);
+	}
 	return pci_register_driver(&sis_pci_driver);
 }
 
Index: work/drivers/ata/pata_sl82c105.c
===================================================================
--- work.orig/drivers/ata/pata_sl82c105.c
+++ work/drivers/ata/pata_sl82c105.c
@@ -352,6 +352,10 @@ static struct pci_driver sl82c105_pci_dr
 
 static int __init sl82c105_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &sl82c105_sht);
+		ata_dump_ops(DRV_NAME, &sl82c105_port_ops);
+	}
 	return pci_register_driver(&sl82c105_pci_driver);
 }
 
Index: work/drivers/ata/pata_triflex.c
===================================================================
--- work.orig/drivers/ata/pata_triflex.c
+++ work/drivers/ata/pata_triflex.c
@@ -267,6 +267,10 @@ static struct pci_driver triflex_pci_dri
 
 static int __init triflex_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &triflex_sht);
+		ata_dump_ops(DRV_NAME, &triflex_port_ops);
+	}
 	return pci_register_driver(&triflex_pci_driver);
 }
 
Index: work/drivers/ata/pata_via.c
===================================================================
--- work.orig/drivers/ata/pata_via.c
+++ work/drivers/ata/pata_via.c
@@ -665,6 +665,11 @@ static struct pci_driver via_pci_driver 
 
 static int __init via_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &via_sht);
+		ata_dump_ops(DRV_NAME, &via_port_ops);
+		ata_dump_ops(DRV_NAME, &via_port_ops_noirq);
+	}
 	return pci_register_driver(&via_pci_driver);
 }
 
Index: work/drivers/ata/pata_winbond.c
===================================================================
--- work.orig/drivers/ata/pata_winbond.c
+++ work/drivers/ata/pata_winbond.c
@@ -289,6 +289,10 @@ static __init int winbond_init(void)
 	}
 	if (ct != 0)
 		return 0;
+	{
+		ata_dump_sht(DRV_NAME, &winbond_sht);
+		ata_dump_ops(DRV_NAME, &winbond_port_ops);
+	}
 	return -ENODEV;
 }
 
Index: work/drivers/ata/pdc_adma.c
===================================================================
--- work.orig/drivers/ata/pdc_adma.c
+++ work/drivers/ata/pdc_adma.c
@@ -723,6 +723,10 @@ static int adma_ata_init_one(struct pci_
 
 static int __init adma_ata_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &adma_ata_sht);
+		ata_dump_ops(DRV_NAME, &adma_ata_ops);
+	}
 	return pci_register_driver(&adma_ata_pci_driver);
 }
 
Index: work/drivers/ata/sata_fsl.c
===================================================================
--- work.orig/drivers/ata/sata_fsl.c
+++ work/drivers/ata/sata_fsl.c
@@ -1373,6 +1373,10 @@ static struct of_platform_driver fsl_sat
 static int __init sata_fsl_init(void)
 {
 	of_register_platform_driver(&fsl_sata_driver);
+	{
+		ata_dump_sht(DRV_NAME, &sata_fsl_sht);
+		ata_dump_ops(DRV_NAME, &sata_fsl_ops);
+	}
 	return 0;
 }
 
Index: work/drivers/ata/sata_inic162x.c
===================================================================
--- work.orig/drivers/ata/sata_inic162x.c
+++ work/drivers/ata/sata_inic162x.c
@@ -755,6 +755,10 @@ static struct pci_driver inic_pci_driver
 
 static int __init inic_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &inic_sht);
+		ata_dump_ops(DRV_NAME, &inic_port_ops);
+	}
 	return pci_register_driver(&inic_pci_driver);
 }
 
Index: work/drivers/ata/sata_mv.c
===================================================================
--- work.orig/drivers/ata/sata_mv.c
+++ work/drivers/ata/sata_mv.c
@@ -2755,6 +2755,13 @@ static int mv_init_one(struct pci_dev *p
 
 static int __init mv_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &mv5_sht);
+		ata_dump_sht(DRV_NAME, &mv6_sht);
+		ata_dump_ops(DRV_NAME, &mv5_ops);
+		ata_dump_ops(DRV_NAME, &mv6_ops);
+		ata_dump_ops(DRV_NAME, &mv_iie_ops);
+	}
 	return pci_register_driver(&mv_pci_driver);
 }
 
Index: work/drivers/ata/sata_nv.c
===================================================================
--- work.orig/drivers/ata/sata_nv.c
+++ work/drivers/ata/sata_nv.c
@@ -2529,6 +2529,16 @@ static void nv_adma_host_stop(struct ata
 
 static int __init nv_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &nv_sht);
+		ata_dump_sht(DRV_NAME, &nv_adma_sht);
+		ata_dump_sht(DRV_NAME, &nv_swncq_sht);
+		ata_dump_ops(DRV_NAME, &nv_generic_ops);
+		ata_dump_ops(DRV_NAME, &nv_nf2_ops);
+		ata_dump_ops(DRV_NAME, &nv_ck804_ops);
+		ata_dump_ops(DRV_NAME, &nv_adma_ops);
+		ata_dump_ops(DRV_NAME, &nv_swncq_ops);
+	}
 	return pci_register_driver(&nv_pci_driver);
 }
 
Index: work/drivers/ata/sata_promise.c
===================================================================
--- work.orig/drivers/ata/sata_promise.c
+++ work/drivers/ata/sata_promise.c
@@ -1106,6 +1106,12 @@ static int pdc_ata_init_one(struct pci_d
 
 static int __init pdc_ata_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &pdc_ata_sht);
+		ata_dump_ops(DRV_NAME, &pdc_sata_ops);
+		ata_dump_ops(DRV_NAME, &pdc_old_sata_ops);
+		ata_dump_ops(DRV_NAME, &pdc_pata_ops);
+	}
 	return pci_register_driver(&pdc_ata_pci_driver);
 }
 
Index: work/drivers/ata/sata_qstor.c
===================================================================
--- work.orig/drivers/ata/sata_qstor.c
+++ work/drivers/ata/sata_qstor.c
@@ -677,6 +677,10 @@ static int qs_ata_init_one(struct pci_de
 
 static int __init qs_ata_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &qs_ata_sht);
+		ata_dump_ops(DRV_NAME, &qs_ata_ops);
+	}
 	return pci_register_driver(&qs_ata_pci_driver);
 }
 
Index: work/drivers/ata/sata_sil.c
===================================================================
--- work.orig/drivers/ata/sata_sil.c
+++ work/drivers/ata/sata_sil.c
@@ -719,6 +719,10 @@ static int sil_pci_device_resume(struct 
 
 static int __init sil_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &sil_sht);
+		ata_dump_ops(DRV_NAME, &sil_ops);
+	}
 	return pci_register_driver(&sil_pci_driver);
 }
 
Index: work/drivers/ata/sata_sil24.c
===================================================================
--- work.orig/drivers/ata/sata_sil24.c
+++ work/drivers/ata/sata_sil24.c
@@ -1412,6 +1412,10 @@ static int sil24_port_resume(struct ata_
 
 static int __init sil24_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &sil24_sht);
+		ata_dump_ops(DRV_NAME, &sil24_ops);
+	}
 	return pci_register_driver(&sil24_pci_driver);
 }
 
Index: work/drivers/ata/sata_sis.c
===================================================================
--- work.orig/drivers/ata/sata_sis.c
+++ work/drivers/ata/sata_sis.c
@@ -366,6 +366,10 @@ static int sis_init_one(struct pci_dev *
 
 static int __init sis_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &sis_sht);
+		ata_dump_ops(DRV_NAME, &sis_ops);
+	}
 	return pci_register_driver(&sis_pci_driver);
 }
 
Index: work/drivers/ata/sata_svw.c
===================================================================
--- work.orig/drivers/ata/sata_svw.c
+++ work/drivers/ata/sata_svw.c
@@ -502,6 +502,10 @@ static struct pci_driver k2_sata_pci_dri
 
 static int __init k2_sata_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &k2_sata_sht);
+		ata_dump_ops(DRV_NAME, &k2_sata_ops);
+	}
 	return pci_register_driver(&k2_sata_pci_driver);
 }
 
Index: work/drivers/ata/sata_sx4.c
===================================================================
--- work.orig/drivers/ata/sata_sx4.c
+++ work/drivers/ata/sata_sx4.c
@@ -1444,6 +1444,10 @@ static int pdc_sata_init_one(struct pci_
 
 static int __init pdc_sata_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &pdc_sata_sht);
+		ata_dump_ops(DRV_NAME, &pdc_20621_ops);
+	}
 	return pci_register_driver(&pdc_sata_pci_driver);
 }
 
Index: work/drivers/ata/sata_uli.c
===================================================================
--- work.orig/drivers/ata/sata_uli.c
+++ work/drivers/ata/sata_uli.c
@@ -286,6 +286,10 @@ static int uli_init_one(struct pci_dev *
 
 static int __init uli_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &uli_sht);
+		ata_dump_ops(DRV_NAME, &uli_ops);
+	}
 	return pci_register_driver(&uli_pci_driver);
 }
 
Index: work/drivers/ata/sata_via.c
===================================================================
--- work.orig/drivers/ata/sata_via.c
+++ work/drivers/ata/sata_via.c
@@ -550,6 +550,12 @@ static int svia_init_one(struct pci_dev 
 
 static int __init svia_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &svia_sht);
+		ata_dump_ops(DRV_NAME, &vt6420_sata_ops);
+		ata_dump_ops(DRV_NAME, &vt6421_pata_ops);
+		ata_dump_ops(DRV_NAME, &vt6421_sata_ops);
+	}
 	return pci_register_driver(&svia_pci_driver);
 }
 
Index: work/drivers/ata/sata_vsc.c
===================================================================
--- work.orig/drivers/ata/sata_vsc.c
+++ work/drivers/ata/sata_vsc.c
@@ -472,6 +472,10 @@ static struct pci_driver vsc_sata_pci_dr
 
 static int __init vsc_sata_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &vsc_sata_sht);
+		ata_dump_ops(DRV_NAME, &vsc_sata_ops);
+	}
 	return pci_register_driver(&vsc_sata_pci_driver);
 }
 
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -790,6 +790,9 @@ static inline int ata_port_is_dummy(stru
 	return ap->ops == &ata_dummy_port_ops;
 }
 
+extern void ata_dump_sht(const char *drv_name, const struct scsi_host_template *sht);
+extern void ata_dump_ops(const char *drv_name, const struct ata_port_operations *ops);
+
 extern void sata_print_link_status(struct ata_link *link);
 extern void ata_port_probe(struct ata_port *);
 extern void ata_bus_reset(struct ata_port *ap);
Index: work/kernel/kallsyms.c
===================================================================
--- work.orig/kernel/kallsyms.c
+++ work/kernel/kallsyms.c
@@ -291,6 +291,7 @@ int lookup_symbol_name(unsigned long add
 	/* see if it's in a module */
 	return lookup_module_symbol_name(addr, symname);
 }
+EXPORT_SYMBOL_GPL(lookup_symbol_name);
 
 int lookup_symbol_attrs(unsigned long addr, unsigned long *size,
 			unsigned long *offset, char *modname, char *name)

--------------020203070305040007040100
Content-Type: text/plain;
 name="verify-after"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="verify-after"

---
 drivers/ata/ahci.c              |    6 ++++
 drivers/ata/ata_generic.c       |    4 +++
 drivers/ata/ata_piix.c          |    8 ++++++
 drivers/ata/libata-core.c       |   52 ++++++++++++++++++++++++++++++++++++++++
 drivers/ata/pata_acpi.c         |    4 +++
 drivers/ata/pata_ali.c          |    8 ++++++
 drivers/ata/pata_amd.c          |   11 ++++++++
 drivers/ata/pata_artop.c        |    5 +++
 drivers/ata/pata_at32.c         |    4 +++
 drivers/ata/pata_atiixp.c       |    4 +++
 drivers/ata/pata_bf54x.c        |    4 +++
 drivers/ata/pata_cmd640.c       |    4 +++
 drivers/ata/pata_cmd64x.c       |    7 +++++
 drivers/ata/pata_cs5520.c       |    4 +++
 drivers/ata/pata_cs5530.c       |    4 +++
 drivers/ata/pata_cs5535.c       |    4 +++
 drivers/ata/pata_cs5536.c       |    4 +++
 drivers/ata/pata_cypress.c      |    4 +++
 drivers/ata/pata_efar.c         |    4 +++
 drivers/ata/pata_hpt366.c       |    4 +++
 drivers/ata/pata_hpt37x.c       |    7 +++++
 drivers/ata/pata_hpt3x2n.c      |    4 +++
 drivers/ata/pata_hpt3x3.c       |    4 +++
 drivers/ata/pata_icside.c       |    4 +++
 drivers/ata/pata_isapnp.c       |    4 +++
 drivers/ata/pata_it8213.c       |    4 +++
 drivers/ata/pata_it821x.c       |    5 +++
 drivers/ata/pata_ixp4xx_cf.c    |    4 +++
 drivers/ata/pata_jmicron.c      |    4 +++
 drivers/ata/pata_legacy.c       |   14 ++++++++++
 drivers/ata/pata_marvell.c      |    4 +++
 drivers/ata/pata_mpc52xx.c      |    4 +++
 drivers/ata/pata_mpiix.c        |    4 +++
 drivers/ata/pata_netcell.c      |    4 +++
 drivers/ata/pata_ninja32.c      |    4 +++
 drivers/ata/pata_ns87410.c      |    4 +++
 drivers/ata/pata_ns87415.c      |    5 +++
 drivers/ata/pata_oldpiix.c      |    4 +++
 drivers/ata/pata_opti.c         |    4 +++
 drivers/ata/pata_optidma.c      |    5 +++
 drivers/ata/pata_pcmcia.c       |    5 +++
 drivers/ata/pata_pdc2027x.c     |    5 +++
 drivers/ata/pata_pdc202xx_old.c |    5 +++
 drivers/ata/pata_platform.c     |    4 +++
 drivers/ata/pata_qdi.c          |    5 +++
 drivers/ata/pata_radisys.c      |    4 +++
 drivers/ata/pata_rz1000.c       |    4 +++
 drivers/ata/pata_sc1200.c       |    4 +++
 drivers/ata/pata_scc.c          |    4 +++
 drivers/ata/pata_serverworks.c  |    5 +++
 drivers/ata/pata_sil680.c       |    4 +++
 drivers/ata/pata_sis.c          |   10 +++++++
 drivers/ata/pata_sl82c105.c     |    4 +++
 drivers/ata/pata_triflex.c      |    4 +++
 drivers/ata/pata_via.c          |    5 +++
 drivers/ata/pata_winbond.c      |    4 +++
 drivers/ata/pdc_adma.c          |    4 +++
 drivers/ata/sata_fsl.c          |    4 +++
 drivers/ata/sata_inic162x.c     |    4 +++
 drivers/ata/sata_mv.c           |    7 +++++
 drivers/ata/sata_nv.c           |   10 +++++++
 drivers/ata/sata_promise.c      |    7 +++++
 drivers/ata/sata_qstor.c        |    4 +++
 drivers/ata/sata_sil.c          |    4 +++
 drivers/ata/sata_sil24.c        |    4 +++
 drivers/ata/sata_sis.c          |    4 +++
 drivers/ata/sata_svw.c          |    4 +++
 drivers/ata/sata_sx4.c          |    4 +++
 drivers/ata/sata_uli.c          |    4 +++
 drivers/ata/sata_via.c          |    6 ++++
 drivers/ata/sata_vsc.c          |    4 +++
 include/linux/libata.h          |    3 ++
 kernel/kallsyms.c               |    1 
 73 files changed, 399 insertions(+)

Index: work/drivers/ata/ahci.c
===================================================================
--- work.orig/drivers/ata/ahci.c
+++ work/drivers/ata/ahci.c
@@ -2212,6 +2212,12 @@ static int ahci_init_one(struct pci_dev 
 
 static int __init ahci_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &ahci_sht);
+		ata_dump_ops(DRV_NAME, &ahci_ops);
+		ata_dump_ops(DRV_NAME, &ahci_vt8251_ops);
+		ata_dump_ops(DRV_NAME, &ahci_p5wdh_ops);
+	}
 	return pci_register_driver(&ahci_pci_driver);
 }
 
Index: work/drivers/ata/ata_generic.c
===================================================================
--- work.orig/drivers/ata/ata_generic.c
+++ work/drivers/ata/ata_generic.c
@@ -187,6 +187,10 @@ static struct pci_driver ata_generic_pci
 
 static int __init ata_generic_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &generic_sht);
+		ata_dump_ops(DRV_NAME, &generic_port_ops);
+	}
 	return pci_register_driver(&ata_generic_pci_driver);
 }
 
Index: work/drivers/ata/ata_piix.c
===================================================================
--- work.orig/drivers/ata/ata_piix.c
+++ work/drivers/ata/ata_piix.c
@@ -1558,6 +1558,14 @@ static int __init piix_init(void)
 	in_module_init = 0;
 
 	DPRINTK("done\n");
+	{
+		ata_dump_sht(DRV_NAME, &piix_sht);
+		ata_dump_ops(DRV_NAME, &piix_pata_ops);
+		ata_dump_ops(DRV_NAME, &piix_vmw_ops);
+		ata_dump_ops(DRV_NAME, &ich_pata_ops);
+		ata_dump_ops(DRV_NAME, &piix_sata_ops);
+		ata_dump_ops(DRV_NAME, &piix_sidpr_sata_ops);
+	}
 	return 0;
 }
 
Index: work/drivers/ata/pata_acpi.c
===================================================================
--- work.orig/drivers/ata/pata_acpi.c
+++ work/drivers/ata/pata_acpi.c
@@ -295,6 +295,10 @@ static struct pci_driver pacpi_pci_drive
 
 static int __init pacpi_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &pacpi_sht);
+		ata_dump_ops(DRV_NAME, &pacpi_ops);
+	}
 	return pci_register_driver(&pacpi_pci_driver);
 }
 
Index: work/drivers/ata/pata_ali.c
===================================================================
--- work.orig/drivers/ata/pata_ali.c
+++ work/drivers/ata/pata_ali.c
@@ -557,6 +557,14 @@ static struct pci_driver ali_pci_driver 
 
 static int __init ali_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &ali_sht);
+		ata_dump_ops(DRV_NAME, &ali_early_port_ops);
+		ata_dump_ops(DRV_NAME, &ali_dma_base_ops);
+		ata_dump_ops(DRV_NAME, &ali_20_port_ops);
+		ata_dump_ops(DRV_NAME, &ali_c2_port_ops);
+		ata_dump_ops(DRV_NAME, &ali_c5_port_ops);
+	}
 	return pci_register_driver(&ali_pci_driver);
 }
 
Index: work/drivers/ata/pata_amd.c
===================================================================
--- work.orig/drivers/ata/pata_amd.c
+++ work/drivers/ata/pata_amd.c
@@ -614,6 +614,17 @@ static struct pci_driver amd_pci_driver 
 
 static int __init amd_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &amd_sht);
+		ata_dump_ops(DRV_NAME, &amd_base_port_ops);
+		ata_dump_ops(DRV_NAME, &amd33_port_ops);
+		ata_dump_ops(DRV_NAME, &amd66_port_ops);
+		ata_dump_ops(DRV_NAME, &amd100_port_ops);
+		ata_dump_ops(DRV_NAME, &amd133_port_ops);
+		ata_dump_ops(DRV_NAME, &nv_base_port_ops);
+		ata_dump_ops(DRV_NAME, &nv100_port_ops);
+		ata_dump_ops(DRV_NAME, &nv133_port_ops);
+	}
 	return pci_register_driver(&amd_pci_driver);
 }
 
Index: work/drivers/ata/pata_artop.c
===================================================================
--- work.orig/drivers/ata/pata_artop.c
+++ work/drivers/ata/pata_artop.c
@@ -456,6 +456,11 @@ static struct pci_driver artop_pci_drive
 
 static int __init artop_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &artop_sht);
+		ata_dump_ops(DRV_NAME, &artop6210_ops);
+		ata_dump_ops(DRV_NAME, &artop6260_ops);
+	}
 	return pci_register_driver(&artop_pci_driver);
 }
 
Index: work/drivers/ata/pata_at32.c
===================================================================
--- work.orig/drivers/ata/pata_at32.c
+++ work/drivers/ata/pata_at32.c
@@ -391,6 +391,10 @@ static struct platform_driver pata_at32_
 
 static int __init pata_at32_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &at32_sht);
+		ata_dump_ops(DRV_NAME, &at32_port_ops);
+	}
 	return platform_driver_probe(&pata_at32_driver, pata_at32_probe);
 }
 
Index: work/drivers/ata/pata_atiixp.c
===================================================================
--- work.orig/drivers/ata/pata_atiixp.c
+++ work/drivers/ata/pata_atiixp.c
@@ -273,6 +273,10 @@ static struct pci_driver atiixp_pci_driv
 
 static int __init atiixp_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &atiixp_sht);
+		ata_dump_ops(DRV_NAME, &atiixp_port_ops);
+	}
 	return pci_register_driver(&atiixp_pci_driver);
 }
 
Index: work/drivers/ata/pata_bf54x.c
===================================================================
--- work.orig/drivers/ata/pata_bf54x.c
+++ work/drivers/ata/pata_bf54x.c
@@ -1596,6 +1596,10 @@ static int __init bfin_atapi_init(void)
 		bfin_port_info[0].udma_mask = ATA_UDMA5;
 	};
 
+	{
+		ata_dump_sht(DRV_NAME, &bfin_sht);
+		ata_dump_ops(DRV_NAME, &bfin_pata_ops);
+	}
 	return platform_driver_register(&bfin_atapi_driver);
 }
 
Index: work/drivers/ata/pata_cmd640.c
===================================================================
--- work.orig/drivers/ata/pata_cmd640.c
+++ work/drivers/ata/pata_cmd640.c
@@ -261,6 +261,10 @@ static struct pci_driver cmd640_pci_driv
 
 static int __init cmd640_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &cmd640_sht);
+		ata_dump_ops(DRV_NAME, &cmd640_port_ops);
+	}
 	return pci_register_driver(&cmd640_pci_driver);
 }
 
Index: work/drivers/ata/pata_cmd64x.c
===================================================================
--- work.orig/drivers/ata/pata_cmd64x.c
+++ work/drivers/ata/pata_cmd64x.c
@@ -428,6 +428,13 @@ static struct pci_driver cmd64x_pci_driv
 
 static int __init cmd64x_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &cmd64x_sht);
+		ata_dump_ops(DRV_NAME, &cmd64x_base_ops);
+		ata_dump_ops(DRV_NAME, &cmd64x_port_ops);
+		ata_dump_ops(DRV_NAME, &cmd646r1_port_ops);
+		ata_dump_ops(DRV_NAME, &cmd648_port_ops);
+	}
 	return pci_register_driver(&cmd64x_pci_driver);
 }
 
Index: work/drivers/ata/pata_cs5520.c
===================================================================
--- work.orig/drivers/ata/pata_cs5520.c
+++ work/drivers/ata/pata_cs5520.c
@@ -342,6 +342,10 @@ static struct pci_driver cs5520_pci_driv
 
 static int __init cs5520_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &cs5520_sht);
+		ata_dump_ops(DRV_NAME, &cs5520_port_ops);
+	}
 	return pci_register_driver(&cs5520_pci_driver);
 }
 
Index: work/drivers/ata/pata_cs5530.c
===================================================================
--- work.orig/drivers/ata/pata_cs5530.c
+++ work/drivers/ata/pata_cs5530.c
@@ -368,6 +368,10 @@ static struct pci_driver cs5530_pci_driv
 
 static int __init cs5530_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &cs5530_sht);
+		ata_dump_ops(DRV_NAME, &cs5530_port_ops);
+	}
 	return pci_register_driver(&cs5530_pci_driver);
 }
 
Index: work/drivers/ata/pata_cs5535.c
===================================================================
--- work.orig/drivers/ata/pata_cs5535.c
+++ work/drivers/ata/pata_cs5535.c
@@ -222,6 +222,10 @@ static struct pci_driver cs5535_pci_driv
 
 static int __init cs5535_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &cs5535_sht);
+		ata_dump_ops(DRV_NAME, &cs5535_port_ops);
+	}
 	return pci_register_driver(&cs5535_pci_driver);
 }
 
Index: work/drivers/ata/pata_cs5536.c
===================================================================
--- work.orig/drivers/ata/pata_cs5536.c
+++ work/drivers/ata/pata_cs5536.c
@@ -283,6 +283,10 @@ static struct pci_driver cs5536_pci_driv
 
 static int __init cs5536_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &cs5536_sht);
+		ata_dump_ops(DRV_NAME, &cs5536_port_ops);
+	}
 	return pci_register_driver(&cs5536_pci_driver);
 }
 
Index: work/drivers/ata/pata_cypress.c
===================================================================
--- work.orig/drivers/ata/pata_cypress.c
+++ work/drivers/ata/pata_cypress.c
@@ -159,6 +159,10 @@ static struct pci_driver cy82c693_pci_dr
 
 static int __init cy82c693_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &cy82c693_sht);
+		ata_dump_ops(DRV_NAME, &cy82c693_port_ops);
+	}
 	return pci_register_driver(&cy82c693_pci_driver);
 }
 
Index: work/drivers/ata/pata_efar.c
===================================================================
--- work.orig/drivers/ata/pata_efar.c
+++ work/drivers/ata/pata_efar.c
@@ -298,6 +298,10 @@ static struct pci_driver efar_pci_driver
 
 static int __init efar_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &efar_sht);
+		ata_dump_ops(DRV_NAME, &efar_ops);
+	}
 	return pci_register_driver(&efar_pci_driver);
 }
 
Index: work/drivers/ata/pata_hpt366.c
===================================================================
--- work.orig/drivers/ata/pata_hpt366.c
+++ work/drivers/ata/pata_hpt366.c
@@ -430,6 +430,10 @@ static struct pci_driver hpt36x_pci_driv
 
 static int __init hpt36x_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &hpt36x_sht);
+		ata_dump_ops(DRV_NAME, &hpt366_port_ops);
+	}
 	return pci_register_driver(&hpt36x_pci_driver);
 }
 
Index: work/drivers/ata/pata_hpt37x.c
===================================================================
--- work.orig/drivers/ata/pata_hpt37x.c
+++ work/drivers/ata/pata_hpt37x.c
@@ -1073,6 +1073,13 @@ static struct pci_driver hpt37x_pci_driv
 
 static int __init hpt37x_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &hpt37x_sht);
+		ata_dump_ops(DRV_NAME, &hpt370_port_ops);
+		ata_dump_ops(DRV_NAME, &hpt370a_port_ops);
+		ata_dump_ops(DRV_NAME, &hpt372_port_ops);
+		ata_dump_ops(DRV_NAME, &hpt374_port_ops);
+	}
 	return pci_register_driver(&hpt37x_pci_driver);
 }
 
Index: work/drivers/ata/pata_hpt3x2n.c
===================================================================
--- work.orig/drivers/ata/pata_hpt3x2n.c
+++ work/drivers/ata/pata_hpt3x2n.c
@@ -590,6 +590,10 @@ static struct pci_driver hpt3x2n_pci_dri
 
 static int __init hpt3x2n_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &hpt3x2n_sht);
+		ata_dump_ops(DRV_NAME, &hpt3x2n_port_ops);
+	}
 	return pci_register_driver(&hpt3x2n_pci_driver);
 }
 
Index: work/drivers/ata/pata_hpt3x3.c
===================================================================
--- work.orig/drivers/ata/pata_hpt3x3.c
+++ work/drivers/ata/pata_hpt3x3.c
@@ -240,6 +240,10 @@ static struct pci_driver hpt3x3_pci_driv
 
 static int __init hpt3x3_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &hpt3x3_sht);
+		ata_dump_ops(DRV_NAME, &hpt3x3_port_ops);
+	}
 	return pci_register_driver(&hpt3x3_pci_driver);
 }
 
Index: work/drivers/ata/pata_icside.c
===================================================================
--- work.orig/drivers/ata/pata_icside.c
+++ work/drivers/ata/pata_icside.c
@@ -637,6 +637,10 @@ static struct ecard_driver pata_icside_d
 
 static int __init pata_icside_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &pata_icside_sht);
+		ata_dump_ops(DRV_NAME, &pata_icside_port_ops);
+	}
 	return ecard_register_driver(&pata_icside_driver);
 }
 
Index: work/drivers/ata/pata_isapnp.c
===================================================================
--- work.orig/drivers/ata/pata_isapnp.c
+++ work/drivers/ata/pata_isapnp.c
@@ -122,6 +122,10 @@ static struct pnp_driver isapnp_driver =
 
 static int __init isapnp_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &isapnp_sht);
+		ata_dump_ops(DRV_NAME, &isapnp_port_ops);
+	}
 	return pnp_register_driver(&isapnp_driver);
 }
 
Index: work/drivers/ata/pata_it8213.c
===================================================================
--- work.orig/drivers/ata/pata_it8213.c
+++ work/drivers/ata/pata_it8213.c
@@ -310,6 +310,10 @@ static struct pci_driver it8213_pci_driv
 
 static int __init it8213_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &it8213_sht);
+		ata_dump_ops(DRV_NAME, &it8213_ops);
+	}
 	return pci_register_driver(&it8213_pci_driver);
 }
 
Index: work/drivers/ata/pata_it821x.c
===================================================================
--- work.orig/drivers/ata/pata_it821x.c
+++ work/drivers/ata/pata_it821x.c
@@ -764,6 +764,11 @@ static struct pci_driver it821x_pci_driv
 
 static int __init it821x_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &it821x_sht);
+		ata_dump_ops(DRV_NAME, &it821x_smart_port_ops);
+		ata_dump_ops(DRV_NAME, &it821x_passthru_port_ops);
+	}
 	return pci_register_driver(&it821x_pci_driver);
 }
 
Index: work/drivers/ata/pata_ixp4xx_cf.c
===================================================================
--- work.orig/drivers/ata/pata_ixp4xx_cf.c
+++ work/drivers/ata/pata_ixp4xx_cf.c
@@ -209,6 +209,10 @@ static struct platform_driver ixp4xx_pat
 
 static int __init ixp4xx_pata_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &ixp4xx_sht);
+		ata_dump_ops(DRV_NAME, &ixp4xx_port_ops);
+	}
 	return platform_driver_register(&ixp4xx_pata_platform_driver);
 }
 
Index: work/drivers/ata/pata_jmicron.c
===================================================================
--- work.orig/drivers/ata/pata_jmicron.c
+++ work/drivers/ata/pata_jmicron.c
@@ -180,6 +180,10 @@ static struct pci_driver jmicron_pci_dri
 
 static int __init jmicron_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &jmicron_sht);
+		ata_dump_ops(DRV_NAME, &jmicron_ops);
+	}
 	return pci_register_driver(&jmicron_pci_driver);
 }
 
Index: work/drivers/ata/pata_legacy.c
===================================================================
--- work.orig/drivers/ata/pata_legacy.c
+++ work/drivers/ata/pata_legacy.c
@@ -1267,6 +1267,20 @@ static __init int legacy_init(void)
 	}
 	if (ct != 0)
 		return 0;
+	{
+		ata_dump_sht(DRV_NAME, &legacy_sht);
+		ata_dump_ops(DRV_NAME, &simple_port_ops);
+		ata_dump_ops(DRV_NAME, &legacy_port_ops);
+		ata_dump_ops(DRV_NAME, &pdc20230_port_ops);
+		ata_dump_ops(DRV_NAME, &ht6560a_port_ops);
+		ata_dump_ops(DRV_NAME, &ht6560b_port_ops);
+		ata_dump_ops(DRV_NAME, &opti82c611a_port_ops);
+		ata_dump_ops(DRV_NAME, &opti82c46x_port_ops);
+		ata_dump_ops(DRV_NAME, &qdi6500_port_ops);
+		ata_dump_ops(DRV_NAME, &qdi6580_port_ops);
+		ata_dump_ops(DRV_NAME, &qdi6580dp_port_ops);
+		ata_dump_ops(DRV_NAME, &winbond_port_ops);
+	}
 	return -ENODEV;
 }
 
Index: work/drivers/ata/pata_marvell.c
===================================================================
--- work.orig/drivers/ata/pata_marvell.c
+++ work/drivers/ata/pata_marvell.c
@@ -168,6 +168,10 @@ static struct pci_driver marvell_pci_dri
 
 static int __init marvell_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &marvell_sht);
+		ata_dump_ops(DRV_NAME, &marvell_ops);
+	}
 	return pci_register_driver(&marvell_pci_driver);
 }
 
Index: work/drivers/ata/pata_mpc52xx.c
===================================================================
--- work.orig/drivers/ata/pata_mpc52xx.c
+++ work/drivers/ata/pata_mpc52xx.c
@@ -503,6 +503,10 @@ static int __init
 mpc52xx_ata_init(void)
 {
 	printk(KERN_INFO "ata: MPC52xx IDE/ATA libata driver\n");
+	{
+		ata_dump_sht(DRV_NAME, &mpc52xx_ata_sht);
+		ata_dump_ops(DRV_NAME, &mpc52xx_ata_port_ops);
+	}
 	return of_register_platform_driver(&mpc52xx_ata_of_platform_driver);
 }
 
Index: work/drivers/ata/pata_mpiix.c
===================================================================
--- work.orig/drivers/ata/pata_mpiix.c
+++ work/drivers/ata/pata_mpiix.c
@@ -247,6 +247,10 @@ static struct pci_driver mpiix_pci_drive
 
 static int __init mpiix_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &mpiix_sht);
+		ata_dump_ops(DRV_NAME, &mpiix_port_ops);
+	}
 	return pci_register_driver(&mpiix_pci_driver);
 }
 
Index: work/drivers/ata/pata_netcell.c
===================================================================
--- work.orig/drivers/ata/pata_netcell.c
+++ work/drivers/ata/pata_netcell.c
@@ -94,6 +94,10 @@ static struct pci_driver netcell_pci_dri
 
 static int __init netcell_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &netcell_sht);
+		ata_dump_ops(DRV_NAME, &netcell_ops);
+	}
 	return pci_register_driver(&netcell_pci_driver);
 }
 
Index: work/drivers/ata/pata_ninja32.c
===================================================================
--- work.orig/drivers/ata/pata_ninja32.c
+++ work/drivers/ata/pata_ninja32.c
@@ -156,6 +156,10 @@ static struct pci_driver ninja32_pci_dri
 
 static int __init ninja32_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &ninja32_sht);
+		ata_dump_ops(DRV_NAME, &ninja32_port_ops);
+	}
 	return pci_register_driver(&ninja32_pci_driver);
 }
 
Index: work/drivers/ata/pata_ns87410.c
===================================================================
--- work.orig/drivers/ata/pata_ns87410.c
+++ work/drivers/ata/pata_ns87410.c
@@ -186,6 +186,10 @@ static struct pci_driver ns87410_pci_dri
 
 static int __init ns87410_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &ns87410_sht);
+		ata_dump_ops(DRV_NAME, &ns87410_port_ops);
+	}
 	return pci_register_driver(&ns87410_pci_driver);
 }
 
Index: work/drivers/ata/pata_ns87415.c
===================================================================
--- work.orig/drivers/ata/pata_ns87415.c
+++ work/drivers/ata/pata_ns87415.c
@@ -399,6 +399,11 @@ static struct pci_driver ns87415_pci_dri
 
 static int __init ns87415_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &ns87415_sht);
+		ata_dump_ops(DRV_NAME, &ns87415_pata_ops);
+		//ata_dump_ops(DRV_NAME, &ns87560_pata_ops);
+	}
 	return pci_register_driver(&ns87415_pci_driver);
 }
 
Index: work/drivers/ata/pata_oldpiix.c
===================================================================
--- work.orig/drivers/ata/pata_oldpiix.c
+++ work/drivers/ata/pata_oldpiix.c
@@ -286,6 +286,10 @@ static struct pci_driver oldpiix_pci_dri
 
 static int __init oldpiix_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &oldpiix_sht);
+		ata_dump_ops(DRV_NAME, &oldpiix_pata_ops);
+	}
 	return pci_register_driver(&oldpiix_pci_driver);
 }
 
Index: work/drivers/ata/pata_opti.c
===================================================================
--- work.orig/drivers/ata/pata_opti.c
+++ work/drivers/ata/pata_opti.c
@@ -212,6 +212,10 @@ static struct pci_driver opti_pci_driver
 
 static int __init opti_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &opti_sht);
+		ata_dump_ops(DRV_NAME, &opti_port_ops);
+	}
 	return pci_register_driver(&opti_pci_driver);
 }
 
Index: work/drivers/ata/pata_optidma.c
===================================================================
--- work.orig/drivers/ata/pata_optidma.c
+++ work/drivers/ata/pata_optidma.c
@@ -469,6 +469,11 @@ static struct pci_driver optidma_pci_dri
 
 static int __init optidma_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &optidma_sht);
+		ata_dump_ops(DRV_NAME, &optidma_port_ops);
+		ata_dump_ops(DRV_NAME, &optiplus_port_ops);
+	}
 	return pci_register_driver(&optidma_pci_driver);
 }
 
Index: work/drivers/ata/pata_pcmcia.c
===================================================================
--- work.orig/drivers/ata/pata_pcmcia.c
+++ work/drivers/ata/pata_pcmcia.c
@@ -449,6 +449,11 @@ static struct pcmcia_driver pcmcia_drive
 
 static int __init pcmcia_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &pcmcia_sht);
+		ata_dump_ops(DRV_NAME, &pcmcia_port_ops);
+		ata_dump_ops(DRV_NAME, &pcmcia_8bit_port_ops);
+	}
 	return pcmcia_register_driver(&pcmcia_driver);
 }
 
Index: work/drivers/ata/pata_pdc2027x.c
===================================================================
--- work.orig/drivers/ata/pata_pdc2027x.c
+++ work/drivers/ata/pata_pdc2027x.c
@@ -783,6 +783,11 @@ static int __devinit pdc2027x_init_one(s
  */
 static int __init pdc2027x_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &pdc2027x_sht);
+		ata_dump_ops(DRV_NAME, &pdc2027x_pata100_ops);
+		ata_dump_ops(DRV_NAME, &pdc2027x_pata133_ops);
+	}
 	return pci_register_driver(&pdc2027x_pci_driver);
 }
 
Index: work/drivers/ata/pata_pdc202xx_old.c
===================================================================
--- work.orig/drivers/ata/pata_pdc202xx_old.c
+++ work/drivers/ata/pata_pdc202xx_old.c
@@ -353,6 +353,11 @@ static struct pci_driver pdc202xx_pci_dr
 
 static int __init pdc202xx_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &pdc202xx_sht);
+		ata_dump_ops(DRV_NAME, &pdc2024x_port_ops);
+		ata_dump_ops(DRV_NAME, &pdc2026x_port_ops);
+	}
 	return pci_register_driver(&pdc202xx_pci_driver);
 }
 
Index: work/drivers/ata/pata_platform.c
===================================================================
--- work.orig/drivers/ata/pata_platform.c
+++ work/drivers/ata/pata_platform.c
@@ -233,6 +233,10 @@ static struct platform_driver pata_platf
 
 static int __init pata_platform_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &pata_platform_sht);
+		ata_dump_ops(DRV_NAME, &pata_platform_port_ops);
+	}
 	return platform_driver_register(&pata_platform_driver);
 }
 
Index: work/drivers/ata/pata_qdi.c
===================================================================
--- work.orig/drivers/ata/pata_qdi.c
+++ work/drivers/ata/pata_qdi.c
@@ -337,6 +337,11 @@ static __init int qdi_init(void)
 	}
 	if (ct != 0)
 		return 0;
+	{
+		ata_dump_sht(DRV_NAME, &qdi_sht);
+		ata_dump_ops(DRV_NAME, &qdi6500_port_ops);
+		ata_dump_ops(DRV_NAME, &qdi6580_port_ops);
+	}
 	return -ENODEV;
 }
 
Index: work/drivers/ata/pata_radisys.c
===================================================================
--- work.orig/drivers/ata/pata_radisys.c
+++ work/drivers/ata/pata_radisys.c
@@ -251,6 +251,10 @@ static struct pci_driver radisys_pci_dri
 
 static int __init radisys_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &radisys_sht);
+		ata_dump_ops(DRV_NAME, &radisys_pata_ops);
+	}
 	return pci_register_driver(&radisys_pci_driver);
 }
 
Index: work/drivers/ata/pata_rz1000.c
===================================================================
--- work.orig/drivers/ata/pata_rz1000.c
+++ work/drivers/ata/pata_rz1000.c
@@ -138,6 +138,10 @@ static struct pci_driver rz1000_pci_driv
 
 static int __init rz1000_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &rz1000_sht);
+		ata_dump_ops(DRV_NAME, &rz1000_port_ops);
+	}
 	return pci_register_driver(&rz1000_pci_driver);
 }
 
Index: work/drivers/ata/pata_sc1200.c
===================================================================
--- work.orig/drivers/ata/pata_sc1200.c
+++ work/drivers/ata/pata_sc1200.c
@@ -236,6 +236,10 @@ static struct pci_driver sc1200_pci_driv
 
 static int __init sc1200_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &sc1200_sht);
+		ata_dump_ops(DRV_NAME, &sc1200_port_ops);
+	}
 	return pci_register_driver(&sc1200_pci_driver);
 }
 
Index: work/drivers/ata/pata_scc.c
===================================================================
--- work.orig/drivers/ata/pata_scc.c
+++ work/drivers/ata/pata_scc.c
@@ -1174,6 +1174,10 @@ static int __init scc_init (void)
 		return rc;
 
 	DPRINTK("done\n");
+	{
+		ata_dump_sht(DRV_NAME, &scc_sht);
+		ata_dump_ops(DRV_NAME, &scc_pata_ops);
+	}
 	return 0;
 }
 
Index: work/drivers/ata/pata_serverworks.c
===================================================================
--- work.orig/drivers/ata/pata_serverworks.c
+++ work/drivers/ata/pata_serverworks.c
@@ -525,6 +525,11 @@ static struct pci_driver serverworks_pci
 
 static int __init serverworks_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &serverworks_sht);
+		ata_dump_ops(DRV_NAME, &serverworks_osb4_port_ops);
+		ata_dump_ops(DRV_NAME, &serverworks_csb_port_ops);
+	}
 	return pci_register_driver(&serverworks_pci_driver);
 }
 
Index: work/drivers/ata/pata_sil680.c
===================================================================
--- work.orig/drivers/ata/pata_sil680.c
+++ work/drivers/ata/pata_sil680.c
@@ -397,6 +397,10 @@ static struct pci_driver sil680_pci_driv
 
 static int __init sil680_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &sil680_sht);
+		ata_dump_ops(DRV_NAME, &sil680_port_ops);
+	}
 	return pci_register_driver(&sil680_pci_driver);
 }
 
Index: work/drivers/ata/pata_sis.c
===================================================================
--- work.orig/drivers/ata/pata_sis.c
+++ work/drivers/ata/pata_sis.c
@@ -868,6 +868,16 @@ static struct pci_driver sis_pci_driver 
 
 static int __init sis_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &sis_sht);
+		ata_dump_ops(DRV_NAME, &sis_133_for_sata_ops);
+		ata_dump_ops(DRV_NAME, &sis_base_ops);
+		ata_dump_ops(DRV_NAME, &sis_133_ops);
+		ata_dump_ops(DRV_NAME, &sis_133_early_ops);
+		ata_dump_ops(DRV_NAME, &sis_100_ops);
+		ata_dump_ops(DRV_NAME, &sis_66_ops);
+		ata_dump_ops(DRV_NAME, &sis_old_ops);
+	}
 	return pci_register_driver(&sis_pci_driver);
 }
 
Index: work/drivers/ata/pata_sl82c105.c
===================================================================
--- work.orig/drivers/ata/pata_sl82c105.c
+++ work/drivers/ata/pata_sl82c105.c
@@ -314,6 +314,10 @@ static struct pci_driver sl82c105_pci_dr
 
 static int __init sl82c105_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &sl82c105_sht);
+		ata_dump_ops(DRV_NAME, &sl82c105_port_ops);
+	}
 	return pci_register_driver(&sl82c105_pci_driver);
 }
 
Index: work/drivers/ata/pata_triflex.c
===================================================================
--- work.orig/drivers/ata/pata_triflex.c
+++ work/drivers/ata/pata_triflex.c
@@ -229,6 +229,10 @@ static struct pci_driver triflex_pci_dri
 
 static int __init triflex_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &triflex_sht);
+		ata_dump_ops(DRV_NAME, &triflex_port_ops);
+	}
 	return pci_register_driver(&triflex_pci_driver);
 }
 
Index: work/drivers/ata/pata_via.c
===================================================================
--- work.orig/drivers/ata/pata_via.c
+++ work/drivers/ata/pata_via.c
@@ -596,6 +596,11 @@ static struct pci_driver via_pci_driver 
 
 static int __init via_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &via_sht);
+		ata_dump_ops(DRV_NAME, &via_port_ops);
+		ata_dump_ops(DRV_NAME, &via_port_ops_noirq);
+	}
 	return pci_register_driver(&via_pci_driver);
 }
 
Index: work/drivers/ata/pata_winbond.c
===================================================================
--- work.orig/drivers/ata/pata_winbond.c
+++ work/drivers/ata/pata_winbond.c
@@ -256,6 +256,10 @@ static __init int winbond_init(void)
 	}
 	if (ct != 0)
 		return 0;
+	{
+		ata_dump_sht(DRV_NAME, &winbond_sht);
+		ata_dump_ops(DRV_NAME, &winbond_port_ops);
+	}
 	return -ENODEV;
 }
 
Index: work/drivers/ata/pdc_adma.c
===================================================================
--- work.orig/drivers/ata/pdc_adma.c
+++ work/drivers/ata/pdc_adma.c
@@ -714,6 +714,10 @@ static int adma_ata_init_one(struct pci_
 
 static int __init adma_ata_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &adma_ata_sht);
+		ata_dump_ops(DRV_NAME, &adma_ata_ops);
+	}
 	return pci_register_driver(&adma_ata_pci_driver);
 }
 
Index: work/drivers/ata/sata_fsl.c
===================================================================
--- work.orig/drivers/ata/sata_fsl.c
+++ work/drivers/ata/sata_fsl.c
@@ -1360,6 +1360,10 @@ static struct of_platform_driver fsl_sat
 static int __init sata_fsl_init(void)
 {
 	of_register_platform_driver(&fsl_sata_driver);
+	{
+		ata_dump_sht(DRV_NAME, &sata_fsl_sht);
+		ata_dump_ops(DRV_NAME, &sata_fsl_ops);
+	}
 	return 0;
 }
 
Index: work/drivers/ata/sata_inic162x.c
===================================================================
--- work.orig/drivers/ata/sata_inic162x.c
+++ work/drivers/ata/sata_inic162x.c
@@ -731,6 +731,10 @@ static struct pci_driver inic_pci_driver
 
 static int __init inic_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &inic_sht);
+		ata_dump_ops(DRV_NAME, &inic_port_ops);
+	}
 	return pci_register_driver(&inic_pci_driver);
 }
 
Index: work/drivers/ata/sata_mv.c
===================================================================
--- work.orig/drivers/ata/sata_mv.c
+++ work/drivers/ata/sata_mv.c
@@ -2677,6 +2677,13 @@ static int mv_init_one(struct pci_dev *p
 
 static int __init mv_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &mv5_sht);
+		ata_dump_sht(DRV_NAME, &mv6_sht);
+		ata_dump_ops(DRV_NAME, &mv5_ops);
+		ata_dump_ops(DRV_NAME, &mv6_ops);
+		ata_dump_ops(DRV_NAME, &mv_iie_ops);
+	}
 	return pci_register_driver(&mv_pci_driver);
 }
 
Index: work/drivers/ata/sata_nv.c
===================================================================
--- work.orig/drivers/ata/sata_nv.c
+++ work/drivers/ata/sata_nv.c
@@ -2416,6 +2416,16 @@ static void nv_adma_host_stop(struct ata
 
 static int __init nv_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &nv_sht);
+		ata_dump_sht(DRV_NAME, &nv_adma_sht);
+		ata_dump_sht(DRV_NAME, &nv_swncq_sht);
+		ata_dump_ops(DRV_NAME, &nv_generic_ops);
+		ata_dump_ops(DRV_NAME, &nv_nf2_ops);
+		ata_dump_ops(DRV_NAME, &nv_ck804_ops);
+		ata_dump_ops(DRV_NAME, &nv_adma_ops);
+		ata_dump_ops(DRV_NAME, &nv_swncq_ops);
+	}
 	return pci_register_driver(&nv_pci_driver);
 }
 
Index: work/drivers/ata/sata_promise.c
===================================================================
--- work.orig/drivers/ata/sata_promise.c
+++ work/drivers/ata/sata_promise.c
@@ -1060,6 +1060,13 @@ static int pdc_ata_init_one(struct pci_d
 
 static int __init pdc_ata_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &pdc_ata_sht);
+		ata_dump_ops(DRV_NAME, &pdc_common_ops);
+		ata_dump_ops(DRV_NAME, &pdc_sata_ops);
+		ata_dump_ops(DRV_NAME, &pdc_old_sata_ops);
+		ata_dump_ops(DRV_NAME, &pdc_pata_ops);
+	}
 	return pci_register_driver(&pdc_ata_pci_driver);
 }
 
Index: work/drivers/ata/sata_qstor.c
===================================================================
--- work.orig/drivers/ata/sata_qstor.c
+++ work/drivers/ata/sata_qstor.c
@@ -663,6 +663,10 @@ static int qs_ata_init_one(struct pci_de
 
 static int __init qs_ata_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &qs_ata_sht);
+		ata_dump_ops(DRV_NAME, &qs_ata_ops);
+	}
 	return pci_register_driver(&qs_ata_pci_driver);
 }
 
Index: work/drivers/ata/sata_sil.c
===================================================================
--- work.orig/drivers/ata/sata_sil.c
+++ work/drivers/ata/sata_sil.c
@@ -688,6 +688,10 @@ static int sil_pci_device_resume(struct 
 
 static int __init sil_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &sil_sht);
+		ata_dump_ops(DRV_NAME, &sil_ops);
+	}
 	return pci_register_driver(&sil_pci_driver);
 }
 
Index: work/drivers/ata/sata_sil24.c
===================================================================
--- work.orig/drivers/ata/sata_sil24.c
+++ work/drivers/ata/sata_sil24.c
@@ -1394,6 +1394,10 @@ static int sil24_port_resume(struct ata_
 
 static int __init sil24_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &sil24_sht);
+		ata_dump_ops(DRV_NAME, &sil24_ops);
+	}
 	return pci_register_driver(&sil24_pci_driver);
 }
 
Index: work/drivers/ata/sata_sis.c
===================================================================
--- work.orig/drivers/ata/sata_sis.c
+++ work/drivers/ata/sata_sis.c
@@ -333,6 +333,10 @@ static int sis_init_one(struct pci_dev *
 
 static int __init sis_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &sis_sht);
+		ata_dump_ops(DRV_NAME, &sis_ops);
+	}
 	return pci_register_driver(&sis_pci_driver);
 }
 
Index: work/drivers/ata/sata_svw.c
===================================================================
--- work.orig/drivers/ata/sata_svw.c
+++ work/drivers/ata/sata_svw.c
@@ -474,6 +474,10 @@ static struct pci_driver k2_sata_pci_dri
 
 static int __init k2_sata_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &k2_sata_sht);
+		ata_dump_ops(DRV_NAME, &k2_sata_ops);
+	}
 	return pci_register_driver(&k2_sata_pci_driver);
 }
 
Index: work/drivers/ata/sata_sx4.c
===================================================================
--- work.orig/drivers/ata/sata_sx4.c
+++ work/drivers/ata/sata_sx4.c
@@ -1433,6 +1433,10 @@ static int pdc_sata_init_one(struct pci_
 
 static int __init pdc_sata_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &pdc_sata_sht);
+		ata_dump_ops(DRV_NAME, &pdc_20621_ops);
+	}
 	return pci_register_driver(&pdc_sata_pci_driver);
 }
 
Index: work/drivers/ata/sata_uli.c
===================================================================
--- work.orig/drivers/ata/sata_uli.c
+++ work/drivers/ata/sata_uli.c
@@ -248,6 +248,10 @@ static int uli_init_one(struct pci_dev *
 
 static int __init uli_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &uli_sht);
+		ata_dump_ops(DRV_NAME, &uli_ops);
+	}
 	return pci_register_driver(&uli_pci_driver);
 }
 
Index: work/drivers/ata/sata_via.c
===================================================================
--- work.orig/drivers/ata/sata_via.c
+++ work/drivers/ata/sata_via.c
@@ -462,6 +462,12 @@ static int svia_init_one(struct pci_dev 
 
 static int __init svia_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &svia_sht);
+		ata_dump_ops(DRV_NAME, &vt6420_sata_ops);
+		ata_dump_ops(DRV_NAME, &vt6421_pata_ops);
+		ata_dump_ops(DRV_NAME, &vt6421_sata_ops);
+	}
 	return pci_register_driver(&svia_pci_driver);
 }
 
Index: work/drivers/ata/sata_vsc.c
===================================================================
--- work.orig/drivers/ata/sata_vsc.c
+++ work/drivers/ata/sata_vsc.c
@@ -443,6 +443,10 @@ static struct pci_driver vsc_sata_pci_dr
 
 static int __init vsc_sata_init(void)
 {
+	{
+		ata_dump_sht(DRV_NAME, &vsc_sata_sht);
+		ata_dump_ops(DRV_NAME, &vsc_sata_ops);
+	}
 	return pci_register_driver(&vsc_sata_pci_driver);
 }
 
Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -7768,3 +7768,55 @@ EXPORT_SYMBOL_GPL(ata_cable_80wire);
 EXPORT_SYMBOL_GPL(ata_cable_unknown);
 EXPORT_SYMBOL_GPL(ata_cable_ignore);
 EXPORT_SYMBOL_GPL(ata_cable_sata);
+
+#include <linux/kallsyms.h>
+
+void ata_dump_sht(const char *drv_name, const struct scsi_host_template *sht)
+{
+	const int begin_off = offsetof(struct scsi_host_template, detect);
+	const int end_off = offsetof(struct scsi_host_template, eh_timed_out) + sizeof(void *);
+	char symname[KSYM_NAME_LEN];
+	void **pp;
+
+	if (lookup_symbol_name((unsigned long)sht, symname))
+		snprintf(symname, KSYM_NAME_LEN, "%p", sht);
+	printk("SHT %s %s: %s", drv_name, symname, sht->name);
+
+	for (pp = (void *)sht + begin_off; pp < (void **)((void *)sht + end_off); pp++) {
+		if (lookup_symbol_name((unsigned long)*pp, symname))
+			snprintf(symname, KSYM_NAME_LEN, "%p", *pp);
+		printk(" <%s>", symname);
+	}
+
+	printk(" %s %d %d %u %u %lu %d %u %u %u %u %u %u %u %u %u\n",
+	       sht->proc_name, sht->can_queue, sht->this_id,
+	       sht->sg_tablesize, sht->max_sectors, sht->dma_boundary,
+	       sht->cmd_per_lun, sht->present, sht->supported_mode,
+	       sht->unchecked_isa_dma, sht->use_clustering, sht->emulated,
+	       sht->skip_settle_delay, sht->ordered_tag, sht->use_sg_chaining,
+	       sht->max_host_blocked);
+}
+EXPORT_SYMBOL_GPL(ata_dump_sht);
+
+void ata_dump_ops(const char *drv_name, const struct ata_port_operations *ops)
+{
+	const int begin_off = 0;
+	const int end_off = offsetof(struct ata_port_operations, eng_timeout) + sizeof(void *);
+	struct ata_port_operations my_ops = *ops;
+	char symname[KSYM_NAME_LEN];
+	void **pp;
+
+	if (lookup_symbol_name((unsigned long)ops, symname))
+		snprintf(symname, KSYM_NAME_LEN, "%p", ops);
+	printk("OPS %s %s:", drv_name, symname);
+
+	ata_finalize_port_ops(&my_ops);
+
+	for (pp = (void *)&my_ops + begin_off; pp < (void **)((void *)&my_ops + end_off); pp++) {
+		if (lookup_symbol_name((unsigned long)*pp, symname))
+			snprintf(symname, KSYM_NAME_LEN, "%p", *pp);
+		printk(" <%s>", symname);
+	}
+	printk("\n");
+}
+EXPORT_SYMBOL_GPL(ata_dump_ops);
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -803,6 +803,9 @@ static inline int ata_port_is_dummy(stru
 	return ap->ops == &ata_dummy_port_ops;
 }
 
+extern void ata_dump_sht(const char *drv_name, const struct scsi_host_template *sht);
+extern void ata_dump_ops(const char *drv_name, const struct ata_port_operations *ops);
+
 extern void sata_print_link_status(struct ata_link *link);
 extern void ata_port_probe(struct ata_port *);
 extern void ata_bus_reset(struct ata_port *ap);
Index: work/kernel/kallsyms.c
===================================================================
--- work.orig/kernel/kallsyms.c
+++ work/kernel/kallsyms.c
@@ -291,6 +291,7 @@ int lookup_symbol_name(unsigned long add
 	/* see if it's in a module */
 	return lookup_module_symbol_name(addr, symname);
 }
+EXPORT_SYMBOL_GPL(lookup_symbol_name);
 
 int lookup_symbol_attrs(unsigned long addr, unsigned long *size,
 			unsigned long *offset, char *modname, char *name)

--------------020203070305040007040100
Content-Type: text/plain;
 name="out.before"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="out.before"

OPS ahci ahci_ops: <sata_pmp_qc_defer_cmd_switch> <0000000000000000> <ahci_qc_prep> <ahci_qc_issue> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ahci_freeze> <ahci_thaw> <ahci_error_handler> <ahci_post_internal_cmd> <ahci_scr_read> <ahci_scr_write> <ahci_pmp_attach> <ahci_pmp_detach> <ahci_enable_alpm> <ahci_disable_alpm> <ahci_port_suspend> <ahci_port_resume> <ahci_port_start> <ahci_port_stop> <0000000000000000> <ata_noop_dev_select> <ahci_check_status> <ahci_check_status> <0000000000000000> <ahci_tf_read> <0000000000000000> <0000000000000000> <0000000000000000> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS ahci ahci_p5wdh_ops: <sata_pmp_qc_defer_cmd_switch> <0000000000000000> <ahci_qc_prep> <ahci_qc_issue> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ahci_freeze> <ahci_thaw> <ahci_p5wdh_error_handler> <ahci_post_internal_cmd> <ahci_scr_read> <ahci_scr_write> <ahci_pmp_attach> <ahci_pmp_detach> <ahci_enable_alpm> <ahci_disable_alpm> <ahci_port_suspend> <ahci_port_resume> <ahci_port_start> <ahci_port_stop> <0000000000000000> <ata_noop_dev_select> <ahci_check_status> <ahci_check_status> <0000000000000000> <ahci_tf_read> <0000000000000000> <0000000000000000> <0000000000000000> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS ahci ahci_vt8251_ops: <sata_pmp_qc_defer_cmd_switch> <0000000000000000> <ahci_qc_prep> <ahci_qc_issue> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ahci_freeze> <ahci_thaw> <ahci_vt8251_error_handler> <ahci_post_internal_cmd> <ahci_scr_read> <ahci_scr_write> <ahci_pmp_attach> <ahci_pmp_detach> <ahci_enable_alpm> <ahci_disable_alpm> <ahci_port_suspend> <ahci_port_resume> <ahci_port_start> <ahci_port_stop> <0000000000000000> <ata_noop_dev_select> <ahci_check_status> <ahci_check_status> <0000000000000000> <ahci_tf_read> <0000000000000000> <0000000000000000> <0000000000000000> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS ata_generic generic_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_unknown> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <generic_set_mode> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS ata_piix ich_pata_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ich_pata_cable_detect> <ata_pci_default_filter> <piix_set_piomode> <ich_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <piix_pata_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS ata_piix piix_pata_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <piix_set_piomode> <piix_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <piix_pata_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS ata_piix piix_sata_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS ata_piix piix_sidpr_sata_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <piix_sidpr_error_handler> <ata_bmdma_post_internal_cmd> <piix_sidpr_scr_read> <piix_sidpr_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <00000000000000
 00>
OPS ata_piix piix_vmw_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <piix_set_piomode> <piix_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <piix_pata_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <piix_vmw_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_acpi pacpi_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <pacpi_qc_issue_prot> <pacpi_cable_detect> <pacpi_mode_filter> <pacpi_set_piomode> <pacpi_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <pacpi_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <pacpi_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_ali ali_20_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ali_20_filter> <ali_set_piomode> <ali_set_dmamode> <0000000000000000> <ali_lock_sectors> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_ali ali_c2_port_ops: <0000000000000000> <ali_check_atapi_dma> <ata_qc_prep> <ata_qc_issue_prot> <ali_c2_cable_detect> <ata_pci_default_filter> <ali_set_piomode> <ali_set_dmamode> <0000000000000000> <ali_lock_sectors> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_ali ali_c5_port_ops: <0000000000000000> <ali_check_atapi_dma> <ata_qc_prep> <ata_qc_issue_prot> <ali_c2_cable_detect> <ata_pci_default_filter> <ali_set_piomode> <ali_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_ali ali_early_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <0000000000000000> <ali_set_piomode> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS pata_amd amd100_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_unknown> <ata_pci_default_filter> <amd100_set_piomode> <amd100_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <amd_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_amd amd133_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <amd_cable_detect> <ata_pci_default_filter> <amd133_set_piomode> <amd133_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <amd_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_amd amd33_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <amd33_set_piomode> <amd33_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <amd_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_amd amd66_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_unknown> <ata_pci_default_filter> <amd66_set_piomode> <amd66_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <amd_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_amd nv100_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_ignore> <nv_mode_filter> <nv100_set_piomode> <nv100_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <nv_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <nv_host_stop> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_amd nv133_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_ignore> <nv_mode_filter> <nv133_set_piomode> <nv133_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <nv_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <nv_host_stop> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_artop artop6210_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <artop6210_set_piomode> <artop6210_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <artop6210_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000
 >
OPS pata_artop artop6260_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <artop6260_cable_detect> <ata_pci_default_filter> <artop6260_set_piomode> <artop6260_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <artop6260_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000
 000000>
OPS pata_atiixp atiixp_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <atiixp_cable_detect> <ata_pci_default_filter> <atiixp_set_piomode> <atiixp_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <atiixp_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <atiixp_bmdma_start> <atiixp_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000
 000>
OPS pata_cmd640 cmd640_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <cmd640_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <cmd640_set_piomode> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <cmd640_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer_noirq> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000
 000>
OPS pata_cmd64x cmd646r1_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <cmd64x_set_piomode> <cmd64x_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <cmd646r1_bmdma_stop> <ata_bmdma_status> <0000000000000000> <000000000000
 0000>
OPS pata_cmd64x cmd648_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <cmd648_cable_detect> <ata_pci_default_filter> <cmd64x_set_piomode> <cmd64x_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <cmd648_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000
 000>
OPS pata_cmd64x cmd64x_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <cmd64x_set_piomode> <cmd64x_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_cs5520 cs5520_port_ops: <0000000000000000> <0000000000000000> <ata_dumb_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <cs5520_set_piomode> <cs5520_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <00000000000000
 00>
OPS pata_cs5530 cs5530_port_ops: <0000000000000000> <0000000000000000> <ata_dumb_qc_prep> <cs5530_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <cs5530_set_piomode> <cs5530_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <00000000000
 00000>
OPS pata_cypress cy82c693_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <cy82c693_set_piomode> <cy82c693_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <000000000000
 0000>
OPS pata_efar efar_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <efar_cable_detect> <ata_pci_default_filter> <efar_set_piomode> <efar_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <efar_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_hpt366 hpt366_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <hpt36x_cable_detect> <hpt366_filter> <hpt366_set_piomode> <hpt366_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_hpt37x hpt370a_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <hpt370a_filter> <hpt370_set_piomode> <hpt370_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <hpt37x_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <hpt370_bmdma_start> <hpt370_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_hpt37x hpt370_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <hpt370_filter> <hpt370_set_piomode> <hpt370_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <hpt37x_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <hpt370_bmdma_start> <hpt370_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_hpt37x hpt372_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <hpt372_set_piomode> <hpt372_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <hpt37x_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <hpt37x_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_hpt37x hpt374_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <hpt372_set_piomode> <hpt372_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <hpt374_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <hpt37x_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_hpt3x2n hpt3x2n_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <hpt3x2n_qc_issue_prot> <hpt3x2n_cable_detect> <ata_pci_default_filter> <hpt3x2n_set_piomode> <hpt3x2n_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <hpt3x2n_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <hpt3x2n_bmdma_stop> <ata_bmdma_status> <0000000000000000> <00000
 00000000000>
OPS pata_hpt3x3 hpt3x3_port_ops: <0000000000000000> <hpt3x3_atapi_dma> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <hpt3x3_set_piomode> <hpt3x3_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_it8213 it8213_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <it8213_cable_detect> <ata_pci_default_filter> <it8213_set_piomode> <it8213_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <it8213_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_it821x it821x_passthru_port_ops: <0000000000000000> <it821x_check_atapi_dma> <ata_qc_prep> <it821x_passthru_qc_issue_prot> <ata_cable_unknown> <ata_pci_default_filter> <it821x_passthru_set_piomode> <it821x_passthru_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <it821x_port_start> <0000000000000000> <0000000000000000> <it821x_passthru_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <it821x_passthru_bmdma_start> <it821x_pa
 ssthru_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_it821x it821x_smart_port_ops: <0000000000000000> <it821x_check_atapi_dma> <ata_qc_prep> <it821x_smart_qc_issue_prot> <it821x_ident_hack> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <it821x_smart_set_mode> <it821x_dev_config> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <it821x_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <000000000000000
 0> <0000000000000000>
OPS pata_jmicron jmicron_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <jmicron_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_marvell marvell_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <marvell_cable_detect> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <marvell_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_mpiix mpiix_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <mpiix_qc_issue_prot> <ata_cable_40wire> <0000000000000000> <mpiix_set_piomode> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <mpiix_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS pata_netcell netcell_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_80wire> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_ninja32 ninja32_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <ninja32_set_piomode> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ninja32_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_ns87410 ns87410_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ns87410_qc_issue_prot> <ata_cable_40wire> <0000000000000000> <ns87410_set_piomode> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ns87410_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS pata_ns87415 ns87415_pata_ops: <0000000000000000> <ns87415_check_atapi_dma> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <ns87415_set_piomode> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ns87415_bmdma_irq_clear> <ns87415_bmdma_setup> <ns87415_bmdma_start> <ns87415_bmdma_stop> <ata_bmdma_status> <00000000000000
 00> <0000000000000000>
OPS pata_oldpiix oldpiix_pata_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <oldpiix_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <oldpiix_set_piomode> <oldpiix_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <oldpiix_pata_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <00000000
 00000000>
OPS pata_optidma optidma_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <optidma_set_pio_mode> <optidma_set_dma_mode> <optidma_set_mode> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <optidma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <000000000000000
 0>
OPS pata_optidma optiplus_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <optiplus_set_pio_mode> <optiplus_set_dma_mode> <optidma_set_mode> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <optidma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <000000000000
 0000>
OPS pata_opti opti_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <opti_set_piomode> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <opti_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_pcmcia pcmcia_8bit_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <0000000000000000> <0000000000000000> <0000000000000000> <pcmcia_set_mode_8bit> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer_8bit> <ata_irq_on> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <000000000000
 0000>
OPS pata_pcmcia pcmcia_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <0000000000000000> <0000000000000000> <0000000000000000> <pcmcia_set_mode> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer_noirq> <ata_irq_on> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS pata_pdc2027x pdc2027x_pata100_ops: <0000000000000000> <pdc2027x_check_atapi_dma> <ata_qc_prep> <ata_qc_issue_prot> <pdc2027x_cable_detect> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <pdc2027x_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000
 000000000000>
OPS pata_pdc2027x pdc2027x_pata133_ops: <0000000000000000> <pdc2027x_check_atapi_dma> <ata_qc_prep> <ata_qc_issue_prot> <pdc2027x_cable_detect> <pdc2027x_mode_filter> <pdc2027x_set_piomode> <pdc2027x_set_dmamode> <pdc2027x_set_mode> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <pdc2027x_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000
 > <0000000000000000>
OPS pata_pdc202xx_old pdc2024x_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <pdc202xx_set_piomode> <pdc202xx_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000
 000000000>
OPS pata_pdc202xx_old pdc2026x_port_ops: <0000000000000000> <pdc2026x_check_atapi_dma> <ata_qc_prep> <ata_qc_issue_prot> <pdc2026x_cable_detect> <ata_pci_default_filter> <pdc202xx_set_piomode> <pdc202xx_set_dmamode> <0000000000000000> <pdc2026x_dev_config> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <pdc2026x_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <pdc2026x_bmdma_start> <pdc2026x_bmdma_stop> <ata_bmdma_status> 
 <0000000000000000> <0000000000000000>
OPS pata_radisys radisys_pata_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <radisys_qc_issue_prot> <ata_cable_unknown> <ata_pci_default_filter> <radisys_set_piomode> <radisys_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000
 000000>
OPS pata_rz1000 rz1000_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <rz1000_set_mode> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_serverworks serverworks_csb_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <serverworks_cable_detect> <serverworks_csb_filter> <serverworks_set_piomode> <serverworks_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <000000
 0000000000> <0000000000000000>
OPS pata_serverworks serverworks_osb4_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <serverworks_cable_detect> <serverworks_osb4_filter> <serverworks_set_piomode> <serverworks_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000
 000000000000> <0000000000000000>
OPS pata_sil680 sil680_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <sil680_cable_detect> <ata_pci_default_filter> <sil680_set_piomode> <sil680_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000
 >
OPS pata_sis sis_100_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <sis_66_cable_detect> <ata_pci_default_filter> <sis_100_set_piomode> <sis_100_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <sis_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_sis sis_133_early_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <sis_66_cable_detect> <ata_pci_default_filter> <sis_100_set_piomode> <sis_133_early_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <sis_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <000000000000000
 0>
OPS pata_sis sis_133_for_sata_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <sis_133_cable_detect> <ata_pci_default_filter> <sis_133_set_piomode> <sis_133_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <00000000000
 00000>
OPS pata_sis sis_133_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <sis_133_cable_detect> <ata_pci_default_filter> <sis_133_set_piomode> <sis_133_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <sis_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_sis sis_66_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <sis_66_cable_detect> <ata_pci_default_filter> <sis_old_set_piomode> <sis_66_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <sis_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_sis sis_old_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <sis_old_set_piomode> <sis_old_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <sis_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_sl82c105 sl82c105_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <sl82c105_set_piomode> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <sl82c105_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <sl82c105_bmdma_start> <sl82c105_bmdma_stop> <ata_bmdma_status> <0000000000000000> <000000
 0000000000>
OPS pata_triflex triflex_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <triflex_set_piomode> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <triflex_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <triflex_bmdma_start> <triflex_bmdma_stop> <ata_bmdma_status> <0000000000000000> <000000000000
 0000>
OPS pata_via via_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <via_cable_detect> <ata_pci_default_filter> <via_set_piomode> <via_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <via_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_via via_port_ops_noirq: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <via_cable_detect> <ata_pci_default_filter> <via_set_piomode> <via_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <via_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer_noirq> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pdc_adma adma_ata_ops: <0000000000000000> <adma_check_atapi_dma> <adma_qc_prep> <adma_qc_issue> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <adma_freeze> <adma_thaw> <adma_error_handler> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <adma_port_start> <adma_port_stop> <adma_host_stop> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <adma_bmdma_stop> <adma_bmdma_status> <0000000000000000> <0000000000000000>
OPS sata_inic162x inic_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <inic_qc_issue> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <inic_dev_config> <inic_freeze> <inic_thaw> <inic_error_handler> <inic_post_internal_cmd> <inic_scr_read> <inic_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <inic_port_resume> <inic_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_noop_irq_clear> <inic_bmdma_setup> <inic_bmdma_start> <inic_bmdma_stop> <inic_bmdma_status> <0000000000000000> <0000000000000000>
OPS sata_mv mv5_ops: <0000000000000000> <0000000000000000> <mv_qc_prep> <mv_qc_issue> <ata_cable_sata> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <mv_eh_freeze> <mv_eh_thaw> <mv_error_handler> <mv_post_int_cmd> <mv5_scr_read> <mv5_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <mv_port_start> <mv_port_stop> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS sata_mv mv6_ops: <0000000000000000> <0000000000000000> <mv_qc_prep> <mv_qc_issue> <ata_cable_sata> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <mv_eh_freeze> <mv_eh_thaw> <mv_error_handler> <mv_post_int_cmd> <mv_scr_read> <mv_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <mv_port_start> <mv_port_stop> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS sata_mv mv_iie_ops: <0000000000000000> <0000000000000000> <mv_qc_prep_iie> <mv_qc_issue> <ata_cable_sata> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <mv_eh_freeze> <mv_eh_thaw> <mv_error_handler> <mv_post_int_cmd> <mv_scr_read> <mv_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <mv_port_start> <mv_port_stop> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS sata_nv nv_adma_ops: <ata_std_qc_defer> <nv_adma_check_atapi_dma> <nv_adma_qc_prep> <nv_adma_qc_issue> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <nv_adma_freeze> <nv_adma_thaw> <nv_adma_error_handler> <nv_adma_post_internal_cmd> <nv_scr_read> <nv_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <nv_adma_port_suspend> <nv_adma_port_resume> <nv_adma_port_start> <nv_adma_port_stop> <nv_adma_host_stop> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <nv_adma_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <nv_adma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS sata_nv nv_ck804_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <nv_ck804_freeze> <nv_ck804_thaw> <nv_error_handler> <ata_bmdma_post_internal_cmd> <nv_scr_read> <nv_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <nv_ck804_host_stop> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS sata_nv nv_generic_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <nv_error_handler> <ata_bmdma_post_internal_cmd> <nv_scr_read> <nv_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS sata_nv nv_nf2_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <nv_nf2_freeze> <nv_nf2_thaw> <nv_error_handler> <ata_bmdma_post_internal_cmd> <nv_scr_read> <nv_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS sata_nv nv_swncq_ops: <ata_std_qc_defer> <0000000000000000> <nv_swncq_qc_prep> <nv_swncq_qc_issue> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <nv_mcp55_freeze> <nv_mcp55_thaw> <nv_swncq_error_handler> <ata_bmdma_post_internal_cmd> <nv_scr_read> <nv_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <nv_swncq_port_suspend> <nv_swncq_port_resume> <nv_swncq_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS sata_promise pdc_old_sata_ops: <0000000000000000> <pdc_old_sata_check_atapi_dma> <pdc_qc_prep> <pdc_qc_issue_prot> <pdc_sata_cable_detect> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <pdc_freeze> <pdc_thaw> <pdc_sata_error_handler> <pdc_post_internal_cmd> <pdc_sata_scr_read> <pdc_sata_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <pdc_sata_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <pdc_tf_load_mmio> <ata_tf_read> <pdc_exec_command_mmio> <ata_data_xfer> <ata_irq_on> <pdc_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
 
OPS sata_promise pdc_pata_ops: <0000000000000000> <pdc_check_atapi_dma> <pdc_qc_prep> <pdc_qc_issue_prot> <pdc_pata_cable_detect> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <pdc_freeze> <pdc_thaw> <pdc_pata_error_handler> <pdc_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <pdc_common_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <pdc_tf_load_mmio> <ata_tf_read> <pdc_exec_command_mmio> <ata_data_xfer> <ata_irq_on> <pdc_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS sata_promise pdc_sata_ops: <0000000000000000> <pdc_check_atapi_dma> <pdc_qc_prep> <pdc_qc_issue_prot> <pdc_sata_cable_detect> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <pdc_freeze> <pdc_thaw> <pdc_sata_error_handler> <pdc_post_internal_cmd> <pdc_sata_scr_read> <pdc_sata_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <pdc_sata_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <pdc_tf_load_mmio> <ata_tf_read> <pdc_exec_command_mmio> <ata_data_xfer> <ata_irq_on> <pdc_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS sata_qstor qs_ata_ops: <0000000000000000> <qs_check_atapi_dma> <qs_qc_prep> <qs_qc_issue> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <qs_freeze> <qs_thaw> <qs_error_handler> <0000000000000000> <qs_scr_read> <qs_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <qs_port_start> <0000000000000000> <qs_host_stop> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <qs_bmdma_stop> <qs_bmdma_status> <0000000000000000> <0000000000000000>
OPS sata_sil24 sil24_ops: <sil24_qc_defer> <0000000000000000> <sil24_qc_prep> <sil24_qc_issue> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <sil24_dev_config> <sil24_freeze> <sil24_thaw> <sil24_error_handler> <sil24_post_internal_cmd> <sil24_scr_read> <sil24_scr_write> <sil24_pmp_attach> <sil24_pmp_detach> <0000000000000000> <0000000000000000> <0000000000000000> <sil24_port_resume> <sil24_port_start> <0000000000000000> <0000000000000000> <ata_noop_dev_select> <sil24_check_status> <sil24_check_status> <0000000000000000> <sil24_tf_read> <0000000000000000> <0000000000000000> <0000000000000000> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS sata_sil sil_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <sil_set_mode> <sil_dev_config> <sil_freeze> <sil_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <sil_scr_read> <sil_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS sata_sis sis_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <sis_scr_read> <sis_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS sata_svw k2_sata_ops: <0000000000000000> <k2_sata_check_atapi_dma> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <k2_sata_scr_read> <k2_sata_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <k2_stat_check_status> <0000000000000000> <k2_sata_tf_load> <k2_sata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <k2_bmdma_setup_mmio> <k2_bmdma_start_mmio> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <00
 00000000000000>
OPS sata_sx4 pdc_20621_ops: <0000000000000000> <0000000000000000> <pdc20621_qc_prep> <pdc20621_qc_issue_prot> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <pdc_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <pdc_tf_load_mmio> <ata_tf_read> <pdc_exec_command_mmio> <ata_data_xfer> <ata_irq_on> <pdc20621_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <pdc_20621_phy_reset> <pdc_eng_timeout>
OPS sata_uli uli_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <uli_scr_read> <uli_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS sata_via vt6420_sata_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <svia_noop_freeze> <ata_bmdma_thaw> <vt6420_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS sata_via vt6421_pata_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <vt6421_pata_cable_detect> <ata_pci_default_filter> <vt6421_set_pio_mode> <vt6421_set_dma_mode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <000000000000
 0000>
OPS sata_via vt6421_sata_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <svia_scr_read> <svia_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS sata_vsc vsc_sata_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <vsc_freeze> <vsc_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <vsc_sata_scr_read> <vsc_sata_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <vsc_sata_tf_load> <vsc_sata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS sc1200 sc1200_port_ops: <0000000000000000> <0000000000000000> <ata_dumb_qc_prep> <sc1200_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <sc1200_set_piomode> <sc1200_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000
 >
SHT ahci ahci_sht: ahci <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_change_queue_depth> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> ahci 31 -1 168 0 4294967295 1 0 0 0 1 1 0 0 0 0
SHT ata_generic generic_sht: ata_generic <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> ata_generic 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT ata_piix piix_sht: ata_piix <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> ata_piix 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_acpi pacpi_sht: pata_acpi <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_acpi 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_ali ali_sht: pata_ali <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_ali 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_amd amd_sht: pata_amd <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_amd 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_artop artop_sht: pata_artop <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_artop 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_atiixp atiixp_sht: pata_atiixp <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_atiixp 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_cmd640 cmd640_sht: pata_cmd640 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_cmd640 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_cmd64x cmd64x_sht: pata_cmd64x <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_cmd64x 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_cs5520 cs5520_sht: pata_cs5520 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_cs5520 1 -1 64 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_cs5530 cs5530_sht: pata_cs5530 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_cs5530 1 -1 64 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_cypress cy82c693_sht: pata_cypress <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_cypress 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_efar efar_sht: pata_efar <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_efar 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_hpt366 hpt36x_sht: pata_hpt366 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_hpt366 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_hpt37x hpt37x_sht: pata_hpt37x <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_hpt37x 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_hpt3x2n hpt3x2n_sht: pata_hpt3x2n <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_hpt3x2n 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_hpt3x3 hpt3x3_sht: pata_hpt3x3 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_hpt3x3 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_it8213 it8213_sht: pata_it8213 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_it8213 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_it821x it821x_sht: pata_it821x <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_it821x 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_jmicron jmicron_sht: pata_jmicron <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_jmicron 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_marvell marvell_sht: pata_marvell <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_marvell 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_mpiix mpiix_sht: pata_mpiix <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_mpiix 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_netcell netcell_sht: pata_netcell <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_netcell 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_ninja32 ninja32_sht: pata_ninja32 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_ninja32 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_ns87410 ns87410_sht: pata_ns87410 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_ns87410 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_ns87415 ns87415_sht: pata_ns87415 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_ns87415 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_oldpiix oldpiix_sht: pata_oldpiix <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_oldpiix 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_optidma optidma_sht: pata_optidma <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_optidma 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_opti opti_sht: pata_opti <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_opti 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_pcmcia pcmcia_sht: pata_pcmcia <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_pcmcia 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_pdc2027x pdc2027x_sht: pata_pdc2027x <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_pdc2027x 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_pdc202xx_old pdc202xx_sht: pata_pdc202xx_old <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_pdc202xx_old 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_radisys radisys_sht: pata_radisys <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_radisys 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_rz1000 rz1000_sht: pata_rz1000 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_rz1000 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_serverworks serverworks_sht: pata_serverworks <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_serverworks 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_sil680 sil680_sht: pata_sil680 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_sil680 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_sis sis_sht: pata_sis <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_sis 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_sl82c105 sl82c105_sht: pata_sl82c105 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_sl82c105 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_triflex triflex_sht: pata_triflex <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_triflex 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_via via_sht: pata_via <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_via 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pdc_adma adma_ata_sht: pdc_adma <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pdc_adma 1 -1 128 0 4294967295 1 0 0 0 1 1 0 0 0 0
SHT sata_inic162x inic_sht: sata_inic162x <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <inic_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_inic162x 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sata_mv mv5_sht: sata_mv <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_mv 1 -1 88 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sata_mv mv6_sht: sata_mv <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_mv 1 -1 88 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sata_nv nv_adma_sht: sata_nv <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <nv_adma_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_change_queue_depth> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_nv 32 -1 61 0 4294967295 1 0 0 0 1 1 0 0 0 0
SHT sata_nv nv_sht: sata_nv <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_nv 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sata_nv nv_swncq_sht: sata_nv <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <nv_swncq_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_change_queue_depth> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_nv 32 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sata_promise pdc_ata_sht: sata_promise <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_promise 1 -1 127 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sata_qstor qs_ata_sht: sata_qstor <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_qstor 1 -1 128 0 18446744073709551615 1 0 0 0 1 1 0 0 0 0
SHT sata_sil24 sil24_sht: sata_sil24 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_change_queue_depth> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_sil24 31 -1 253 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sata_sil sil_sht: sata_sil <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_sil 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sata_sis sis_sht: sata_sis <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_sis 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sata_svw k2_sata_sht: sata_svw <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_svw 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sata_sx4 pdc_sata_sht: sata_sx4 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_sx4 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sata_uli uli_sht: sata_uli <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_uli 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sata_via svia_sht: sata_via <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_via 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sata_vsc vsc_sata_sht: sata_vsc <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_vsc 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sc1200 sc1200_sht: sc1200 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sc1200 1 -1 64 0 65535 1 0 0 0 1 1 0 0 0 0

--------------020203070305040007040100
Content-Type: text/plain;
 name="out.after"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="out.after"

OPS ahci ahci_ops: <sata_pmp_qc_defer_cmd_switch> <0000000000000000> <ahci_qc_prep> <ahci_qc_issue> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ahci_freeze> <ahci_thaw> <ahci_error_handler> <ahci_post_internal_cmd> <ahci_scr_read> <ahci_scr_write> <ahci_pmp_attach> <ahci_pmp_detach> <ahci_enable_alpm> <ahci_disable_alpm> <ahci_port_suspend> <ahci_port_resume> <ahci_port_start> <ahci_port_stop> <0000000000000000> <ata_noop_dev_select> <ahci_check_status> <ahci_check_status> <0000000000000000> <ahci_tf_read> <0000000000000000> <0000000000000000> <0000000000000000> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS ahci ahci_p5wdh_ops: <sata_pmp_qc_defer_cmd_switch> <0000000000000000> <ahci_qc_prep> <ahci_qc_issue> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ahci_freeze> <ahci_thaw> <ahci_p5wdh_error_handler> <ahci_post_internal_cmd> <ahci_scr_read> <ahci_scr_write> <ahci_pmp_attach> <ahci_pmp_detach> <ahci_enable_alpm> <ahci_disable_alpm> <ahci_port_suspend> <ahci_port_resume> <ahci_port_start> <ahci_port_stop> <0000000000000000> <ata_noop_dev_select> <ahci_check_status> <ahci_check_status> <0000000000000000> <ahci_tf_read> <0000000000000000> <0000000000000000> <0000000000000000> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS ahci ahci_vt8251_ops: <sata_pmp_qc_defer_cmd_switch> <0000000000000000> <ahci_qc_prep> <ahci_qc_issue> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ahci_freeze> <ahci_thaw> <ahci_vt8251_error_handler> <ahci_post_internal_cmd> <ahci_scr_read> <ahci_scr_write> <ahci_pmp_attach> <ahci_pmp_detach> <ahci_enable_alpm> <ahci_disable_alpm> <ahci_port_suspend> <ahci_port_resume> <ahci_port_start> <ahci_port_stop> <0000000000000000> <ata_noop_dev_select> <ahci_check_status> <ahci_check_status> <0000000000000000> <ahci_tf_read> <0000000000000000> <0000000000000000> <0000000000000000> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS ata_generic generic_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_unknown> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <generic_set_mode> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS ata_piix ich_pata_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ich_pata_cable_detect> <ata_pci_default_filter> <piix_set_piomode> <ich_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <piix_pata_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS ata_piix piix_pata_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <piix_set_piomode> <piix_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <piix_pata_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS ata_piix piix_sata_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS ata_piix piix_sidpr_sata_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <piix_sidpr_error_handler> <ata_bmdma_post_internal_cmd> <piix_sidpr_scr_read> <piix_sidpr_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <00000000000000
 00>
OPS ata_piix piix_vmw_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <piix_set_piomode> <piix_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <piix_pata_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <piix_vmw_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_acpi pacpi_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <pacpi_qc_issue_prot> <pacpi_cable_detect> <pacpi_mode_filter> <pacpi_set_piomode> <pacpi_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <pacpi_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <pacpi_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_ali ali_20_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ali_20_filter> <ali_set_piomode> <ali_set_dmamode> <0000000000000000> <ali_lock_sectors> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_ali ali_c2_port_ops: <0000000000000000> <ali_check_atapi_dma> <ata_qc_prep> <ata_qc_issue_prot> <ali_c2_cable_detect> <ata_pci_default_filter> <ali_set_piomode> <ali_set_dmamode> <0000000000000000> <ali_lock_sectors> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_ali ali_c5_port_ops: <0000000000000000> <ali_check_atapi_dma> <ata_qc_prep> <ata_qc_issue_prot> <ali_c2_cable_detect> <ata_pci_default_filter> <ali_set_piomode> <ali_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_ali ali_dma_base_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <ali_set_piomode> <ali_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_ali ali_early_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <0000000000000000> <ali_set_piomode> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS pata_amd amd100_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_unknown> <ata_pci_default_filter> <amd100_set_piomode> <amd100_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <amd_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_amd amd133_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <amd_cable_detect> <ata_pci_default_filter> <amd133_set_piomode> <amd133_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <amd_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_amd amd33_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <amd33_set_piomode> <amd33_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <amd_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_amd amd66_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_unknown> <ata_pci_default_filter> <amd66_set_piomode> <amd66_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <amd_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_amd amd_base_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <amd_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_amd nv100_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_ignore> <nv_mode_filter> <nv100_set_piomode> <nv100_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <nv_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <nv_host_stop> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_amd nv133_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_ignore> <nv_mode_filter> <nv133_set_piomode> <nv133_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <nv_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <nv_host_stop> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_amd nv_base_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_ignore> <nv_mode_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <nv_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <nv_host_stop> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_artop artop6210_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <artop6210_set_piomode> <artop6210_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <artop6210_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000
 >
OPS pata_artop artop6260_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <artop6260_cable_detect> <ata_pci_default_filter> <artop6260_set_piomode> <artop6260_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <artop6260_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000
 000000>
OPS pata_atiixp atiixp_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <atiixp_cable_detect> <ata_pci_default_filter> <atiixp_set_piomode> <atiixp_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <atiixp_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <atiixp_bmdma_start> <atiixp_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000
 000>
OPS pata_cmd640 cmd640_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <cmd640_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <cmd640_set_piomode> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <cmd640_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer_noirq> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000
 000>
OPS pata_cmd64x cmd646r1_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <cmd64x_set_piomode> <cmd64x_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <cmd646r1_bmdma_stop> <ata_bmdma_status> <0000000000000000> <000000000000
 0000>
OPS pata_cmd64x cmd648_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <cmd648_cable_detect> <ata_pci_default_filter> <cmd64x_set_piomode> <cmd64x_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <cmd648_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000
 000>
OPS pata_cmd64x cmd64x_base_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <cmd64x_set_piomode> <cmd64x_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_cmd64x cmd64x_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <cmd64x_set_piomode> <cmd64x_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_cs5520 cs5520_port_ops: <0000000000000000> <0000000000000000> <ata_dumb_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <cs5520_set_piomode> <cs5520_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <00000000000000
 00>
OPS pata_cs5530 cs5530_port_ops: <0000000000000000> <0000000000000000> <ata_dumb_qc_prep> <cs5530_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <cs5530_set_piomode> <cs5530_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <00000000000
 00000>
OPS pata_cypress cy82c693_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <cy82c693_set_piomode> <cy82c693_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <000000000000
 0000>
OPS pata_efar efar_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <efar_cable_detect> <ata_pci_default_filter> <efar_set_piomode> <efar_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <efar_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_hpt366 hpt366_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <hpt36x_cable_detect> <hpt366_filter> <hpt366_set_piomode> <hpt366_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_hpt37x hpt370a_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <hpt370a_filter> <hpt370_set_piomode> <hpt370_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <hpt37x_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <hpt370_bmdma_start> <hpt370_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_hpt37x hpt370_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <hpt370_filter> <hpt370_set_piomode> <hpt370_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <hpt37x_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <hpt370_bmdma_start> <hpt370_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_hpt37x hpt372_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <hpt372_set_piomode> <hpt372_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <hpt37x_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <hpt37x_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_hpt37x hpt374_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <hpt372_set_piomode> <hpt372_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <hpt374_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <hpt37x_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_hpt3x2n hpt3x2n_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <hpt3x2n_qc_issue_prot> <hpt3x2n_cable_detect> <ata_pci_default_filter> <hpt3x2n_set_piomode> <hpt3x2n_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <hpt3x2n_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <hpt3x2n_bmdma_stop> <ata_bmdma_status> <0000000000000000> <00000
 00000000000>
OPS pata_hpt3x3 hpt3x3_port_ops: <0000000000000000> <hpt3x3_atapi_dma> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <hpt3x3_set_piomode> <hpt3x3_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_it8213 it8213_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <it8213_cable_detect> <ata_pci_default_filter> <it8213_set_piomode> <it8213_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <it8213_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_it821x it821x_passthru_port_ops: <0000000000000000> <it821x_check_atapi_dma> <ata_qc_prep> <it821x_passthru_qc_issue_prot> <ata_cable_unknown> <ata_pci_default_filter> <it821x_passthru_set_piomode> <it821x_passthru_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <it821x_port_start> <0000000000000000> <0000000000000000> <it821x_passthru_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <it821x_passthru_bmdma_start> <it821x_pa
 ssthru_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_it821x it821x_smart_port_ops: <0000000000000000> <it821x_check_atapi_dma> <ata_qc_prep> <it821x_smart_qc_issue_prot> <it821x_ident_hack> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <it821x_smart_set_mode> <it821x_dev_config> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <it821x_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <000000000000000
 0> <0000000000000000>
OPS pata_jmicron jmicron_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <jmicron_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_marvell marvell_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <marvell_cable_detect> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <marvell_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_mpiix mpiix_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <mpiix_qc_issue_prot> <ata_cable_40wire> <0000000000000000> <mpiix_set_piomode> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <mpiix_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS pata_netcell netcell_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_80wire> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_ninja32 ninja32_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <ninja32_set_piomode> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ninja32_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_ns87410 ns87410_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ns87410_qc_issue_prot> <ata_cable_40wire> <0000000000000000> <ns87410_set_piomode> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ns87410_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS pata_ns87415 ns87415_pata_ops: <0000000000000000> <ns87415_check_atapi_dma> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <ns87415_set_piomode> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ns87415_bmdma_irq_clear> <ns87415_bmdma_setup> <ns87415_bmdma_start> <ns87415_bmdma_stop> <ata_bmdma_status> <00000000000000
 00> <0000000000000000>
OPS pata_oldpiix oldpiix_pata_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <oldpiix_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <oldpiix_set_piomode> <oldpiix_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <oldpiix_pata_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <00000000
 00000000>
OPS pata_optidma optidma_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <optidma_set_pio_mode> <optidma_set_dma_mode> <optidma_set_mode> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <optidma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <000000000000000
 0>
OPS pata_optidma optiplus_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <optiplus_set_pio_mode> <optiplus_set_dma_mode> <optidma_set_mode> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <optidma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <000000000000
 0000>
OPS pata_opti opti_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <opti_set_piomode> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <opti_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_pcmcia pcmcia_8bit_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <0000000000000000> <0000000000000000> <0000000000000000> <pcmcia_set_mode_8bit> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer_8bit> <ata_irq_on> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <000000000000
 0000>
OPS pata_pcmcia pcmcia_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <0000000000000000> <0000000000000000> <0000000000000000> <pcmcia_set_mode> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer_noirq> <ata_irq_on> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS pata_pdc2027x pdc2027x_pata100_ops: <0000000000000000> <pdc2027x_check_atapi_dma> <ata_qc_prep> <ata_qc_issue_prot> <pdc2027x_cable_detect> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <pdc2027x_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000
 000000000000>
OPS pata_pdc2027x pdc2027x_pata133_ops: <0000000000000000> <pdc2027x_check_atapi_dma> <ata_qc_prep> <ata_qc_issue_prot> <pdc2027x_cable_detect> <pdc2027x_mode_filter> <pdc2027x_set_piomode> <pdc2027x_set_dmamode> <pdc2027x_set_mode> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <pdc2027x_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000
 > <0000000000000000>
OPS pata_pdc202xx_old pdc2024x_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <pdc202xx_set_piomode> <pdc202xx_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000
 000000000>
OPS pata_pdc202xx_old pdc2026x_port_ops: <0000000000000000> <pdc2026x_check_atapi_dma> <ata_qc_prep> <ata_qc_issue_prot> <pdc2026x_cable_detect> <ata_pci_default_filter> <pdc202xx_set_piomode> <pdc202xx_set_dmamode> <0000000000000000> <pdc2026x_dev_config> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <pdc2026x_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <pdc2026x_bmdma_start> <pdc2026x_bmdma_stop> <ata_bmdma_status> 
 <0000000000000000> <0000000000000000>
OPS pata_radisys radisys_pata_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <radisys_qc_issue_prot> <ata_cable_unknown> <ata_pci_default_filter> <radisys_set_piomode> <radisys_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000
 000000>
OPS pata_rz1000 rz1000_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <rz1000_set_mode> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_serverworks serverworks_csb_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <serverworks_cable_detect> <serverworks_csb_filter> <serverworks_set_piomode> <serverworks_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <000000
 0000000000> <0000000000000000>
OPS pata_serverworks serverworks_osb4_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <serverworks_cable_detect> <serverworks_osb4_filter> <serverworks_set_piomode> <serverworks_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000
 000000000000> <0000000000000000>
OPS pata_sil680 sil680_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <sil680_cable_detect> <ata_pci_default_filter> <sil680_set_piomode> <sil680_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000
 >
OPS pata_sis sis_100_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <sis_66_cable_detect> <ata_pci_default_filter> <sis_100_set_piomode> <sis_100_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <sis_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_sis sis_133_early_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <sis_66_cable_detect> <ata_pci_default_filter> <sis_100_set_piomode> <sis_133_early_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <sis_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <000000000000000
 0>
OPS pata_sis sis_133_for_sata_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <sis_133_cable_detect> <ata_pci_default_filter> <sis_133_set_piomode> <sis_133_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <00000000000
 00000>
OPS pata_sis sis_133_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <sis_133_cable_detect> <ata_pci_default_filter> <sis_133_set_piomode> <sis_133_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <sis_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_sis sis_66_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <sis_66_cable_detect> <ata_pci_default_filter> <sis_old_set_piomode> <sis_66_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <sis_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_sis sis_base_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <sis_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_sis sis_old_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <sis_old_set_piomode> <sis_old_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <sis_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_sl82c105 sl82c105_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <sl82c105_set_piomode> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <sl82c105_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <sl82c105_bmdma_start> <sl82c105_bmdma_stop> <ata_bmdma_status> <0000000000000000> <000000
 0000000000>
OPS pata_triflex triflex_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <triflex_set_piomode> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <triflex_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <triflex_bmdma_start> <triflex_bmdma_stop> <ata_bmdma_status> <0000000000000000> <000000000000
 0000>
OPS pata_via via_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <via_cable_detect> <ata_pci_default_filter> <via_set_piomode> <via_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <via_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pata_via via_port_ops_noirq: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <via_cable_detect> <ata_pci_default_filter> <via_set_piomode> <via_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <via_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer_noirq> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS pdc_adma adma_ata_ops: <0000000000000000> <adma_check_atapi_dma> <adma_qc_prep> <adma_qc_issue> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <adma_freeze> <adma_thaw> <adma_error_handler> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <adma_port_start> <adma_port_stop> <adma_host_stop> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <adma_bmdma_stop> <adma_bmdma_status> <0000000000000000> <0000000000000000>
OPS sata_inic162x inic_port_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <inic_qc_issue> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <inic_dev_config> <inic_freeze> <inic_thaw> <inic_error_handler> <inic_post_internal_cmd> <inic_scr_read> <inic_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <inic_port_resume> <inic_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_noop_irq_clear> <inic_bmdma_setup> <inic_bmdma_start> <inic_bmdma_stop> <inic_bmdma_status> <0000000000000000> <0000000000000000>
OPS sata_mv mv5_ops: <0000000000000000> <0000000000000000> <mv_qc_prep> <mv_qc_issue> <ata_cable_sata> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <mv_eh_freeze> <mv_eh_thaw> <mv_error_handler> <mv_post_int_cmd> <mv5_scr_read> <mv5_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <mv_port_start> <mv_port_stop> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS sata_mv mv6_ops: <0000000000000000> <0000000000000000> <mv_qc_prep> <mv_qc_issue> <ata_cable_sata> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <mv_eh_freeze> <mv_eh_thaw> <mv_error_handler> <mv_post_int_cmd> <mv_scr_read> <mv_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <mv_port_start> <mv_port_stop> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS sata_mv mv_iie_ops: <0000000000000000> <0000000000000000> <mv_qc_prep_iie> <mv_qc_issue> <ata_cable_sata> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <mv_eh_freeze> <mv_eh_thaw> <mv_error_handler> <mv_post_int_cmd> <mv_scr_read> <mv_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <mv_port_start> <mv_port_stop> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS sata_nv nv_adma_ops: <ata_std_qc_defer> <nv_adma_check_atapi_dma> <nv_adma_qc_prep> <nv_adma_qc_issue> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <nv_adma_freeze> <nv_adma_thaw> <nv_adma_error_handler> <nv_adma_post_internal_cmd> <nv_scr_read> <nv_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <nv_adma_port_suspend> <nv_adma_port_resume> <nv_adma_port_start> <nv_adma_port_stop> <nv_adma_host_stop> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <nv_adma_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <nv_adma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS sata_nv nv_ck804_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <nv_ck804_freeze> <nv_ck804_thaw> <nv_error_handler> <ata_bmdma_post_internal_cmd> <nv_scr_read> <nv_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <nv_ck804_host_stop> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS sata_nv nv_generic_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <nv_error_handler> <ata_bmdma_post_internal_cmd> <nv_scr_read> <nv_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS sata_nv nv_nf2_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <nv_nf2_freeze> <nv_nf2_thaw> <nv_error_handler> <ata_bmdma_post_internal_cmd> <nv_scr_read> <nv_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS sata_nv nv_swncq_ops: <ata_std_qc_defer> <0000000000000000> <nv_swncq_qc_prep> <nv_swncq_qc_issue> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <nv_mcp55_freeze> <nv_mcp55_thaw> <nv_swncq_error_handler> <ata_bmdma_post_internal_cmd> <nv_scr_read> <nv_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <nv_swncq_port_suspend> <nv_swncq_port_resume> <nv_swncq_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS sata_promise pdc_common_ops: <0000000000000000> <pdc_check_atapi_dma> <pdc_qc_prep> <pdc_qc_issue_prot> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <pdc_freeze> <pdc_thaw> <ata_bmdma_error_handler> <pdc_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <pdc_tf_load_mmio> <ata_tf_read> <pdc_exec_command_mmio> <ata_data_xfer> <ata_irq_on> <pdc_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS sata_promise pdc_old_sata_ops: <0000000000000000> <pdc_old_sata_check_atapi_dma> <pdc_qc_prep> <pdc_qc_issue_prot> <pdc_sata_cable_detect> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <pdc_freeze> <pdc_thaw> <pdc_sata_error_handler> <pdc_post_internal_cmd> <pdc_sata_scr_read> <pdc_sata_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <pdc_sata_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <pdc_tf_load_mmio> <ata_tf_read> <pdc_exec_command_mmio> <ata_data_xfer> <ata_irq_on> <pdc_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
 
OPS sata_promise pdc_pata_ops: <0000000000000000> <pdc_check_atapi_dma> <pdc_qc_prep> <pdc_qc_issue_prot> <pdc_pata_cable_detect> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <pdc_freeze> <pdc_thaw> <pdc_pata_error_handler> <pdc_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <pdc_common_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <pdc_tf_load_mmio> <ata_tf_read> <pdc_exec_command_mmio> <ata_data_xfer> <ata_irq_on> <pdc_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS sata_promise pdc_sata_ops: <0000000000000000> <pdc_check_atapi_dma> <pdc_qc_prep> <pdc_qc_issue_prot> <pdc_sata_cable_detect> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <pdc_freeze> <pdc_thaw> <pdc_sata_error_handler> <pdc_post_internal_cmd> <pdc_sata_scr_read> <pdc_sata_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <pdc_sata_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <pdc_tf_load_mmio> <ata_tf_read> <pdc_exec_command_mmio> <ata_data_xfer> <ata_irq_on> <pdc_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS sata_qstor qs_ata_ops: <0000000000000000> <qs_check_atapi_dma> <qs_qc_prep> <qs_qc_issue> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <qs_freeze> <qs_thaw> <qs_error_handler> <0000000000000000> <qs_scr_read> <qs_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <qs_port_start> <0000000000000000> <qs_host_stop> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <qs_bmdma_stop> <qs_bmdma_status> <0000000000000000> <0000000000000000>
OPS sata_sil24 sil24_ops: <sil24_qc_defer> <0000000000000000> <sil24_qc_prep> <sil24_qc_issue> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <sil24_dev_config> <sil24_freeze> <sil24_thaw> <sil24_error_handler> <sil24_post_internal_cmd> <sil24_scr_read> <sil24_scr_write> <sil24_pmp_attach> <sil24_pmp_detach> <0000000000000000> <0000000000000000> <0000000000000000> <sil24_port_resume> <sil24_port_start> <0000000000000000> <0000000000000000> <ata_noop_dev_select> <sil24_check_status> <sil24_check_status> <0000000000000000> <sil24_tf_read> <0000000000000000> <0000000000000000> <0000000000000000> <ata_noop_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000>
OPS sata_sil sil_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <sil_set_mode> <sil_dev_config> <sil_freeze> <sil_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <sil_scr_read> <sil_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS sata_sis sis_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <sis_scr_read> <sis_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS sata_svw k2_sata_ops: <0000000000000000> <k2_sata_check_atapi_dma> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <k2_sata_scr_read> <k2_sata_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <k2_stat_check_status> <0000000000000000> <k2_sata_tf_load> <k2_sata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <k2_bmdma_setup_mmio> <k2_bmdma_start_mmio> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <00
 00000000000000>
OPS sata_sx4 pdc_20621_ops: <0000000000000000> <0000000000000000> <pdc20621_qc_prep> <pdc20621_qc_issue_prot> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <pdc_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <pdc_tf_load_mmio> <ata_tf_read> <pdc_exec_command_mmio> <ata_data_xfer> <ata_irq_on> <pdc20621_irq_clear> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <pdc_20621_phy_reset> <pdc_eng_timeout>
OPS sata_uli uli_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <uli_scr_read> <uli_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS sata_via vt6420_sata_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <svia_noop_freeze> <ata_bmdma_thaw> <vt6420_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS sata_via vt6421_pata_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <vt6421_pata_cable_detect> <ata_pci_default_filter> <vt6421_set_pio_mode> <vt6421_set_dma_mode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <000000000000
 0000>
OPS sata_via vt6421_sata_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <svia_scr_read> <svia_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS sata_vsc vsc_sata_ops: <0000000000000000> <0000000000000000> <ata_qc_prep> <ata_qc_issue_prot> <0000000000000000> <ata_pci_default_filter> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <vsc_freeze> <vsc_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <vsc_sata_scr_read> <vsc_sata_scr_write> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <vsc_sata_tf_load> <vsc_sata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000>
OPS sc1200 sc1200_port_ops: <0000000000000000> <0000000000000000> <ata_dumb_qc_prep> <sc1200_qc_issue_prot> <ata_cable_40wire> <ata_pci_default_filter> <sc1200_set_piomode> <sc1200_set_dmamode> <0000000000000000> <0000000000000000> <ata_bmdma_freeze> <ata_bmdma_thaw> <ata_bmdma_error_handler> <ata_bmdma_post_internal_cmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_sff_port_start> <0000000000000000> <0000000000000000> <ata_std_dev_select> <ata_check_status> <0000000000000000> <ata_tf_load> <ata_tf_read> <ata_exec_command> <ata_data_xfer> <ata_irq_on> <ata_bmdma_irq_clear> <ata_bmdma_setup> <ata_bmdma_start> <ata_bmdma_stop> <ata_bmdma_status> <0000000000000000> <0000000000000000
 >
SHT ahci ahci_sht: ahci <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_change_queue_depth> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> ahci 31 -1 168 0 4294967295 1 0 0 0 1 1 0 0 0 0
SHT ata_generic generic_sht: ata_generic <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> ata_generic 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT ata_piix piix_sht: ata_piix <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> ata_piix 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_acpi pacpi_sht: pata_acpi <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_acpi 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_ali ali_sht: pata_ali <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_ali 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_amd amd_sht: pata_amd <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_amd 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_artop artop_sht: pata_artop <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_artop 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_atiixp atiixp_sht: pata_atiixp <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_atiixp 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_cmd640 cmd640_sht: pata_cmd640 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_cmd640 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_cmd64x cmd64x_sht: pata_cmd64x <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_cmd64x 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_cs5520 cs5520_sht: pata_cs5520 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_cs5520 1 -1 64 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_cs5530 cs5530_sht: pata_cs5530 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_cs5530 1 -1 64 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_cypress cy82c693_sht: pata_cypress <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_cypress 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_efar efar_sht: pata_efar <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_efar 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_hpt366 hpt36x_sht: pata_hpt366 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_hpt366 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_hpt37x hpt37x_sht: pata_hpt37x <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_hpt37x 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_hpt3x2n hpt3x2n_sht: pata_hpt3x2n <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_hpt3x2n 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_hpt3x3 hpt3x3_sht: pata_hpt3x3 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_hpt3x3 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_it8213 it8213_sht: pata_it8213 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_it8213 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_it821x it821x_sht: pata_it821x <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_it821x 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_jmicron jmicron_sht: pata_jmicron <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_jmicron 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_marvell marvell_sht: pata_marvell <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_marvell 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_mpiix mpiix_sht: pata_mpiix <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_mpiix 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_netcell netcell_sht: pata_netcell <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_netcell 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_ninja32 ninja32_sht: pata_ninja32 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_ninja32 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_ns87410 ns87410_sht: pata_ns87410 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_ns87410 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_ns87415 ns87415_sht: pata_ns87415 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_ns87415 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_oldpiix oldpiix_sht: pata_oldpiix <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_oldpiix 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_optidma optidma_sht: pata_optidma <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_optidma 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_opti opti_sht: pata_opti <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_opti 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_pcmcia pcmcia_sht: pata_pcmcia <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_pcmcia 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_pdc2027x pdc2027x_sht: pata_pdc2027x <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_pdc2027x 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_pdc202xx_old pdc202xx_sht: pata_pdc202xx_old <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_pdc202xx_old 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_radisys radisys_sht: pata_radisys <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_radisys 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_rz1000 rz1000_sht: pata_rz1000 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_rz1000 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_serverworks serverworks_sht: pata_serverworks <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_serverworks 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_sil680 sil680_sht: pata_sil680 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_sil680 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_sis sis_sht: pata_sis <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_sis 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_sl82c105 sl82c105_sht: pata_sl82c105 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_sl82c105 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_triflex triflex_sht: pata_triflex <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_triflex 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pata_via via_sht: pata_via <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pata_via 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT pdc_adma adma_ata_sht: pdc_adma <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> pdc_adma 1 -1 128 0 4294967295 1 0 0 0 1 1 0 0 0 0
SHT sata_inic162x inic_sht: sata_inic162x <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <inic_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_inic162x 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sata_mv mv5_sht: sata_mv <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_mv 1 -1 88 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sata_mv mv6_sht: sata_mv <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_mv 1 -1 88 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sata_nv nv_adma_sht: sata_nv <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <nv_adma_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_change_queue_depth> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_nv 32 -1 61 0 4294967295 1 0 0 0 1 1 0 0 0 0
SHT sata_nv nv_sht: sata_nv <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_nv 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sata_nv nv_swncq_sht: sata_nv <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <nv_swncq_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_change_queue_depth> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_nv 32 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sata_promise pdc_ata_sht: sata_promise <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_promise 1 -1 127 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sata_qstor qs_ata_sht: sata_qstor <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_qstor 1 -1 128 0 18446744073709551615 1 0 0 0 1 1 0 0 0 0
SHT sata_sil24 sil24_sht: sata_sil24 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_change_queue_depth> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_sil24 31 -1 253 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sata_sil sil_sht: sata_sil <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_sil 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sata_sis sis_sht: sata_sis <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_sis 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sata_svw k2_sata_sht: sata_svw <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_svw 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sata_sx4 pdc_sata_sht: sata_sx4 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_sx4 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sata_uli uli_sht: sata_uli <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_uli 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sata_via svia_sht: sata_via <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_via 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sata_vsc vsc_sata_sht: sata_vsc <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sata_vsc 1 -1 128 0 65535 1 0 0 0 1 1 0 0 0 0
SHT sc1200 sc1200_sht: sc1200 <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_ioctl> <ata_scsi_queuecmd> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_scsi_slave_config> <ata_scsi_slave_destroy> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <0000000000000000> <ata_std_bios_param> <0000000000000000> <0000000000000000> sc1200 1 -1 64 0 65535 1 0 0 0 1 1 0 0 0 0

--------------020203070305040007040100--
