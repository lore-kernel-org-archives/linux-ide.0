From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/9] libata: implement and use ops inheritance
Date: Tue, 11 Mar 2008 21:06:01 +0900
Message-ID: <1205237167174-git-send-email-htejun@gmail.com>
References: <12052371651181-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:45241 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757375AbYCKMGZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Mar 2008 08:06:25 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2814301wah.23
        for <linux-ide@vger.kernel.org>; Tue, 11 Mar 2008 05:06:24 -0700 (PDT)
In-Reply-To: <12052371651181-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@arm.linux.org.uk, alessandro.zummo@towertech
Cc: Tejun Heo <htejun@gmail.com>

libata lets low level drivers build ata_port_operations table and
register it with libata core layer.  This allows low level drivers
high level of flexibility but also burdens them with lots of
boilerplate entries.

This becomes worse for drivers which support related similar
controllers which differ slightly.  They share most of the operations
except for a few.  However, the driver still needs to list all
operations for each variant.  This results in large number of
duplicate entries, which is not only inefficient but also error-prone
as it becomes very difficult to tell what the actual differences are.

This duplicate boilerplates all over the low level drivers also make
updating the core layer exteremely difficult and error-prone.  When
compounded with multi-branched development model, it ends up
accumulating inconsistencies over time.  Some of those inconsistencies
cause immediate problems and fixed.  Others just remain there dormant
making maintenance increasingly difficult.

To rectify the problem, this patch implements ata_port_operations
inheritance.  To allow LLDs to easily re-use their own ops tables
overriding only specific methods, this patch implements poor man's
class inheritance.  An ops table has ->inherits field which can be set
to any ops table as long as it doesn't create a loop.  When the host
is started, the inheritance chain is followed and any operation which
isn't specified is taken from the nearest ancestor which has it
specified.  This operation is called finalization and done only once
per an ops table and the LLD doesn't have to do anything special about
it other than making the ops table non-const such that libata can
update it.

libata provides four base ops tables lower drivers can inherit from -
base, sata, pmp, sff and bmdma.  To avoid overriding these ops
accidentaly, these ops are declared const and LLDs should always
inherit these instead of using them directly.

After finalization, all the ops table are identical before and after
the patch except for setting .irq_handler to ata_interrupt in drivers
which didn't use to.  The .irq_handler doesn't have any actual effect
and the field will soon be removed by later patch.

* sata_sx4 is still using old style EH and currently doesn't take
  advantage of ops inheritance.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c              |   94 ++-------------
 drivers/ata/ata_generic.c       |   31 +-----
 drivers/ata/ata_piix.c          |  149 ++--------------------
 drivers/ata/libata-core.c       |  113 +++++++++++++++++-
 drivers/ata/pata_acpi.c         |   35 +-----
 drivers/ata/pata_ali.c          |  122 ++----------------
 drivers/ata/pata_amd.c          |  191 ++++-------------------------
 drivers/ata/pata_artop.c        |   61 +--------
 drivers/ata/pata_at32.c         |   23 +---
 drivers/ata/pata_atiixp.c       |   32 +----
 drivers/ata/pata_bf54x.c        |    4 +-
 drivers/ata/pata_cmd640.c       |   33 +----
 drivers/ata/pata_cmd64x.c       |   96 ++-------------
 drivers/ata/pata_cs5520.c       |   29 +----
 drivers/ata/pata_cs5530.c       |   31 +----
 drivers/ata/pata_cs5535.c       |   31 +-----
 drivers/ata/pata_cs5536.c       |   31 +-----
 drivers/ata/pata_cypress.c      |   31 +-----
 drivers/ata/pata_efar.c         |   30 +----
 drivers/ata/pata_hpt366.c       |   32 +-----
 drivers/ata/pata_hpt37x.c       |  122 ++-----------------
 drivers/ata/pata_hpt3x2n.c      |   32 +----
 drivers/ata/pata_hpt3x3.c       |   33 +-----
 drivers/ata/pata_icside.c       |   32 ++----
 drivers/ata/pata_isapnp.c       |   21 +---
 drivers/ata/pata_it8213.c       |   31 +----
 drivers/ata/pata_it821x.c       |   57 ++--------
 drivers/ata/pata_ixp4xx_cf.c    |   23 +---
 drivers/ata/pata_jmicron.c      |   31 +-----
 drivers/ata/pata_legacy.c       |  260 +++------------------------------------
 drivers/ata/pata_marvell.c      |   33 +-----
 drivers/ata/pata_mpc52xx.c      |   18 +--
 drivers/ata/pata_mpiix.c        |   23 +---
 drivers/ata/pata_netcell.c      |   32 +-----
 drivers/ata/pata_ninja32.c      |   30 +----
 drivers/ata/pata_ns87410.c      |   25 +----
 drivers/ata/pata_ns87415.c      |   68 ++---------
 drivers/ata/pata_oldpiix.c      |   31 +----
 drivers/ata/pata_opti.c         |   23 +---
 drivers/ata/pata_optidma.c      |   63 +---------
 drivers/ata/pata_pcmcia.c       |   48 +-------
 drivers/ata/pata_pdc2027x.c     |   56 +--------
 drivers/ata/pata_pdc202xx_old.c |   75 +++---------
 drivers/ata/pata_platform.c     |   24 +---
 drivers/ata/pata_qdi.c          |   47 +-------
 drivers/ata/pata_radisys.c      |   32 +----
 drivers/ata/pata_rb500_cf.c     |   16 +---
 drivers/ata/pata_rz1000.c       |   25 +----
 drivers/ata/pata_sc1200.c       |   33 +-----
 drivers/ata/pata_scc.c          |    7 +-
 drivers/ata/pata_serverworks.c  |   63 +---------
 drivers/ata/pata_sil680.c       |   30 +----
 drivers/ata/pata_sis.c          |  177 +++------------------------
 drivers/ata/pata_sl82c105.c     |   34 +-----
 drivers/ata/pata_triflex.c      |   32 +----
 drivers/ata/pata_via.c          |   61 +---------
 drivers/ata/pata_winbond.c      |   25 +----
 drivers/ata/pdc_adma.c          |   19 ++--
 drivers/ata/sata_fsl.c          |    5 +-
 drivers/ata/sata_inic162x.c     |   19 +---
 drivers/ata/sata_mv.c           |   66 ++---------
 drivers/ata/sata_nv.c           |  113 +++--------------
 drivers/ata/sata_promise.c      |   64 +++--------
 drivers/ata/sata_qstor.c        |   20 ++--
 drivers/ata/sata_sil.c          |   21 +---
 drivers/ata/sata_sil24.c        |   20 +--
 drivers/ata/sata_sis.c          |   23 +---
 drivers/ata/sata_svw.c          |   18 +---
 drivers/ata/sata_sx4.c          |    3 +-
 drivers/ata/sata_uli.c          |   28 +----
 drivers/ata/sata_via.c          |   88 +------------
 drivers/ata/sata_vsc.c          |   19 +---
 include/linux/libata.h          |   23 +++-
 73 files changed, 523 insertions(+), 2998 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 9999258..e536c9b 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -276,118 +276,46 @@ static struct scsi_host_template ahci_sht = {
 	.shost_attrs		= ahci_shost_attrs,
 };
 
-static const struct ata_port_operations ahci_ops = {
+static struct ata_port_operations ahci_ops = {
+	.inherits		= &sata_pmp_port_ops,
+
 	.check_status		= ahci_check_status,
 	.check_altstatus	= ahci_check_status,
-	.dev_select		= ata_noop_dev_select,
-
-	.dev_config		= ahci_dev_config,
 
 	.tf_read		= ahci_tf_read,
-
 	.qc_defer		= sata_pmp_qc_defer_cmd_switch,
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
 
-	.irq_clear		= ata_noop_irq_clear,
-
-	.scr_read		= ahci_scr_read,
-	.scr_write		= ahci_scr_write,
-
 	.freeze			= ahci_freeze,
 	.thaw			= ahci_thaw,
-
 	.error_handler		= ahci_error_handler,
 	.post_internal_cmd	= ahci_post_internal_cmd,
-
-	.pmp_attach		= ahci_pmp_attach,
-	.pmp_detach		= ahci_pmp_detach,
-
-#ifdef CONFIG_PM
-	.port_suspend		= ahci_port_suspend,
-	.port_resume		= ahci_port_resume,
-#endif
-	.enable_pm		= ahci_enable_alpm,
-	.disable_pm		= ahci_disable_alpm,
-
-	.port_start		= ahci_port_start,
-	.port_stop		= ahci_port_stop,
-};
-
-static const struct ata_port_operations ahci_vt8251_ops = {
-	.check_status		= ahci_check_status,
-	.check_altstatus	= ahci_check_status,
-	.dev_select		= ata_noop_dev_select,
-
 	.dev_config		= ahci_dev_config,
 
-	.tf_read		= ahci_tf_read,
-
-	.qc_defer		= sata_pmp_qc_defer_cmd_switch,
-	.qc_prep		= ahci_qc_prep,
-	.qc_issue		= ahci_qc_issue,
-
-	.irq_clear		= ata_noop_irq_clear,
-
 	.scr_read		= ahci_scr_read,
 	.scr_write		= ahci_scr_write,
-
-	.freeze			= ahci_freeze,
-	.thaw			= ahci_thaw,
-
-	.error_handler		= ahci_vt8251_error_handler,
-	.post_internal_cmd	= ahci_post_internal_cmd,
-
 	.pmp_attach		= ahci_pmp_attach,
 	.pmp_detach		= ahci_pmp_detach,
 
+	.enable_pm		= ahci_enable_alpm,
+	.disable_pm		= ahci_disable_alpm,
 #ifdef CONFIG_PM
 	.port_suspend		= ahci_port_suspend,
 	.port_resume		= ahci_port_resume,
 #endif
-	.enable_pm		= ahci_enable_alpm,
-	.disable_pm		= ahci_disable_alpm,
-
 	.port_start		= ahci_port_start,
 	.port_stop		= ahci_port_stop,
 };
 
-static const struct ata_port_operations ahci_p5wdh_ops = {
-	.check_status		= ahci_check_status,
-	.check_altstatus	= ahci_check_status,
-	.dev_select		= ata_noop_dev_select,
-
-	.dev_config		= ahci_dev_config,
-
-	.tf_read		= ahci_tf_read,
-
-	.qc_defer		= sata_pmp_qc_defer_cmd_switch,
-	.qc_prep		= ahci_qc_prep,
-	.qc_issue		= ahci_qc_issue,
-
-	.irq_clear		= ata_noop_irq_clear,
-
-	.scr_read		= ahci_scr_read,
-	.scr_write		= ahci_scr_write,
-
-	.freeze			= ahci_freeze,
-	.thaw			= ahci_thaw,
+static struct ata_port_operations ahci_vt8251_ops = {
+	.inherits		= &ahci_ops,
+	.error_handler		= ahci_vt8251_error_handler,
+};
 
+static struct ata_port_operations ahci_p5wdh_ops = {
+	.inherits		= &ahci_ops,
 	.error_handler		= ahci_p5wdh_error_handler,
-	.post_internal_cmd	= ahci_post_internal_cmd,
-
-	.pmp_attach		= ahci_pmp_attach,
-	.pmp_detach		= ahci_pmp_detach,
-
-#ifdef CONFIG_PM
-	.port_suspend		= ahci_port_suspend,
-	.port_resume		= ahci_port_resume,
-#endif
-	.enable_pm		= ahci_enable_alpm,
-	.disable_pm		= ahci_disable_alpm,
-
-	.port_start		= ahci_port_start,
-	.port_stop		= ahci_port_stop,
 };
 
 #define AHCI_HFLAGS(flags)	.private_data	= (void *)(flags)
diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index 5c64ce1..0b5b515 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -99,36 +99,9 @@ static struct scsi_host_template generic_sht = {
 };
 
 static struct ata_port_operations generic_port_ops = {
-	.set_mode	= generic_set_mode,
-	.mode_filter	= ata_pci_default_filter,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.data_xfer	= ata_data_xfer,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.inherits	= &ata_bmdma_port_ops,
 	.cable_detect	= ata_cable_unknown,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
+	.set_mode	= generic_set_mode,
 };
 
 static int all_generic_ide;		/* Set to claim all devices */
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 9f887b2..bb46b61 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -294,155 +294,34 @@ static struct scsi_host_template piix_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
 };
 
-static const struct ata_port_operations piix_pata_ops = {
+static struct ata_port_operations piix_pata_ops = {
+	.inherits		= &ata_bmdma_port_ops,
+	.cable_detect		= ata_cable_40wire,
 	.set_piomode		= piix_set_piomode,
 	.set_dmamode		= piix_set_dmamode,
-	.mode_filter		= ata_pci_default_filter,
-
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= piix_pata_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.cable_detect		= ata_cable_40wire,
-
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
+};
 
-	.port_start		= ata_sff_port_start,
+static struct ata_port_operations piix_vmw_ops = {
+	.inherits		= &piix_pata_ops,
+	.bmdma_status		= piix_vmw_bmdma_status,
 };
 
-static const struct ata_port_operations ich_pata_ops = {
-	.set_piomode		= piix_set_piomode,
-	.set_dmamode		= ich_set_dmamode,
-	.mode_filter		= ata_pci_default_filter,
-
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= piix_pata_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+static struct ata_port_operations ich_pata_ops = {
+	.inherits		= &piix_pata_ops,
 	.cable_detect		= ich_pata_cable_detect,
-
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
+	.set_dmamode		= ich_set_dmamode,
 };
 
-static const struct ata_port_operations piix_sata_ops = {
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	.mode_filter		= ata_pci_default_filter,
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= ata_bmdma_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
+static struct ata_port_operations piix_sata_ops = {
+	.inherits		= &ata_bmdma_port_ops,
 };
 
-static const struct ata_port_operations piix_vmw_ops = {
-	.set_piomode		= piix_set_piomode,
-	.set_dmamode		= piix_set_dmamode,
-	.mode_filter		= ata_pci_default_filter,
-
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= piix_vmw_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= piix_pata_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.cable_detect		= ata_cable_40wire,
-
-	.irq_handler		= ata_interrupt,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
-};
-
-static const struct ata_port_operations piix_sidpr_sata_ops = {
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
+static struct ata_port_operations piix_sidpr_sata_ops = {
+	.inherits		= &piix_sata_ops,
 	.scr_read		= piix_sidpr_scr_read,
 	.scr_write		= piix_sidpr_scr_write,
-
-	.mode_filter		= ata_pci_default_filter,
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= piix_sidpr_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
 };
 
 static const struct piix_map_db ich5_map_db = {
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 006bd07..39e94f0 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -74,6 +74,56 @@ const unsigned long sata_deb_timing_normal[]		= {   5,  100, 2000 };
 const unsigned long sata_deb_timing_hotplug[]		= {  25,  500, 2000 };
 const unsigned long sata_deb_timing_long[]		= { 100, 2000, 5000 };
 
+const struct ata_port_operations ata_base_port_ops = {
+	.irq_clear		= ata_noop_irq_clear,
+};
+
+const struct ata_port_operations sata_port_ops = {
+	.inherits		= &ata_base_port_ops,
+
+	.qc_defer		= ata_std_qc_defer,
+	.dev_select		= ata_noop_dev_select,
+};
+
+const struct ata_port_operations sata_pmp_port_ops = {
+	.inherits		= &sata_port_ops,
+};
+
+const struct ata_port_operations ata_sff_port_ops = {
+	.inherits		= &ata_base_port_ops,
+
+	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= ata_bmdma_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+
+	.dev_select		= ata_std_dev_select,
+	.check_status		= ata_check_status,
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.exec_command		= ata_exec_command,
+	.data_xfer		= ata_data_xfer,
+	.irq_on			= ata_irq_on,
+
+	.port_start		= ata_sff_port_start,
+	.irq_handler		= ata_interrupt,
+};
+
+const struct ata_port_operations ata_bmdma_port_ops = {
+	.inherits		= &ata_sff_port_ops,
+
+	.mode_filter		= ata_pci_default_filter,
+
+	.bmdma_setup		= ata_bmdma_setup,
+	.bmdma_start		= ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
+	.irq_clear		= ata_bmdma_irq_clear,
+};
+
 static unsigned int ata_dev_init_params(struct ata_device *dev,
 					u16 heads, u16 sectors);
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
@@ -6924,6 +6974,56 @@ static void ata_host_stop(struct device *gendev, void *res)
 }
 
 /**
+ *	ata_finalize_port_ops - finalize ata_port_operations
+ *	@ops: ata_port_operations to finalize
+ *
+ *	An ata_port_operations can inherit from another ops and that
+ *	ops can again inherit from another.  This can go on as many
+ *	times as necessary as long as there is no loop in the
+ *	inheritance chain.
+ *
+ *	Ops tables are finalized when the host is started.  NULL or
+ *	unspecified entries are inherited from the closet ancestor
+ *	which has the method and the entry is populated with it.
+ *	After finalization, the ops table directly points to all the
+ *	methods and ->inherits is no longer necessary and cleared.
+ *
+ *	Using ATA_OP_NULL, inheriting ops can force a method to NULL.
+ *
+ *	LOCKING:
+ *	None.
+ */
+static void ata_finalize_port_ops(struct ata_port_operations *ops)
+{
+	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
+	const struct ata_port_operations *cur;
+	void **begin = (void **)ops;
+	void **end = (void **)&ops->inherits;
+	void **pp;
+
+	if (!ops || !ops->inherits)
+		return;
+
+	spin_lock(&lock);
+
+	for (cur = ops->inherits; cur; cur = cur->inherits) {
+		void **inherit = (void **)cur;
+
+		for (pp = begin; pp < end; pp++, inherit++)
+			if (!*pp)
+				*pp = *inherit;
+	}
+
+	for (pp = begin; pp < end; pp++)
+		if (IS_ERR(*pp))
+			*pp = NULL;
+
+	ops->inherits = NULL;
+
+	spin_unlock(&lock);
+}
+
+/**
  *	ata_host_start - start and freeze ports of an ATA host
  *	@host: ATA host to start ports for
  *
@@ -6948,9 +7048,13 @@ int ata_host_start(struct ata_host *host)
 	if (host->flags & ATA_HOST_STARTED)
 		return 0;
 
+	ata_finalize_port_ops(host->ops);
+
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 
+		ata_finalize_port_ops(ap->ops);
+
 		if (!host->ops && !ata_port_is_dummy(ap))
 			host->ops = ap->ops;
 
@@ -7012,7 +7116,7 @@ int ata_host_start(struct ata_host *host)
  */
 /* KILLME - the only user left is ipr */
 void ata_host_init(struct ata_host *host, struct device *dev,
-		   unsigned long flags, const struct ata_port_operations *ops)
+		   unsigned long flags, struct ata_port_operations *ops)
 {
 	spin_lock_init(&host->lock);
 	host->dev = dev;
@@ -7701,7 +7805,7 @@ static unsigned int ata_dummy_qc_issue(struct ata_queued_cmd *qc)
 	return AC_ERR_SYSTEM;
 }
 
-const struct ata_port_operations ata_dummy_port_ops = {
+struct ata_port_operations ata_dummy_port_ops = {
 	.check_status		= ata_dummy_check_status,
 	.check_altstatus	= ata_dummy_check_status,
 	.dev_select		= ata_noop_dev_select,
@@ -7729,6 +7833,11 @@ const struct ata_port_info ata_dummy_port_info = {
 EXPORT_SYMBOL_GPL(sata_deb_timing_normal);
 EXPORT_SYMBOL_GPL(sata_deb_timing_hotplug);
 EXPORT_SYMBOL_GPL(sata_deb_timing_long);
+EXPORT_SYMBOL_GPL(ata_base_port_ops);
+EXPORT_SYMBOL_GPL(sata_port_ops);
+EXPORT_SYMBOL_GPL(sata_pmp_port_ops);
+EXPORT_SYMBOL_GPL(ata_sff_port_ops);
+EXPORT_SYMBOL_GPL(ata_bmdma_port_ops);
 EXPORT_SYMBOL_GPL(ata_dummy_port_ops);
 EXPORT_SYMBOL_GPL(ata_dummy_port_info);
 EXPORT_SYMBOL_GPL(ata_std_bios_param);
diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
index 187545c..35ad488 100644
--- a/drivers/ata/pata_acpi.c
+++ b/drivers/ata/pata_acpi.c
@@ -235,39 +235,14 @@ static struct scsi_host_template pacpi_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
 };
 
-static const struct ata_port_operations pacpi_ops = {
+static struct ata_port_operations pacpi_ops = {
+	.inherits		= &ata_bmdma_port_ops,
+	.qc_issue		= pacpi_qc_issue_prot,
+	.cable_detect		= pacpi_cable_detect,
+	.mode_filter		= pacpi_mode_filter,
 	.set_piomode		= pacpi_set_piomode,
 	.set_dmamode		= pacpi_set_dmamode,
-	.mode_filter		= pacpi_mode_filter,
-
-	/* Task file is PCI ATA format, use helpers */
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= pacpi_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.cable_detect		= pacpi_cable_detect,
-
-	/* BMDMA handling is PCI ATA format, use helpers */
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= pacpi_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	/* Timeout handling */
-	.irq_handler		= ata_interrupt,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	/* Generic PATA PCI ATA helpers */
 	.port_start		= pacpi_port_start,
 };
 
diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index af028a6..ad9dce9 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -309,29 +309,15 @@ static struct scsi_host_template ali_sht = {
  */
 
 static struct ata_port_operations ali_early_port_ops = {
-	.set_piomode	= ali_set_piomode,
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.inherits	= &ata_sff_port_ops,
 	.cable_detect	= ata_cable_40wire,
+	.set_piomode	= ali_set_piomode,
+};
 
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_noop_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
+static const struct ata_port_operations ali_dma_base_ops = {
+	.inherits	= &ata_bmdma_port_ops,
+	.set_piomode	= ali_set_piomode,
+	.set_dmamode	= ali_set_dmamode,
 };
 
 /*
@@ -339,113 +325,29 @@ static struct ata_port_operations ali_early_port_ops = {
  *	detect
  */
 static struct ata_port_operations ali_20_port_ops = {
-	.set_piomode	= ali_set_piomode,
-	.set_dmamode	= ali_set_dmamode,
+	.inherits	= &ali_dma_base_ops,
+	.cable_detect	= ata_cable_40wire,
 	.mode_filter	= ali_20_filter,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
 	.dev_config	= ali_lock_sectors,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 /*
  *	Port operations for DMA capable ALi with cable detect
  */
 static struct ata_port_operations ali_c2_port_ops = {
-	.set_piomode	= ali_set_piomode,
-	.set_dmamode	= ali_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
+	.inherits	= &ali_dma_base_ops,
 	.check_atapi_dma = ali_check_atapi_dma,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-	.dev_config	= ali_lock_sectors,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ali_c2_cable_detect,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
+	.dev_config	= ali_lock_sectors,
 };
 
 /*
  *	Port operations for DMA capable ALi with cable detect and LBA48
  */
 static struct ata_port_operations ali_c5_port_ops = {
-	.set_piomode	= ali_set_piomode,
-	.set_dmamode	= ali_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
+	.inherits	= &ali_dma_base_ops,
 	.check_atapi_dma = ali_check_atapi_dma,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ali_c2_cable_detect,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 90d786d..b0cb4ea 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -356,204 +356,57 @@ static struct scsi_host_template amd_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
 };
 
+static const struct ata_port_operations amd_base_port_ops = {
+	.inherits	= &ata_bmdma_port_ops,
+	.error_handler	= amd_error_handler,
+};
+
 static struct ata_port_operations amd33_port_ops = {
+	.inherits	= &amd_base_port_ops,
+	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= amd33_set_piomode,
 	.set_dmamode	= amd33_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= amd_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 static struct ata_port_operations amd66_port_ops = {
+	.inherits	= &amd_base_port_ops,
+	.cable_detect	= ata_cable_unknown,
 	.set_piomode	= amd66_set_piomode,
 	.set_dmamode	= amd66_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= amd_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_unknown,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 static struct ata_port_operations amd100_port_ops = {
+	.inherits	= &amd_base_port_ops,
+	.cable_detect	= ata_cable_unknown,
 	.set_piomode	= amd100_set_piomode,
 	.set_dmamode	= amd100_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= amd_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_unknown,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 static struct ata_port_operations amd133_port_ops = {
+	.inherits	= &amd_base_port_ops,
+	.cable_detect	= amd_cable_detect,
 	.set_piomode	= amd133_set_piomode,
 	.set_dmamode	= amd133_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= amd_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= amd_cable_detect,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
+};
 
-	.port_start	= ata_sff_port_start,
+static const struct ata_port_operations nv_base_port_ops = {
+	.inherits	= &ata_bmdma_port_ops,
+	.cable_detect	= ata_cable_ignore,
+	.mode_filter	= nv_mode_filter,
+	.error_handler	= nv_error_handler,
+	.host_stop	= nv_host_stop,
 };
 
 static struct ata_port_operations nv100_port_ops = {
+	.inherits	= &nv_base_port_ops,
 	.set_piomode	= nv100_set_piomode,
 	.set_dmamode	= nv100_set_dmamode,
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= nv_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_ignore,
-	.mode_filter	= nv_mode_filter,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
-	.host_stop	= nv_host_stop,
 };
 
 static struct ata_port_operations nv133_port_ops = {
+	.inherits	= &nv_base_port_ops,
 	.set_piomode	= nv133_set_piomode,
 	.set_dmamode	= nv133_set_dmamode,
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= nv_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_ignore,
-	.mode_filter	= nv_mode_filter,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
-	.host_stop	= nv_host_stop,
 };
 
 static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index 7bfb7e8..0101e5a 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -317,69 +317,20 @@ static struct scsi_host_template artop_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
 };
 
-static const struct ata_port_operations artop6210_ops = {
+static struct ata_port_operations artop6210_ops = {
+	.inherits		= &ata_bmdma_port_ops,
+	.cable_detect		= ata_cable_40wire,
 	.set_piomode		= artop6210_set_piomode,
 	.set_dmamode		= artop6210_set_dmamode,
-	.mode_filter		= ata_pci_default_filter,
-
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= artop6210_error_handler,
-	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
-	.cable_detect		= ata_cable_40wire,
-
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-
-	.data_xfer		= ata_data_xfer,
-
-	.irq_handler		= ata_interrupt,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
 };
 
-static const struct ata_port_operations artop6260_ops = {
+static struct ata_port_operations artop6260_ops = {
+	.inherits		= &ata_bmdma_port_ops,
+	.cable_detect		= artop6260_cable_detect,
 	.set_piomode		= artop6260_set_piomode,
 	.set_dmamode		= artop6260_set_dmamode,
-	.mode_filter		= ata_pci_default_filter,
-
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= artop6260_error_handler,
-	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
-	.cable_detect		= artop6260_cable_detect,
-
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	.irq_handler		= ata_interrupt,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
 };
 
 
diff --git a/drivers/ata/pata_at32.c b/drivers/ata/pata_at32.c
index d7b7b7f..5283155 100644
--- a/drivers/ata/pata_at32.c
+++ b/drivers/ata/pata_at32.c
@@ -171,28 +171,9 @@ static struct scsi_host_template at32_sht = {
 };
 
 static struct ata_port_operations at32_port_ops = {
-	.set_piomode		= pata_at32_set_piomode,
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.exec_command		= ata_exec_command,
-	.check_status		= ata_check_status,
-	.dev_select		= ata_std_dev_select,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= ata_bmdma_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.inherits		= &ata_sff_port_ops,
 	.cable_detect		= ata_cable_40wire,
-
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-
-	.data_xfer		= ata_data_xfer,
-
-	.irq_clear		= ata_noop_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
+	.set_piomode		= pata_at32_set_piomode,
 };
 
 static int __init pata_at32_init_one(struct device *dev,
diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 645c472..2655f6a 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -226,36 +226,16 @@ static struct scsi_host_template atiixp_sht = {
 };
 
 static struct ata_port_operations atiixp_port_ops = {
-	.set_piomode	= atiixp_set_piomode,
-	.set_dmamode	= atiixp_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= atiixp_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= atiixp_cable_detect,
+	.inherits	= &ata_bmdma_port_ops,
 
-	.bmdma_setup 	= ata_bmdma_setup,
+	.qc_prep 	= ata_dumb_qc_prep,
 	.bmdma_start 	= atiixp_bmdma_start,
 	.bmdma_stop	= atiixp_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_dumb_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
 
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
+	.cable_detect	= atiixp_cable_detect,
+	.set_piomode	= atiixp_set_piomode,
+	.set_dmamode	= atiixp_set_dmamode,
+	.error_handler	= atiixp_error_handler,
 };
 
 static int atiixp_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index 6c75fca..7a22ef4 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -1363,6 +1363,8 @@ static struct scsi_host_template bfin_sht = {
 };
 
 static const struct ata_port_operations bfin_pata_ops = {
+	.inherits		= &ata_sff_port_ops,
+
 	.set_piomode		= bfin_set_piomode,
 	.set_dmamode		= bfin_set_dmamode,
 
@@ -1380,14 +1382,12 @@ static const struct ata_port_operations bfin_pata_ops = {
 	.data_xfer		= bfin_data_xfer,
 
 	.qc_prep		= ata_noop_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
 
 	.freeze			= bfin_bmdma_freeze,
 	.thaw			= bfin_bmdma_thaw,
 	.error_handler		= bfin_error_handler,
 	.post_internal_cmd	= bfin_bmdma_stop,
 
-	.irq_handler		= ata_interrupt,
 	.irq_clear		= bfin_irq_clear,
 	.irq_on			= bfin_irq_on,
 
diff --git a/drivers/ata/pata_cmd640.c b/drivers/ata/pata_cmd640.c
index 26562b8..061c891 100644
--- a/drivers/ata/pata_cmd640.c
+++ b/drivers/ata/pata_cmd640.c
@@ -170,35 +170,12 @@ static struct scsi_host_template cmd640_sht = {
 };
 
 static struct ata_port_operations cmd640_port_ops = {
-	.set_piomode	= cmd640_set_piomode,
-	.mode_filter	= ata_pci_default_filter,
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= cmd640_qc_issue_prot,
-
-	/* In theory this is not needed once we kill the prefetcher */
+	.inherits	= &ata_bmdma_port_ops,
+	/* In theory xfer_noirq is not needed once we kill the prefetcher */
 	.data_xfer	= ata_data_xfer_noirq,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
+	.qc_issue	= cmd640_qc_issue_prot,
+	.cable_detect	= ata_cable_40wire,
+	.set_piomode	= cmd640_set_piomode,
 	.port_start	= cmd640_port_start,
 };
 
diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index 6aea05c..1ac8ecf 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -269,103 +269,27 @@ static struct scsi_host_template cmd64x_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
 };
 
-static struct ata_port_operations cmd64x_port_ops = {
+static const struct ata_port_operations cmd64x_base_ops = {
+	.inherits	= &ata_bmdma_port_ops,
 	.set_piomode	= cmd64x_set_piomode,
 	.set_dmamode	= cmd64x_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
-static struct ata_port_operations cmd646r1_port_ops = {
-	.set_piomode	= cmd64x_set_piomode,
-	.set_dmamode	= cmd64x_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+static struct ata_port_operations cmd64x_port_ops = {
+	.inherits	= &cmd64x_base_ops,
 	.cable_detect	= ata_cable_40wire,
+};
 
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
+static struct ata_port_operations cmd646r1_port_ops = {
+	.inherits	= &cmd64x_base_ops,
 	.bmdma_stop	= cmd646r1_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
+	.cable_detect	= ata_cable_40wire,
 };
 
 static struct ata_port_operations cmd648_port_ops = {
-	.set_piomode	= cmd64x_set_piomode,
-	.set_dmamode	= cmd64x_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= cmd648_cable_detect,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
+	.inherits	= &cmd64x_base_ops,
 	.bmdma_stop	= cmd648_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
+	.cable_detect	= cmd648_cable_detect,
 };
 
 static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 7e64309..46d0ce3 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -145,34 +145,11 @@ static struct scsi_host_template cs5520_sht = {
 };
 
 static struct ata_port_operations cs5520_port_ops = {
+	.inherits		= &ata_bmdma_port_ops,
+	.qc_prep		= ata_dumb_qc_prep,
+	.cable_detect		= ata_cable_40wire,
 	.set_piomode		= cs5520_set_piomode,
 	.set_dmamode		= cs5520_set_dmamode,
-	.mode_filter		= ata_pci_default_filter,
-
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= ata_bmdma_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.cable_detect		= ata_cable_40wire,
-
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_dumb_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
 };
 
 static int __devinit cs5520_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index 0bb03da..e4a16a5 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -166,37 +166,14 @@ static struct scsi_host_template cs5530_sht = {
 };
 
 static struct ata_port_operations cs5530_port_ops = {
-	.set_piomode	= cs5530_set_piomode,
-	.set_dmamode	= cs5530_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
+	.inherits	= &ata_bmdma_port_ops,
 
 	.qc_prep 	= ata_dumb_qc_prep,
 	.qc_issue	= cs5530_qc_issue_prot,
 
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
+	.cable_detect	= ata_cable_40wire,
+	.set_piomode	= cs5530_set_piomode,
+	.set_dmamode	= cs5530_set_dmamode,
 };
 
 static const struct dmi_system_id palmax_dmi_table[] = {
diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
index 48a1834..f910a8a 100644
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -162,37 +162,10 @@ static struct scsi_host_template cs5535_sht = {
 };
 
 static struct ata_port_operations cs5535_port_ops = {
+	.inherits	= &ata_bmdma_port_ops,
+	.cable_detect	= cs5535_cable_detect,
 	.set_piomode	= cs5535_set_piomode,
 	.set_dmamode	= cs5535_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= cs5535_cable_detect,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 /**
diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
index f02d910..075ee6a 100644
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -225,37 +225,10 @@ static struct scsi_host_template cs5536_sht = {
 };
 
 static struct ata_port_operations cs5536_port_ops = {
+	.inherits		= &ata_bmdma_port_ops,
+	.cable_detect		= cs5536_cable_detect,
 	.set_piomode		= cs5536_set_piomode,
 	.set_dmamode		= cs5536_set_dmamode,
-	.mode_filter		= ata_pci_default_filter,
-
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= ata_bmdma_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.cable_detect		= cs5536_cable_detect,
-
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-
-	.data_xfer		= ata_data_xfer,
-
-	.irq_handler		= ata_interrupt,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
 };
 
 /**
diff --git a/drivers/ata/pata_cypress.c b/drivers/ata/pata_cypress.c
index 07fa1ab..c459553 100644
--- a/drivers/ata/pata_cypress.c
+++ b/drivers/ata/pata_cypress.c
@@ -114,37 +114,10 @@ static struct scsi_host_template cy82c693_sht = {
 };
 
 static struct ata_port_operations cy82c693_port_ops = {
+	.inherits	= &ata_bmdma_port_ops,
+	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= cy82c693_set_piomode,
 	.set_dmamode	= cy82c693_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 static int cy82c693_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
diff --git a/drivers/ata/pata_efar.c b/drivers/ata/pata_efar.c
index 8700d9d..ef62fc6 100644
--- a/drivers/ata/pata_efar.c
+++ b/drivers/ata/pata_efar.c
@@ -236,36 +236,12 @@ static struct scsi_host_template efar_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
 };
 
-static const struct ata_port_operations efar_ops = {
+static struct ata_port_operations efar_ops = {
+	.inherits		= &ata_bmdma_port_ops,
+	.cable_detect		= efar_cable_detect,
 	.set_piomode		= efar_set_piomode,
 	.set_dmamode		= efar_set_dmamode,
-	.mode_filter		= ata_pci_default_filter,
-
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= efar_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.cable_detect		= efar_cable_detect,
-
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	.irq_handler		= ata_interrupt,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
 };
 
 
diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index a30028d..788955f 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -298,37 +298,11 @@ static struct scsi_host_template hpt36x_sht = {
  */
 
 static struct ata_port_operations hpt366_port_ops = {
+	.inherits	= &ata_bmdma_port_ops,
+	.cable_detect	= hpt36x_cable_detect,
+	.mode_filter	= hpt366_filter,
 	.set_piomode	= hpt366_set_piomode,
 	.set_dmamode	= hpt366_set_dmamode,
-	.mode_filter	= hpt366_filter,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= hpt36x_cable_detect,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 /**
diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index 7d6fac4..c42eec7 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -627,36 +627,15 @@ static struct scsi_host_template hpt37x_sht = {
  */
 
 static struct ata_port_operations hpt370_port_ops = {
-	.set_piomode	= hpt370_set_piomode,
-	.set_dmamode	= hpt370_set_dmamode,
-	.mode_filter	= hpt370_filter,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= hpt37x_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.inherits	= &ata_bmdma_port_ops,
 
-	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= hpt370_bmdma_start,
 	.bmdma_stop	= hpt370_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
 
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
+	.mode_filter	= hpt370_filter,
+	.set_piomode	= hpt370_set_piomode,
+	.set_dmamode	= hpt370_set_dmamode,
+	.error_handler	= hpt37x_error_handler,
 };
 
 /*
@@ -664,36 +643,8 @@ static struct ata_port_operations hpt370_port_ops = {
  */
 
 static struct ata_port_operations hpt370a_port_ops = {
-	.set_piomode	= hpt370_set_piomode,
-	.set_dmamode	= hpt370_set_dmamode,
+	.inherits	= &hpt370_port_ops,
 	.mode_filter	= hpt370a_filter,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= hpt37x_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= hpt370_bmdma_start,
-	.bmdma_stop	= hpt370_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 /*
@@ -702,36 +653,13 @@ static struct ata_port_operations hpt370a_port_ops = {
  */
 
 static struct ata_port_operations hpt372_port_ops = {
-	.set_piomode	= hpt372_set_piomode,
-	.set_dmamode	= hpt372_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= hpt37x_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.inherits	= &ata_bmdma_port_ops,
 
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
 	.bmdma_stop	= hpt37x_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
 
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
+	.set_piomode	= hpt372_set_piomode,
+	.set_dmamode	= hpt372_set_dmamode,
+	.error_handler	= hpt37x_error_handler,
 };
 
 /*
@@ -740,36 +668,8 @@ static struct ata_port_operations hpt372_port_ops = {
  */
 
 static struct ata_port_operations hpt374_port_ops = {
-	.set_piomode	= hpt372_set_piomode,
-	.set_dmamode	= hpt372_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
+	.inherits	= &hpt372_port_ops,
 	.error_handler	= hpt374_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= hpt37x_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 /**
diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index aa380c4..b77b127 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -347,37 +347,15 @@ static struct scsi_host_template hpt3x2n_sht = {
  */
 
 static struct ata_port_operations hpt3x2n_port_ops = {
-	.set_piomode	= hpt3x2n_set_piomode,
-	.set_dmamode	= hpt3x2n_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
+	.inherits	= &ata_bmdma_port_ops,
 
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= hpt3x2n_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= hpt3x2n_cable_detect,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
 	.bmdma_stop	= hpt3x2n_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= hpt3x2n_qc_issue_prot,
 
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
+	.cable_detect	= hpt3x2n_cable_detect,
+	.set_piomode	= hpt3x2n_set_piomode,
+	.set_dmamode	= hpt3x2n_set_dmamode,
+	.error_handler	= hpt3x2n_error_handler,
 };
 
 /**
diff --git a/drivers/ata/pata_hpt3x3.c b/drivers/ata/pata_hpt3x3.c
index 9837ab0..8857d02 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -106,40 +106,13 @@ static struct scsi_host_template hpt3x3_sht = {
 };
 
 static struct ata_port_operations hpt3x3_port_ops = {
+	.inherits	= &ata_bmdma_port_ops,
+	.check_atapi_dma= hpt3x3_atapi_dma,
+	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= hpt3x3_set_piomode,
 #if defined(CONFIG_PATA_HPT3X3_DMA)
 	.set_dmamode	= hpt3x3_set_dmamode,
 #endif
-	.mode_filter	= ata_pci_default_filter,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-	.check_atapi_dma= hpt3x3_atapi_dma,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 /**
diff --git a/drivers/ata/pata_icside.c b/drivers/ata/pata_icside.c
index 88a1c7a..ff16b0e 100644
--- a/drivers/ata/pata_icside.c
+++ b/drivers/ata/pata_icside.c
@@ -339,35 +339,19 @@ static void pata_icside_error_handler(struct ata_port *ap)
 }
 
 static struct ata_port_operations pata_icside_port_ops = {
-	.set_dmamode		= pata_icside_set_dmamode,
-
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.exec_command		= ata_exec_command,
-	.check_status		= ata_check_status,
-	.dev_select		= ata_std_dev_select,
-
-	.cable_detect		= ata_cable_40wire,
-
-	.bmdma_setup		= pata_icside_bmdma_setup,
-	.bmdma_start		= pata_icside_bmdma_start,
-
-	.data_xfer		= ata_data_xfer_noirq,
-
+	.inherits		= &ata_sff_port_ops,
 	/* no need to build any PRD tables for DMA */
 	.qc_prep		= ata_noop_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
+	.data_xfer		= ata_data_xfer_noirq,
+	.bmdma_setup		= pata_icside_bmdma_setup,
+	.bmdma_start		= pata_icside_bmdma_start,
+	.bmdma_stop		= pata_icside_bmdma_stop,
+	.bmdma_status		= pata_icside_bmdma_status,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
+	.cable_detect		= ata_cable_40wire,
+	.set_dmamode		= pata_icside_set_dmamode,
 	.error_handler		= pata_icside_error_handler,
 	.post_internal_cmd	= pata_icside_bmdma_stop,
-
-	.irq_clear		= ata_noop_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.bmdma_stop		= pata_icside_bmdma_stop,
-	.bmdma_status		= pata_icside_bmdma_status,
 };
 
 static void __devinit
diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
index 91ca4d5..085913e 100644
--- a/drivers/ata/pata_isapnp.c
+++ b/drivers/ata/pata_isapnp.c
@@ -24,27 +24,8 @@ static struct scsi_host_template isapnp_sht = {
 };
 
 static struct ata_port_operations isapnp_port_ops = {
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.inherits	= &ata_sff_port_ops,
 	.cable_detect	= ata_cable_40wire,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_clear	= ata_noop_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 /**
diff --git a/drivers/ata/pata_it8213.c b/drivers/ata/pata_it8213.c
index 678a05b..9ce8952 100644
--- a/drivers/ata/pata_it8213.c
+++ b/drivers/ata/pata_it8213.c
@@ -246,36 +246,13 @@ static struct scsi_host_template it8213_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
 };
 
-static const struct ata_port_operations it8213_ops = {
+
+static struct ata_port_operations it8213_ops = {
+	.inherits		= &ata_bmdma_port_ops,
+	.cable_detect		= it8213_cable_detect,
 	.set_piomode		= it8213_set_piomode,
 	.set_dmamode		= it8213_set_dmamode,
-	.mode_filter		= ata_pci_default_filter,
-
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= it8213_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.cable_detect		= it8213_cable_detect,
-
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	.irq_handler		= ata_interrupt,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
 };
 
 
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 491ea69..f7ac52e 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -636,71 +636,30 @@ static struct scsi_host_template it821x_sht = {
 };
 
 static struct ata_port_operations it821x_smart_port_ops = {
-	.set_mode	= it821x_smart_set_mode,
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.mode_filter	= ata_pci_default_filter,
+	.inherits	= &ata_bmdma_port_ops,
 
-	.check_status 	= ata_check_status,
 	.check_atapi_dma= it821x_check_atapi_dma,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-	.dev_config	= it821x_dev_config,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= it821x_ident_hack,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= it821x_smart_qc_issue_prot,
 
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
+	.cable_detect	= it821x_ident_hack,
+	.set_mode	= it821x_smart_set_mode,
+	.dev_config	= it821x_dev_config,
 
 	.port_start	= it821x_port_start,
 };
 
 static struct ata_port_operations it821x_passthru_port_ops = {
-	.set_piomode	= it821x_passthru_set_piomode,
-	.set_dmamode	= it821x_passthru_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
+	.inherits	= &ata_bmdma_port_ops,
 
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
 	.check_atapi_dma= it821x_check_atapi_dma,
 	.dev_select 	= it821x_passthru_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_unknown,
-
-	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= it821x_passthru_bmdma_start,
 	.bmdma_stop	= it821x_passthru_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= it821x_passthru_qc_issue_prot,
 
-	.data_xfer	= ata_data_xfer,
-
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_handler	= ata_interrupt,
-	.irq_on		= ata_irq_on,
+	.cable_detect	= ata_cable_unknown,
+	.set_piomode	= it821x_passthru_set_piomode,
+	.set_dmamode	= it821x_passthru_set_dmamode,
 
 	.port_start	= it821x_port_start,
 };
diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index b7e8e82..d02629a 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -92,29 +92,10 @@ static struct scsi_host_template ixp4xx_sht = {
 };
 
 static struct ata_port_operations ixp4xx_port_ops = {
-	.set_mode		= ixp4xx_set_mode,
-
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.exec_command		= ata_exec_command,
-	.check_status 		= ata_check_status,
-	.dev_select 		= ata_std_dev_select,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= ata_bmdma_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-
-	.qc_prep 		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
+	.inherits		= &ata_sff_port_ops,
 	.data_xfer		= ixp4xx_mmio_data_xfer,
 	.cable_detect		= ata_cable_40wire,
-
-	.irq_handler		= ata_interrupt,
-	.irq_clear		= ata_noop_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
+	.set_mode		= ixp4xx_set_mode,
 };
 
 static void ixp4xx_setup_port(struct ata_port *ap,
diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index 69781af..61ff5c6 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -125,36 +125,9 @@ static struct scsi_host_template jmicron_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
 };
 
-static const struct ata_port_operations jmicron_ops = {
-	/* Task file is PCI ATA format, use helpers */
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.mode_filter		= ata_pci_default_filter,
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
+static struct ata_port_operations jmicron_ops = {
+	.inherits		= &ata_bmdma_port_ops,
 	.error_handler		= jmicron_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-
-	/* BMDMA handling is PCI ATA format, use helpers */
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	/* IRQ-related hooks */
-	.irq_handler		= ata_interrupt,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	/* Generic PATA PCI ATA helpers */
-	.port_start		= ata_sff_port_start,
 };
 
 
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index 5329b95..2474068 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -211,6 +211,11 @@ static struct scsi_host_template legacy_sht = {
 	ATA_PIO_SHT(DRV_NAME),
 };
 
+static const struct ata_port_operations legacy_base_port_ops = {
+	.inherits	= &ata_sff_port_ops,
+	.cable_detect	= ata_cable_40wire,
+};
+
 /*
  *	These ops are used if the user indicates the hardware
  *	snoops the commands to decide on the mode and handles the
@@ -220,55 +225,14 @@ static struct scsi_host_template legacy_sht = {
  */
 
 static struct ata_port_operations simple_port_ops = {
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
+	.inherits	= &legacy_base_port_ops,
 	.data_xfer	= ata_data_xfer_noirq,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_noop_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 static struct ata_port_operations legacy_port_ops = {
-	.set_mode	= legacy_set_mode,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-	.cable_detect	= ata_cable_40wire,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
+	.inherits	= &legacy_base_port_ops,
 	.data_xfer	= ata_data_xfer_noirq,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_noop_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
+	.set_mode	= legacy_set_mode,
 };
 
 /*
@@ -359,30 +323,9 @@ static unsigned int pdc_data_xfer_vlb(struct ata_device *dev,
 }
 
 static struct ata_port_operations pdc20230_port_ops = {
+	.inherits	= &legacy_base_port_ops,
 	.set_piomode	= pdc20230_set_piomode,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
 	.data_xfer	= pdc_data_xfer_vlb,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_noop_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 /*
@@ -413,30 +356,8 @@ static void ht6560a_set_piomode(struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct ata_port_operations ht6560a_port_ops = {
+	.inherits	= &legacy_base_port_ops,
 	.set_piomode	= ht6560a_set_piomode,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,	/* Check vlb/noirq */
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_noop_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 /*
@@ -478,30 +399,8 @@ static void ht6560b_set_piomode(struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct ata_port_operations ht6560b_port_ops = {
+	.inherits	= &legacy_base_port_ops,
 	.set_piomode	= ht6560b_set_piomode,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,    /* FIXME: Check 32bit and noirq */
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_noop_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 /*
@@ -599,30 +498,8 @@ static void opti82c611a_set_piomode(struct ata_port *ap,
 
 
 static struct ata_port_operations opti82c611a_port_ops = {
+	.inherits	= &legacy_base_port_ops,
 	.set_piomode	= opti82c611a_set_piomode,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_noop_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 /*
@@ -731,30 +608,9 @@ static unsigned int opti82c46x_qc_issue_prot(struct ata_queued_cmd *qc)
 }
 
 static struct ata_port_operations opti82c46x_port_ops = {
+	.inherits	= &legacy_base_port_ops,
 	.set_piomode	= opti82c46x_set_piomode,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= opti82c46x_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_noop_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 static void qdi6500_set_piomode(struct ata_port *ap, struct ata_device *adev)
@@ -916,84 +772,22 @@ static int qdi_port(struct platform_device *dev,
 }
 
 static struct ata_port_operations qdi6500_port_ops = {
+	.inherits	= &legacy_base_port_ops,
 	.set_piomode	= qdi6500_set_piomode,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= qdi_qc_issue_prot,
-
 	.data_xfer	= vlb32_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_noop_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 static struct ata_port_operations qdi6580_port_ops = {
+	.inherits	= &legacy_base_port_ops,
 	.set_piomode	= qdi6580_set_piomode,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
 	.data_xfer	= vlb32_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_noop_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 static struct ata_port_operations qdi6580dp_port_ops = {
+	.inherits	= &legacy_base_port_ops,
 	.set_piomode	= qdi6580dp_set_piomode,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= qdi_qc_issue_prot,
-
 	.data_xfer	= vlb32_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_noop_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 static DEFINE_SPINLOCK(winbond_lock);
@@ -1062,29 +856,9 @@ static int winbond_port(struct platform_device *dev,
 }
 
 static struct ata_port_operations winbond_port_ops = {
+	.inherits	= &legacy_base_port_ops,
 	.set_piomode	= winbond_set_piomode,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
 	.data_xfer	= vlb32_data_xfer,
-
-	.irq_clear	= ata_noop_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 static struct legacy_controller controllers[] = {
diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index 9de6e42..286310f 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -95,37 +95,10 @@ static struct scsi_host_template marvell_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
 };
 
-static const struct ata_port_operations marvell_ops = {
-	/* Task file is PCI ATA format, use helpers */
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.mode_filter		= ata_pci_default_filter,
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= marvell_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+static struct ata_port_operations marvell_ops = {
+	.inherits		= &ata_bmdma_port_ops,
 	.cable_detect		= marvell_cable_detect,
-
-	/* BMDMA handling is PCI ATA format, use helpers */
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	/* Timeout handling */
-	.irq_handler		= ata_interrupt,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	/* Generic PATA PCI ATA helpers */
-	.port_start		= ata_sff_port_start,
+	.error_handler		= marvell_error_handler,
 };
 
 
diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 4117b61..ac7c082 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -269,22 +269,12 @@ static struct scsi_host_template mpc52xx_ata_sht = {
 };
 
 static struct ata_port_operations mpc52xx_ata_port_ops = {
-	.set_piomode		= mpc52xx_ata_set_piomode,
+	.inherits		= &ata_sff_port_ops,
 	.dev_select		= mpc52xx_ata_dev_select,
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= mpc52xx_ata_error_handler,
 	.cable_detect		= ata_cable_40wire,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-	.irq_clear		= ata_noop_irq_clear,
-	.irq_on			= ata_irq_on,
-	.port_start		= ata_sff_port_start,
+	.set_piomode		= mpc52xx_ata_set_piomode,
+	.error_handler		= mpc52xx_ata_error_handler,
+	.post_internal_cmd	= ATA_OP_NULL,
 };
 
 static int __devinit
diff --git a/drivers/ata/pata_mpiix.c b/drivers/ata/pata_mpiix.c
index e8e6837..dab54f8 100644
--- a/drivers/ata/pata_mpiix.c
+++ b/drivers/ata/pata_mpiix.c
@@ -155,28 +155,11 @@ static struct scsi_host_template mpiix_sht = {
 };
 
 static struct ata_port_operations mpiix_port_ops = {
+	.inherits	= &ata_sff_port_ops,
+	.qc_issue	= mpiix_qc_issue_prot,
+	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= mpiix_set_piomode,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= mpiix_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= mpiix_qc_issue_prot,
-	.data_xfer	= ata_data_xfer,
-
-	.irq_clear	= ata_noop_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 static int mpiix_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff --git a/drivers/ata/pata_netcell.c b/drivers/ata/pata_netcell.c
index 11f200a..65389d1 100644
--- a/drivers/ata/pata_netcell.c
+++ b/drivers/ata/pata_netcell.c
@@ -24,37 +24,9 @@ static struct scsi_host_template netcell_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
 };
 
-static const struct ata_port_operations netcell_ops = {
-	/* Task file is PCI ATA format, use helpers */
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.mode_filter		= ata_pci_default_filter,
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= ata_bmdma_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+static struct ata_port_operations netcell_ops = {
+	.inherits	= &ata_bmdma_port_ops,
 	.cable_detect		= ata_cable_80wire,
-
-	/* BMDMA handling is PCI ATA format, use helpers */
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	/* IRQ-related hooks */
-	.irq_handler		= ata_interrupt,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	/* Generic PATA PCI ATA helpers */
-	.port_start		= ata_sff_port_start,
 };
 
 
diff --git a/drivers/ata/pata_ninja32.c b/drivers/ata/pata_ninja32.c
index ce3b07c..8213d08 100644
--- a/drivers/ata/pata_ninja32.c
+++ b/drivers/ata/pata_ninja32.c
@@ -83,36 +83,10 @@ static struct scsi_host_template ninja32_sht = {
 };
 
 static struct ata_port_operations ninja32_port_ops = {
-	.set_piomode	= ninja32_set_piomode,
-	.mode_filter	= ata_pci_default_filter,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
+	.inherits	= &ata_bmdma_port_ops,
 	.dev_select 	= ninja32_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
+	.set_piomode	= ninja32_set_piomode,
 };
 
 static int ninja32_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff --git a/drivers/ata/pata_ns87410.c b/drivers/ata/pata_ns87410.c
index d2f85f1..5b1982f 100644
--- a/drivers/ata/pata_ns87410.c
+++ b/drivers/ata/pata_ns87410.c
@@ -148,30 +148,11 @@ static struct scsi_host_template ns87410_sht = {
 };
 
 static struct ata_port_operations ns87410_port_ops = {
+	.inherits	= &ata_sff_port_ops,
+	.qc_issue	= ns87410_qc_issue_prot,
+	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= ns87410_set_piomode,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ns87410_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ns87410_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_noop_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 static int ns87410_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff --git a/drivers/ata/pata_ns87415.c b/drivers/ata/pata_ns87415.c
index 78d6344..38d86a2 100644
--- a/drivers/ata/pata_ns87415.c
+++ b/drivers/ata/pata_ns87415.c
@@ -297,73 +297,29 @@ static u8 ns87560_bmdma_status(struct ata_port *ap)
 {
 	return ns87560_read_buggy(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
 }
+#endif		/* 87560 SuperIO Support */
 
-static const struct ata_port_operations ns87560_pata_ops = {
-	.set_piomode		= ns87415_set_piomode,
-	.mode_filter		= ata_pci_default_filter,
+static struct ata_port_operations ns87415_pata_ops = {
+	.inherits		= &ata_bmdma_port_ops,
 
-	.tf_load		= ata_tf_load,
-	.tf_read		= ns87560_tf_read,
-	.check_status		= ns87560_check_status,
 	.check_atapi_dma	= ns87415_check_atapi_dma,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= ata_bmdma_error_handler,
-	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
-	.cable_detect		= ata_cable_40wire,
-
 	.bmdma_setup		= ns87415_bmdma_setup,
 	.bmdma_start		= ns87415_bmdma_start,
 	.bmdma_stop		= ns87415_bmdma_stop,
-	.bmdma_status		= ns87560_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	.irq_handler		= ata_interrupt,
 	.irq_clear		= ns87415_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
-};
-
-#endif		/* 87560 SuperIO Support */
-
-
-static const struct ata_port_operations ns87415_pata_ops = {
-	.set_piomode		= ns87415_set_piomode,
-	.mode_filter		= ata_pci_default_filter,
 
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.check_atapi_dma	= ns87415_check_atapi_dma,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= ata_bmdma_error_handler,
-	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_40wire,
+	.set_piomode		= ns87415_set_piomode,
+};
 
-	.bmdma_setup		= ns87415_bmdma_setup,
-	.bmdma_start		= ns87415_bmdma_start,
-	.bmdma_stop		= ns87415_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	.irq_handler		= ata_interrupt,
-	.irq_clear		= ns87415_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
+#if defined(CONFIG_SUPERIO)
+static struct ata_port_operations ns87560_pata_ops = {
+	.inherits		= &ns87415_pata_ops,
+	.tf_read		= ns87560_tf_read,
+	.check_status		= ns87560_check_status,
+	.bmdma_status		= ns87560_bmdma_status,
 };
+#endif
 
 static struct scsi_host_template ns87415_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
index 45f9b3e..f6062b3 100644
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -223,36 +223,13 @@ static struct scsi_host_template oldpiix_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
 };
 
-static const struct ata_port_operations oldpiix_pata_ops = {
+static struct ata_port_operations oldpiix_pata_ops = {
+	.inherits		= &ata_bmdma_port_ops,
+	.qc_issue		= oldpiix_qc_issue_prot,
+	.cable_detect		= ata_cable_40wire,
 	.set_piomode		= oldpiix_set_piomode,
 	.set_dmamode		= oldpiix_set_dmamode,
-	.mode_filter		= ata_pci_default_filter,
-
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= oldpiix_pata_error_handler,
-	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
-	.cable_detect		= ata_cable_40wire,
-
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= oldpiix_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	.irq_handler		= ata_interrupt,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
 };
 
 
diff --git a/drivers/ata/pata_opti.c b/drivers/ata/pata_opti.c
index 1deacfa..c4a0795 100644
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -169,29 +169,10 @@ static struct scsi_host_template opti_sht = {
 };
 
 static struct ata_port_operations opti_port_ops = {
+	.inherits	= &ata_sff_port_ops,
+	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= opti_set_piomode,
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= opti_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_noop_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 static int opti_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index 7495758..eb4b081 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -354,73 +354,18 @@ static struct scsi_host_template optidma_sht = {
 };
 
 static struct ata_port_operations optidma_port_ops = {
+	.inherits	= &ata_bmdma_port_ops,
+	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= optidma_set_pio_mode,
 	.set_dmamode	= optidma_set_dma_mode,
-	.mode_filter	= ata_pci_default_filter,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.error_handler	= optidma_error_handler,
 	.set_mode	= optidma_set_mode,
-	.cable_detect	= ata_cable_40wire,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
+	.error_handler	= optidma_error_handler,
 };
 
 static struct ata_port_operations optiplus_port_ops = {
+	.inherits	= &optidma_port_ops,
 	.set_piomode	= optiplus_set_pio_mode,
 	.set_dmamode	= optiplus_set_dma_mode,
-	.mode_filter	= ata_pci_default_filter,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.error_handler	= optidma_error_handler,
-	.set_mode	= optidma_set_mode,
-	.cable_detect	= ata_cable_40wire,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 /**
diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index c05b36c..57efbf0 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -132,53 +132,17 @@ static struct scsi_host_template pcmcia_sht = {
 };
 
 static struct ata_port_operations pcmcia_port_ops = {
-	.set_mode	= pcmcia_set_mode,
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
+	.inherits	= &ata_sff_port_ops,
 	.data_xfer	= ata_data_xfer_noirq,
-
-	.irq_clear	= ata_noop_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
+	.cable_detect	= ata_cable_40wire,
+	.set_mode	= pcmcia_set_mode,
 };
 
 static struct ata_port_operations pcmcia_8bit_port_ops = {
-	.set_mode	= pcmcia_set_mode_8bit,
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
+	.inherits	= &ata_sff_port_ops,
 	.data_xfer	= ata_data_xfer_8bit,
-
-	.irq_clear	= ata_noop_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
+	.cable_detect	= ata_cable_40wire,
+	.set_mode	= pcmcia_set_mode_8bit,
 };
 
 #define CS_CHECK(fn, ret) \
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 229d9ac..f619c20 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -133,66 +133,18 @@ static struct scsi_host_template pdc2027x_sht = {
 };
 
 static struct ata_port_operations pdc2027x_pata100_ops = {
-	.mode_filter		= ata_pci_default_filter,
-
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
+	.inherits		= &ata_bmdma_port_ops,
 	.check_atapi_dma	= pdc2027x_check_atapi_dma,
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= pdc2027x_error_handler,
-	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= pdc2027x_cable_detect,
-
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
+	.error_handler		= pdc2027x_error_handler,
 };
 
 static struct ata_port_operations pdc2027x_pata133_ops = {
+	.inherits		= &pdc2027x_pata100_ops,
+	.mode_filter		= pdc2027x_mode_filter,
 	.set_piomode		= pdc2027x_set_piomode,
 	.set_dmamode		= pdc2027x_set_dmamode,
 	.set_mode		= pdc2027x_set_mode,
-	.mode_filter		= pdc2027x_mode_filter,
-
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.check_atapi_dma	= pdc2027x_check_atapi_dma,
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= pdc2027x_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.cable_detect		= pdc2027x_cable_detect,
-
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
 };
 
 static struct ata_port_info pdc2027x_port_info[] = {
diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
index 564ee07..4daac20 100644
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -266,69 +266,24 @@ static struct scsi_host_template pdc202xx_sht = {
 };
 
 static struct ata_port_operations pdc2024x_port_ops = {
-	.set_piomode	= pdc202xx_set_piomode,
-	.set_dmamode	= pdc202xx_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
+	.inherits		= &ata_bmdma_port_ops,
+
+	.cable_detect		= ata_cable_40wire,
+	.set_piomode		= pdc202xx_set_piomode,
+	.set_dmamode		= pdc202xx_set_dmamode,
 };
 
 static struct ata_port_operations pdc2026x_port_ops = {
-	.set_piomode	= pdc202xx_set_piomode,
-	.set_dmamode	= pdc202xx_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-	.dev_config	= pdc2026x_dev_config,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= pdc2026x_cable_detect,
-
-	.check_atapi_dma= pdc2026x_check_atapi_dma,
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= pdc2026x_bmdma_start,
-	.bmdma_stop	= pdc2026x_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= pdc2026x_port_start,
+	.inherits		= &pdc2024x_port_ops,
+
+	.check_atapi_dma	= pdc2026x_check_atapi_dma,
+	.bmdma_start		= pdc2026x_bmdma_start,
+	.bmdma_stop		= pdc2026x_bmdma_stop,
+
+	.cable_detect		= pdc2026x_cable_detect,
+	.dev_config		= pdc2026x_dev_config,
+
+	.port_start		= pdc2026x_port_start,
 };
 
 static int pdc202xx_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index cd2d03a..0588c9b 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -51,27 +51,11 @@ static struct scsi_host_template pata_platform_sht = {
 };
 
 static struct ata_port_operations pata_platform_port_ops = {
-	.set_mode		= pata_platform_set_mode,
-
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= ata_bmdma_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.cable_detect		= ata_cable_unknown,
-
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-
+	.inherits		= &ata_sff_port_ops,
 	.data_xfer		= ata_data_xfer_noirq,
-
-	.irq_clear		= ata_noop_irq_clear,
-	.irq_on			= ata_irq_on,
+	.cable_detect		= ata_cable_unknown,
+	.set_mode		= pata_platform_set_mode,
+	.port_start		= ATA_OP_NULL,
 };
 
 static void pata_platform_setup_port(struct ata_ioports *ioaddr,
diff --git a/drivers/ata/pata_qdi.c b/drivers/ata/pata_qdi.c
index ccb8682..d16b343 100644
--- a/drivers/ata/pata_qdi.c
+++ b/drivers/ata/pata_qdi.c
@@ -158,55 +158,16 @@ static struct scsi_host_template qdi_sht = {
 };
 
 static struct ata_port_operations qdi6500_port_ops = {
-	.set_piomode	= qdi6500_set_piomode,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.qc_prep 	= ata_qc_prep,
+	.inherits	= &ata_sff_port_ops,
 	.qc_issue	= qdi_qc_issue_prot,
-
 	.data_xfer	= qdi_data_xfer,
-
-	.irq_clear	= ata_noop_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
+	.cable_detect	= ata_cable_40wire,
+	.set_piomode	= qdi6500_set_piomode,
 };
 
 static struct ata_port_operations qdi6580_port_ops = {
+	.inherits	= &qdi6500_port_ops,
 	.set_piomode	= qdi6580_set_piomode,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= qdi_qc_issue_prot,
-
-	.data_xfer	= qdi_data_xfer,
-
-	.irq_clear	= ata_noop_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 /**
diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
index 3981bf8..94e60b3 100644
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -188,36 +188,12 @@ static struct scsi_host_template radisys_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
 };
 
-static const struct ata_port_operations radisys_pata_ops = {
+static struct ata_port_operations radisys_pata_ops = {
+	.inherits		= &ata_bmdma_port_ops,
+	.qc_issue		= radisys_qc_issue_prot,
+	.cable_detect		= ata_cable_unknown,
 	.set_piomode		= radisys_set_piomode,
 	.set_dmamode		= radisys_set_dmamode,
-	.mode_filter		= ata_pci_default_filter,
-
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= ata_bmdma_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.cable_detect		= ata_cable_unknown,
-
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= radisys_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	.irq_handler		= ata_interrupt,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
 };
 
 
diff --git a/drivers/ata/pata_rb500_cf.c b/drivers/ata/pata_rb500_cf.c
index 4543c98..7affcee 100644
--- a/drivers/ata/pata_rb500_cf.c
+++ b/drivers/ata/pata_rb500_cf.c
@@ -118,25 +118,11 @@ static irqreturn_t rb500_pata_irq_handler(int irq, void *dev_instance)
 }
 
 static struct ata_port_operations rb500_pata_port_ops = {
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-
+	.inherits		= &ata_sff_port_ops,
 	.exec_command		= rb500_pata_exec_command,
-	.check_status 		= ata_check_status,
-	.dev_select 		= ata_std_dev_select,
-
 	.data_xfer		= rb500_pata_data_xfer,
-
-	.qc_prep 		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-
 	.freeze			= rb500_pata_freeze,
 	.thaw			= rb500_pata_thaw,
-	.error_handler		= ata_bmdma_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-
-	.irq_clear		= ata_noop_irq_clear,
-	.irq_on			= ata_irq_on,
 };
 
 /* ------------------------------------------------------------------------ */
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index 80909a6..a2aef73 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -57,30 +57,9 @@ static struct scsi_host_template rz1000_sht = {
 };
 
 static struct ata_port_operations rz1000_port_ops = {
-	.set_mode	= rz1000_set_mode,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.inherits	= &ata_sff_port_ops,
 	.cable_detect	= ata_cable_40wire,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_noop_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
+	.set_mode	= rz1000_set_mode,
 };
 
 static int rz1000_fifo_disable(struct pci_dev *pdev)
diff --git a/drivers/ata/pata_sc1200.c b/drivers/ata/pata_sc1200.c
index 38ce6e1..362b7f8 100644
--- a/drivers/ata/pata_sc1200.c
+++ b/drivers/ata/pata_sc1200.c
@@ -184,37 +184,12 @@ static struct scsi_host_template sc1200_sht = {
 };
 
 static struct ata_port_operations sc1200_port_ops = {
-	.set_piomode	= sc1200_set_piomode,
-	.set_dmamode	= sc1200_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
+	.inherits	= &ata_bmdma_port_ops,
 	.qc_prep 	= ata_dumb_qc_prep,
 	.qc_issue	= sc1200_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
+	.cable_detect	= ata_cable_40wire,
+	.set_piomode	= sc1200_set_piomode,
+	.set_dmamode	= sc1200_set_dmamode,
 };
 
 /**
diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
index 1833e9e..033d1f3 100644
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -972,6 +972,8 @@ static struct scsi_host_template scc_sht = {
 };
 
 static const struct ata_port_operations scc_pata_ops = {
+	.inherits		= &ata_bmdma_port_ops,
+
 	.set_piomode		= scc_set_piomode,
 	.set_dmamode		= scc_set_dmamode,
 	.mode_filter		= scc_mode_filter,
@@ -989,12 +991,7 @@ static const struct ata_port_operations scc_pata_ops = {
 	.bmdma_status		= scc_bmdma_status,
 	.data_xfer		= scc_data_xfer,
 
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-
 	.freeze			= scc_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-
 	.error_handler		= scc_error_handler,
 	.post_internal_cmd	= scc_bmdma_stop,
 
diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index 318a369..627abcf 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -302,71 +302,16 @@ static struct scsi_host_template serverworks_sht = {
 };
 
 static struct ata_port_operations serverworks_osb4_port_ops = {
+	.inherits	= &ata_bmdma_port_ops,
+	.cable_detect	= serverworks_cable_detect,
+	.mode_filter	= serverworks_osb4_filter,
 	.set_piomode	= serverworks_set_piomode,
 	.set_dmamode	= serverworks_set_dmamode,
-	.mode_filter	= serverworks_osb4_filter,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= serverworks_cable_detect,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 static struct ata_port_operations serverworks_csb_port_ops = {
-	.set_piomode	= serverworks_set_piomode,
-	.set_dmamode	= serverworks_set_dmamode,
+	.inherits	= &serverworks_osb4_port_ops,
 	.mode_filter	= serverworks_csb_filter,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= serverworks_cable_detect,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 static int serverworks_fixup_osb4(struct pci_dev *pdev)
diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 6ebf6f7..bc3253d 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -196,36 +196,10 @@ static struct scsi_host_template sil680_sht = {
 };
 
 static struct ata_port_operations sil680_port_ops = {
+	.inherits	= &ata_bmdma_port_ops,
+	.cable_detect	= sil680_cable_detect,
 	.set_piomode	= sil680_set_piomode,
 	.set_dmamode	= sil680_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= sil680_cable_detect,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 /**
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index dcd8457..3ed6286 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -517,196 +517,51 @@ static struct scsi_host_template sis_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
 };
 
-static const struct ata_port_operations sis_133_ops = {
+static struct ata_port_operations sis_133_for_sata_ops = {
+	.inherits		= &ata_bmdma_port_ops,
 	.set_piomode		= sis_133_set_piomode,
 	.set_dmamode		= sis_133_set_dmamode,
-	.mode_filter		= ata_pci_default_filter,
-
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= sis_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= sis_133_cable_detect,
+};
 
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	.irq_handler		= ata_interrupt,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
+static struct ata_port_operations sis_base_ops = {
+	.inherits		= &ata_bmdma_port_ops,
+	.error_handler		= sis_error_handler,
 };
 
-static const struct ata_port_operations sis_133_for_sata_ops = {
+static struct ata_port_operations sis_133_ops = {
+	.inherits		= &sis_base_ops,
 	.set_piomode		= sis_133_set_piomode,
 	.set_dmamode		= sis_133_set_dmamode,
-	.mode_filter		= ata_pci_default_filter,
-
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= ata_bmdma_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= sis_133_cable_detect,
-
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	.irq_handler		= ata_interrupt,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
 };
 
-static const struct ata_port_operations sis_133_early_ops = {
+static struct ata_port_operations sis_133_early_ops = {
+	.inherits		= &sis_base_ops,
 	.set_piomode		= sis_100_set_piomode,
 	.set_dmamode		= sis_133_early_set_dmamode,
-	.mode_filter		= ata_pci_default_filter,
-
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= sis_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= sis_66_cable_detect,
-
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	.irq_handler		= ata_interrupt,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
 };
 
-static const struct ata_port_operations sis_100_ops = {
+static struct ata_port_operations sis_100_ops = {
+	.inherits		= &sis_base_ops,
 	.set_piomode		= sis_100_set_piomode,
 	.set_dmamode		= sis_100_set_dmamode,
-	.mode_filter		= ata_pci_default_filter,
-
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= sis_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= sis_66_cable_detect,
-
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	.irq_handler		= ata_interrupt,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
 };
 
-static const struct ata_port_operations sis_66_ops = {
+static struct ata_port_operations sis_66_ops = {
+	.inherits		= &sis_base_ops,
 	.set_piomode		= sis_old_set_piomode,
 	.set_dmamode		= sis_66_set_dmamode,
-	.mode_filter		= ata_pci_default_filter,
-
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
 	.cable_detect		= sis_66_cable_detect,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= sis_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	.irq_handler		= ata_interrupt,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
 };
 
-static const struct ata_port_operations sis_old_ops = {
+static struct ata_port_operations sis_old_ops = {
+	.inherits		= &sis_base_ops,
 	.set_piomode		= sis_old_set_piomode,
 	.set_dmamode		= sis_old_set_dmamode,
-	.mode_filter		= ata_pci_default_filter,
-
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= sis_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_40wire,
-
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	.irq_handler		= ata_interrupt,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_info sis_info = {
diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
index ece366b..0dd8e2f 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -239,37 +239,13 @@ static struct scsi_host_template sl82c105_sht = {
 };
 
 static struct ata_port_operations sl82c105_port_ops = {
-	.set_piomode	= sl82c105_set_piomode,
-	.mode_filter	= ata_pci_default_filter,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= sl82c105_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.bmdma_setup 	= ata_bmdma_setup,
+	.inherits	= &ata_bmdma_port_ops,
+	.qc_defer	= sl82c105_qc_defer,
 	.bmdma_start 	= sl82c105_bmdma_start,
 	.bmdma_stop	= sl82c105_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_defer	= sl82c105_qc_defer,
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
+	.cable_detect	= ata_cable_40wire,
+	.set_piomode	= sl82c105_set_piomode,
+	.error_handler	= sl82c105_error_handler,
 };
 
 /**
diff --git a/drivers/ata/pata_triflex.c b/drivers/ata/pata_triflex.c
index 5105699..bc4956e 100644
--- a/drivers/ata/pata_triflex.c
+++ b/drivers/ata/pata_triflex.c
@@ -184,36 +184,12 @@ static struct scsi_host_template triflex_sht = {
 };
 
 static struct ata_port_operations triflex_port_ops = {
-	.set_piomode	= triflex_set_piomode,
-	.mode_filter	= ata_pci_default_filter,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= triflex_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.bmdma_setup 	= ata_bmdma_setup,
+	.inherits	= &ata_bmdma_port_ops,
 	.bmdma_start 	= triflex_bmdma_start,
 	.bmdma_stop	= triflex_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
+	.cable_detect	= ata_cable_40wire,
+	.set_piomode	= triflex_set_piomode,
+	.error_handler	= triflex_error_handler,
 };
 
 static int triflex_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index a7bc860..d1edb1b 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -339,71 +339,16 @@ static struct scsi_host_template via_sht = {
 };
 
 static struct ata_port_operations via_port_ops = {
+	.inherits	= &ata_bmdma_port_ops,
+	.cable_detect	= via_cable_detect,
 	.set_piomode	= via_set_piomode,
 	.set_dmamode	= via_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= via_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= via_cable_detect,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 static struct ata_port_operations via_port_ops_noirq = {
-	.set_piomode	= via_set_piomode,
-	.set_dmamode	= via_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= via_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= via_cable_detect,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
+	.inherits	= &via_port_ops,
 	.data_xfer	= ata_data_xfer_noirq,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
 };
 
 /**
diff --git a/drivers/ata/pata_winbond.c b/drivers/ata/pata_winbond.c
index 9bafae9..f235bb0 100644
--- a/drivers/ata/pata_winbond.c
+++ b/drivers/ata/pata_winbond.c
@@ -126,29 +126,10 @@ static struct scsi_host_template winbond_sht = {
 };
 
 static struct ata_port_operations winbond_port_ops = {
-	.set_piomode	= winbond_set_piomode,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_40wire,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
+	.inherits	= &ata_sff_port_ops,
 	.data_xfer	= winbond_data_xfer,
-
-	.irq_clear	= ata_noop_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
+	.cable_detect	= ata_cable_40wire,
+	.set_piomode	= winbond_set_piomode,
 };
 
 /**
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index fdf62de..a570614 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -148,26 +148,29 @@ static struct scsi_host_template adma_ata_sht = {
 	.dma_boundary		= ADMA_DMA_BOUNDARY,
 };
 
-static const struct ata_port_operations adma_ata_ops = {
+static struct ata_port_operations adma_ata_ops = {
+	.inherits		= &ata_base_port_ops,
+
+	.dev_select		= ata_std_dev_select,
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
-	.exec_command		= ata_exec_command,
 	.check_status		= ata_check_status,
-	.dev_select		= ata_std_dev_select,
-	.check_atapi_dma	= adma_check_atapi_dma,
+	.exec_command		= ata_exec_command,
 	.data_xfer		= ata_data_xfer,
+	.check_atapi_dma	= adma_check_atapi_dma,
+	.bmdma_stop		= adma_bmdma_stop,
+	.bmdma_status		= adma_bmdma_status,
 	.qc_prep		= adma_qc_prep,
 	.qc_issue		= adma_qc_issue,
+	.irq_on			= ata_irq_on,
+
 	.freeze			= adma_freeze,
 	.thaw			= adma_thaw,
 	.error_handler		= adma_error_handler,
-	.irq_clear		= ata_noop_irq_clear,
-	.irq_on			= ata_irq_on,
+
 	.port_start		= adma_port_start,
 	.port_stop		= adma_port_stop,
 	.host_stop		= adma_host_stop,
-	.bmdma_stop		= adma_bmdma_stop,
-	.bmdma_status		= adma_bmdma_status,
 };
 
 static struct ata_port_info adma_port_info[] = {
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index f616ff8..ca74a59 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1198,16 +1198,15 @@ static struct scsi_host_template sata_fsl_sht = {
 };
 
 static const struct ata_port_operations sata_fsl_ops = {
+	.inherits = &sata_port_ops,
+
 	.check_status = sata_fsl_check_status,
 	.check_altstatus = sata_fsl_check_status,
-	.dev_select = ata_noop_dev_select,
 
 	.tf_read = sata_fsl_tf_read,
 
-	.qc_defer = ata_std_qc_defer,
 	.qc_prep = sata_fsl_qc_prep,
 	.qc_issue = sata_fsl_qc_issue,
-	.irq_clear = ata_noop_irq_clear,
 
 	.scr_read = sata_fsl_scr_read,
 	.scr_write = sata_fsl_scr_write,
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index bb853df..047f80f 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -522,26 +522,13 @@ static int inic_port_start(struct ata_port *ap)
 }
 
 static struct ata_port_operations inic_port_ops = {
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.scr_read		= inic_scr_read,
-	.scr_write		= inic_scr_write,
+	.inherits		= &ata_sff_port_ops,
 
 	.bmdma_setup		= inic_bmdma_setup,
 	.bmdma_start		= inic_bmdma_start,
 	.bmdma_stop		= inic_bmdma_stop,
 	.bmdma_status		= inic_bmdma_status,
-
-	.irq_clear		= ata_noop_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.qc_prep	 	= ata_qc_prep,
 	.qc_issue		= inic_qc_issue,
-	.data_xfer		= ata_data_xfer,
 
 	.freeze			= inic_freeze,
 	.thaw			= inic_thaw,
@@ -549,8 +536,10 @@ static struct ata_port_operations inic_port_ops = {
 	.post_internal_cmd	= inic_post_internal_cmd,
 	.dev_config		= inic_dev_config,
 
-	.port_resume		= inic_port_resume,
+	.scr_read		= inic_scr_read,
+	.scr_write		= inic_scr_write,
 
+	.port_resume		= inic_port_resume,
 	.port_start		= inic_port_start,
 };
 
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 52d41ed..f341a82 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -526,23 +526,16 @@ static struct scsi_host_template mv6_sht = {
 	.dma_boundary		= MV_DMA_BOUNDARY,
 };
 
-static const struct ata_port_operations mv5_ops = {
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
+static struct ata_port_operations mv5_ops = {
+	.inherits		= &ata_sff_port_ops,
 
 	.qc_prep		= mv_qc_prep,
 	.qc_issue		= mv_qc_issue,
-	.data_xfer		= ata_data_xfer,
 
-	.irq_clear		= ata_noop_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.error_handler		= mv_error_handler,
 	.freeze			= mv_eh_freeze,
 	.thaw			= mv_eh_thaw,
+	.error_handler		= mv_error_handler,
+	.post_internal_cmd	= ATA_OP_NULL,
 
 	.scr_read		= mv5_scr_read,
 	.scr_write		= mv5_scr_write,
@@ -551,57 +544,18 @@ static const struct ata_port_operations mv5_ops = {
 	.port_stop		= mv_port_stop,
 };
 
-static const struct ata_port_operations mv6_ops = {
-	.dev_config             = mv6_dev_config,
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.qc_prep		= mv_qc_prep,
-	.qc_issue		= mv_qc_issue,
-	.data_xfer		= ata_data_xfer,
-
-	.irq_clear		= ata_noop_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.error_handler		= mv_error_handler,
-	.freeze			= mv_eh_freeze,
-	.thaw			= mv_eh_thaw,
+static struct ata_port_operations mv6_ops = {
+	.inherits		= &mv5_ops,
 	.qc_defer		= ata_std_qc_defer,
-
+	.dev_config             = mv6_dev_config,
 	.scr_read		= mv_scr_read,
 	.scr_write		= mv_scr_write,
-
-	.port_start		= mv_port_start,
-	.port_stop		= mv_port_stop,
 };
 
-static const struct ata_port_operations mv_iie_ops = {
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
+static struct ata_port_operations mv_iie_ops = {
+	.inherits		= &mv6_ops,
+	.dev_config		= ATA_OP_NULL,
 	.qc_prep		= mv_qc_prep_iie,
-	.qc_issue		= mv_qc_issue,
-	.data_xfer		= ata_data_xfer,
-
-	.irq_clear		= ata_noop_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.error_handler		= mv_error_handler,
-	.freeze			= mv_eh_freeze,
-	.thaw			= mv_eh_thaw,
-	.qc_defer		= ata_std_qc_defer,
-
-	.scr_read		= mv_scr_read,
-	.scr_write		= mv_scr_write,
-
-	.port_start		= mv_port_start,
-	.port_stop		= mv_port_stop,
 };
 
 static const struct ata_port_info mv_port_info[] = {
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 9e2b4ce..7b7ba0e 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -404,106 +404,41 @@ static struct scsi_host_template nv_swncq_sht = {
 	.slave_configure	= nv_swncq_slave_config,
 };
 
-static const struct ata_port_operations nv_generic_ops = {
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.exec_command		= ata_exec_command,
-	.check_status		= ata_check_status,
-	.dev_select		= ata_std_dev_select,
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.mode_filter		= ata_pci_default_filter,
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
+static struct ata_port_operations nv_generic_ops = {
+	.inherits		= &ata_bmdma_port_ops,
 	.error_handler		= nv_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.data_xfer		= ata_data_xfer,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
-	.port_start		= ata_sff_port_start,
 };
 
-static const struct ata_port_operations nv_nf2_ops = {
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.exec_command		= ata_exec_command,
-	.check_status		= ata_check_status,
-	.dev_select		= ata_std_dev_select,
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.mode_filter		= ata_pci_default_filter,
+static struct ata_port_operations nv_nf2_ops = {
+	.inherits		= &nv_generic_ops,
 	.freeze			= nv_nf2_freeze,
 	.thaw			= nv_nf2_thaw,
-	.error_handler		= nv_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.data_xfer		= ata_data_xfer,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-	.scr_read		= nv_scr_read,
-	.scr_write		= nv_scr_write,
-	.port_start		= ata_sff_port_start,
 };
 
-static const struct ata_port_operations nv_ck804_ops = {
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.exec_command		= ata_exec_command,
-	.check_status		= ata_check_status,
-	.dev_select		= ata_std_dev_select,
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.mode_filter		= ata_pci_default_filter,
+static struct ata_port_operations nv_ck804_ops = {
+	.inherits		= &nv_generic_ops,
 	.freeze			= nv_ck804_freeze,
 	.thaw			= nv_ck804_thaw,
-	.error_handler		= nv_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.data_xfer		= ata_data_xfer,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-	.scr_read		= nv_scr_read,
-	.scr_write		= nv_scr_write,
-	.port_start		= ata_sff_port_start,
 	.host_stop		= nv_ck804_host_stop,
 };
 
-static const struct ata_port_operations nv_adma_ops = {
-	.tf_load		= ata_tf_load,
-	.tf_read		= nv_adma_tf_read,
+static struct ata_port_operations nv_adma_ops = {
+	.inherits		= &nv_generic_ops,
+
 	.check_atapi_dma	= nv_adma_check_atapi_dma,
-	.exec_command		= ata_exec_command,
-	.check_status		= ata_check_status,
-	.dev_select		= ata_std_dev_select,
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
+	.tf_read		= nv_adma_tf_read,
 	.qc_defer		= ata_std_qc_defer,
 	.qc_prep		= nv_adma_qc_prep,
 	.qc_issue		= nv_adma_qc_issue,
-	.mode_filter		= ata_pci_default_filter,
+	.irq_clear		= nv_adma_irq_clear,
+
 	.freeze			= nv_adma_freeze,
 	.thaw			= nv_adma_thaw,
 	.error_handler		= nv_adma_error_handler,
 	.post_internal_cmd	= nv_adma_post_internal_cmd,
-	.data_xfer		= ata_data_xfer,
-	.irq_clear		= nv_adma_irq_clear,
-	.irq_on			= ata_irq_on,
-	.scr_read		= nv_scr_read,
-	.scr_write		= nv_scr_write,
+
 	.port_start		= nv_adma_port_start,
 	.port_stop		= nv_adma_port_stop,
 #ifdef CONFIG_PM
@@ -513,29 +448,17 @@ static const struct ata_port_operations nv_adma_ops = {
 	.host_stop		= nv_adma_host_stop,
 };
 
-static const struct ata_port_operations nv_swncq_ops = {
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.exec_command		= ata_exec_command,
-	.check_status		= ata_check_status,
-	.dev_select		= ata_std_dev_select,
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
+static struct ata_port_operations nv_swncq_ops = {
+	.inherits		= &nv_generic_ops,
+
 	.qc_defer		= ata_std_qc_defer,
 	.qc_prep		= nv_swncq_qc_prep,
 	.qc_issue		= nv_swncq_qc_issue,
-	.mode_filter		= ata_pci_default_filter,
+
 	.freeze			= nv_mcp55_freeze,
 	.thaw			= nv_mcp55_thaw,
 	.error_handler		= nv_swncq_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.data_xfer		= ata_data_xfer,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-	.scr_read		= nv_scr_read,
-	.scr_write		= nv_scr_write,
+
 #ifdef CONFIG_PM
 	.port_suspend		= nv_swncq_port_suspend,
 	.port_resume		= nv_swncq_port_resume,
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index a6d0196..e725f78 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -158,74 +158,40 @@ static struct scsi_host_template pdc_ata_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 };
 
-static const struct ata_port_operations pdc_sata_ops = {
+static const struct ata_port_operations pdc_common_ops = {
+	.inherits		= &ata_sff_port_ops,
+
 	.tf_load		= pdc_tf_load_mmio,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
 	.exec_command		= pdc_exec_command_mmio,
-	.dev_select		= ata_std_dev_select,
 	.check_atapi_dma	= pdc_check_atapi_dma,
-
 	.qc_prep		= pdc_qc_prep,
 	.qc_issue		= pdc_qc_issue_prot,
+	.irq_clear		= pdc_irq_clear,
+
 	.freeze			= pdc_freeze,
 	.thaw			= pdc_thaw,
-	.error_handler		= pdc_sata_error_handler,
 	.post_internal_cmd	= pdc_post_internal_cmd,
-	.cable_detect		= pdc_sata_cable_detect,
-	.data_xfer		= ata_data_xfer,
-	.irq_clear		= pdc_irq_clear,
-	.irq_on			= ata_irq_on,
+};
 
+static struct ata_port_operations pdc_sata_ops = {
+	.inherits		= &pdc_common_ops,
+	.cable_detect		= pdc_sata_cable_detect,
+	.error_handler		= pdc_sata_error_handler,
 	.scr_read		= pdc_sata_scr_read,
 	.scr_write		= pdc_sata_scr_write,
 	.port_start		= pdc_sata_port_start,
 };
 
 /* First-generation chips need a more restrictive ->check_atapi_dma op */
-static const struct ata_port_operations pdc_old_sata_ops = {
-	.tf_load		= pdc_tf_load_mmio,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= pdc_exec_command_mmio,
-	.dev_select		= ata_std_dev_select,
+static struct ata_port_operations pdc_old_sata_ops = {
+	.inherits		= &pdc_sata_ops,
 	.check_atapi_dma	= pdc_old_sata_check_atapi_dma,
-
-	.qc_prep		= pdc_qc_prep,
-	.qc_issue		= pdc_qc_issue_prot,
-	.freeze			= pdc_freeze,
-	.thaw			= pdc_thaw,
-	.error_handler		= pdc_sata_error_handler,
-	.post_internal_cmd	= pdc_post_internal_cmd,
-	.cable_detect		= pdc_sata_cable_detect,
-	.data_xfer		= ata_data_xfer,
-	.irq_clear		= pdc_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.scr_read		= pdc_sata_scr_read,
-	.scr_write		= pdc_sata_scr_write,
-	.port_start		= pdc_sata_port_start,
 };
 
-static const struct ata_port_operations pdc_pata_ops = {
-	.tf_load		= pdc_tf_load_mmio,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= pdc_exec_command_mmio,
-	.dev_select		= ata_std_dev_select,
-	.check_atapi_dma	= pdc_check_atapi_dma,
-
-	.qc_prep		= pdc_qc_prep,
-	.qc_issue		= pdc_qc_issue_prot,
-	.freeze			= pdc_freeze,
-	.thaw			= pdc_thaw,
-	.error_handler		= pdc_pata_error_handler,
-	.post_internal_cmd	= pdc_post_internal_cmd,
+static struct ata_port_operations pdc_pata_ops = {
+	.inherits		= &pdc_common_ops,
 	.cable_detect		= pdc_pata_cable_detect,
-	.data_xfer		= ata_data_xfer,
-	.irq_clear		= pdc_irq_clear,
-	.irq_on			= ata_irq_on,
-
+	.error_handler		= pdc_pata_error_handler,
 	.port_start		= pdc_common_port_start,
 };
 
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 2566d09..107ef09 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -131,27 +131,25 @@ static struct scsi_host_template qs_ata_sht = {
 	.dma_boundary		= QS_DMA_BOUNDARY,
 };
 
-static const struct ata_port_operations qs_ata_ops = {
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
+static struct ata_port_operations qs_ata_ops = {
+	.inherits		= &ata_sff_port_ops,
+
 	.check_atapi_dma	= qs_check_atapi_dma,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
+	.bmdma_stop		= qs_bmdma_stop,
+	.bmdma_status		= qs_bmdma_status,
 	.qc_prep		= qs_qc_prep,
 	.qc_issue		= qs_qc_issue,
-	.data_xfer		= ata_data_xfer,
+
 	.freeze			= qs_freeze,
 	.thaw			= qs_thaw,
 	.error_handler		= qs_error_handler,
-	.irq_clear		= ata_noop_irq_clear,
-	.irq_on			= ata_irq_on,
+	.post_internal_cmd	= ATA_OP_NULL,
+
 	.scr_read		= qs_scr_read,
 	.scr_write		= qs_scr_write,
+
 	.port_start		= qs_port_start,
 	.host_stop		= qs_host_stop,
-	.bmdma_stop		= qs_bmdma_stop,
-	.bmdma_status		= qs_bmdma_status,
 };
 
 static const struct ata_port_info qs_port_info[] = {
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 738c1a8..eac7ca7 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -170,31 +170,14 @@ static struct scsi_host_template sil_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
 };
 
-static const struct ata_port_operations sil_ops = {
+static struct ata_port_operations sil_ops = {
+	.inherits		= &ata_bmdma_port_ops,
 	.dev_config		= sil_dev_config,
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
 	.set_mode		= sil_set_mode,
-	.mode_filter		= ata_pci_default_filter,
-	.bmdma_setup            = ata_bmdma_setup,
-	.bmdma_start            = ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
 	.freeze			= sil_freeze,
 	.thaw			= sil_thaw,
-	.error_handler		= ata_bmdma_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
 	.scr_read		= sil_scr_read,
 	.scr_write		= sil_scr_write,
-	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_info sil_port_info[] = {
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 7fa6395..363fb90 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -390,34 +390,28 @@ static struct scsi_host_template sil24_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 };
 
-static const struct ata_port_operations sil24_ops = {
-	.dev_config		= sil24_dev_config,
+static struct ata_port_operations sil24_ops = {
+	.inherits		= &sata_pmp_port_ops,
 
 	.check_status		= sil24_check_status,
 	.check_altstatus	= sil24_check_status,
-	.dev_select		= ata_noop_dev_select,
-
 	.tf_read		= sil24_tf_read,
-
 	.qc_defer		= sil24_qc_defer,
 	.qc_prep		= sil24_qc_prep,
 	.qc_issue		= sil24_qc_issue,
 
-	.irq_clear		= ata_noop_irq_clear,
+	.freeze			= sil24_freeze,
+	.thaw			= sil24_thaw,
+	.error_handler		= sil24_error_handler,
+	.post_internal_cmd	= sil24_post_internal_cmd,
+	.dev_config		= sil24_dev_config,
 
 	.scr_read		= sil24_scr_read,
 	.scr_write		= sil24_scr_write,
-
 	.pmp_attach		= sil24_pmp_attach,
 	.pmp_detach		= sil24_pmp_detach,
 
-	.freeze			= sil24_freeze,
-	.thaw			= sil24_thaw,
-	.error_handler		= sil24_error_handler,
-	.post_internal_cmd	= sil24_post_internal_cmd,
-
 	.port_start		= sil24_port_start,
-
 #ifdef CONFIG_PM
 	.port_resume		= sil24_port_resume,
 #endif
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index 4becb7f..9089c7a 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -89,29 +89,10 @@ static struct scsi_host_template sis_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
 };
 
-static const struct ata_port_operations sis_ops = {
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-	.bmdma_setup            = ata_bmdma_setup,
-	.bmdma_start            = ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-	.mode_filter		= ata_pci_default_filter,
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= ata_bmdma_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
+static struct ata_port_operations sis_ops = {
+	.inherits		= &ata_bmdma_port_ops,
 	.scr_read		= sis_scr_read,
 	.scr_write		= sis_scr_write,
-	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_info sis_port_info = {
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index b87343b..540be24 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -334,30 +334,16 @@ static struct scsi_host_template k2_sata_sht = {
 };
 
 
-static const struct ata_port_operations k2_sata_ops = {
+static struct ata_port_operations k2_sata_ops = {
+	.inherits		= &ata_bmdma_port_ops,
 	.tf_load		= k2_sata_tf_load,
 	.tf_read		= k2_sata_tf_read,
 	.check_status		= k2_stat_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
 	.check_atapi_dma	= k2_sata_check_atapi_dma,
 	.bmdma_setup		= k2_bmdma_setup_mmio,
 	.bmdma_start		= k2_bmdma_start_mmio,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-	.mode_filter		= ata_pci_default_filter,
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= ata_bmdma_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
 	.scr_read		= k2_sata_scr_read,
 	.scr_write		= k2_sata_scr_write,
-	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_info k2_port_info[] = {
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 1802f92..8138cda 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -241,7 +241,8 @@ static struct scsi_host_template pdc_sata_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 };
 
-static const struct ata_port_operations pdc_20621_ops = {
+/* TODO: inherit from base port_ops after converting to new EH */
+static struct ata_port_operations pdc_20621_ops = {
 	.tf_load		= pdc_tf_load_mmio,
 	.tf_read		= ata_tf_read,
 	.check_status		= ata_check_status,
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index 764d706..6ecd13f 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -79,34 +79,10 @@ static struct scsi_host_template uli_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
 };
 
-static const struct ata_port_operations uli_ops = {
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.bmdma_setup            = ata_bmdma_setup,
-	.bmdma_start            = ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	.mode_filter		= ata_pci_default_filter,
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= ata_bmdma_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
+static struct ata_port_operations uli_ops = {
+	.inherits		= &ata_bmdma_port_ops,
 	.scr_read		= uli_scr_read,
 	.scr_write		= uli_scr_write,
-
-	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_info uli_port_info = {
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 9be877c..6326bcf 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -103,97 +103,23 @@ static struct scsi_host_template svia_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
 };
 
-static const struct ata_port_operations vt6420_sata_ops = {
-	.mode_filter		= ata_pci_default_filter,
-
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.bmdma_setup            = ata_bmdma_setup,
-	.bmdma_start            = ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
+static struct ata_port_operations vt6420_sata_ops = {
+	.inherits		= &ata_bmdma_port_ops,
 	.freeze			= svia_noop_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= vt6420_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
 };
 
-static const struct ata_port_operations vt6421_pata_ops = {
+static struct ata_port_operations vt6421_pata_ops = {
+	.inherits		= &ata_bmdma_port_ops,
+	.cable_detect		= vt6421_pata_cable_detect,
 	.set_piomode		= vt6421_set_pio_mode,
 	.set_dmamode		= vt6421_set_dma_mode,
-	.mode_filter		= ata_pci_default_filter,
-
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.bmdma_setup            = ata_bmdma_setup,
-	.bmdma_start            = ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= ata_bmdma_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.cable_detect		= vt6421_pata_cable_detect,
-
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
 };
 
-static const struct ata_port_operations vt6421_sata_ops = {
-	.mode_filter		= ata_pci_default_filter,
-
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.bmdma_setup            = ata_bmdma_setup,
-	.bmdma_start            = ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.error_handler		= ata_bmdma_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
+static struct ata_port_operations vt6421_sata_ops = {
+	.inherits		= &ata_bmdma_port_ops,
 	.scr_read		= svia_scr_read,
 	.scr_write		= svia_scr_write,
-
-	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_info vt6420_port_info = {
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index fd6855f..8045a72 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -304,29 +304,14 @@ static struct scsi_host_template vsc_sata_sht = {
 };
 
 
-static const struct ata_port_operations vsc_sata_ops = {
+static struct ata_port_operations vsc_sata_ops = {
+	.inherits		= &ata_bmdma_port_ops,
 	.tf_load		= vsc_sata_tf_load,
 	.tf_read		= vsc_sata_tf_read,
-	.exec_command		= ata_exec_command,
-	.check_status		= ata_check_status,
-	.dev_select		= ata_std_dev_select,
-	.bmdma_setup            = ata_bmdma_setup,
-	.bmdma_start            = ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
-	.mode_filter		= ata_pci_default_filter,
 	.freeze			= vsc_freeze,
 	.thaw			= vsc_thaw,
-	.error_handler		= ata_bmdma_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
 	.scr_read		= vsc_sata_scr_read,
 	.scr_write		= vsc_sata_scr_write,
-	.port_start		= ata_sff_port_start,
 };
 
 static void __devinit vsc_sata_setup_port(struct ata_ioports *port,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 45c40a2..83eaea1 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -432,7 +432,7 @@ struct ata_host {
 	void __iomem * const	*iomap;
 	unsigned int		n_ports;
 	void			*private_data;
-	const struct ata_port_operations *ops;
+	struct ata_port_operations *ops;
 	unsigned long		flags;
 #ifdef CONFIG_ATA_ACPI
 	acpi_handle		acpi_handle;
@@ -600,7 +600,7 @@ struct ata_link {
 
 struct ata_port {
 	struct Scsi_Host	*scsi_host; /* our co-allocated scsi host */
-	const struct ata_port_operations *ops;
+	struct ata_port_operations *ops;
 	spinlock_t		*lock;
 	unsigned long		flags;	/* ATA_FLAG_xxx */
 	unsigned int		pflags; /* ATA_PFLAG_xxx */
@@ -662,6 +662,13 @@ struct ata_port {
 	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
 };
 
+/* The following initializer overrides a method to NULL whether one of
+ * its parent has the method defined or not.  This is equivalent to
+ * ERR_PTR(-ENOENT).  Unfortunately, ERR_PTR doesn't render a constant
+ * expression and thus can't be used as an initializer.
+ */
+#define ATA_OP_NULL		(void *)(unsigned long)(-ENOENT)
+
 struct ata_port_operations {
 	/*
 	 * Command execution
@@ -731,6 +738,12 @@ struct ata_port_operations {
 	void (*phy_reset)(struct ata_port *ap);
 	void (*eng_timeout)(struct ata_port *ap);
 	irq_handler_t irq_handler;
+
+	/*
+	 * ->inherits must be the last field and all the preceding
+	 * fields must be pointers.
+	 */
+	const struct ata_port_operations	*inherits;
 };
 
 struct ata_port_info {
@@ -740,7 +753,7 @@ struct ata_port_info {
 	unsigned long		pio_mask;
 	unsigned long		mwdma_mask;
 	unsigned long		udma_mask;
-	const struct ata_port_operations *port_ops;
+	struct ata_port_operations *port_ops;
 	irq_handler_t		irq_handler;
 	void 			*private_data;
 };
@@ -763,7 +776,7 @@ extern const unsigned long sata_deb_timing_normal[];
 extern const unsigned long sata_deb_timing_hotplug[];
 extern const unsigned long sata_deb_timing_long[];
 
-extern const struct ata_port_operations ata_dummy_port_ops;
+extern struct ata_port_operations ata_dummy_port_ops;
 extern const struct ata_port_info ata_dummy_port_info;
 
 static inline const unsigned long *
@@ -810,7 +823,7 @@ extern int ata_host_activate(struct ata_host *host, int irq,
 			     struct scsi_host_template *sht);
 extern void ata_host_detach(struct ata_host *host);
 extern void ata_host_init(struct ata_host *, struct device *,
-			  unsigned long, const struct ata_port_operations *);
+			  unsigned long, struct ata_port_operations *);
 extern int ata_scsi_detect(struct scsi_host_template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
-- 
1.5.2.4

