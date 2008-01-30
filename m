From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/9] libata: implement and use SHT initializers and ops inheritance
Date: Wed, 30 Jan 2008 18:28:59 +0900
Message-ID: <12016853432907-git-send-email-htejun@gmail.com>
References: <12016853433196-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:37130 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064AbYA3J3V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jan 2008 04:29:21 -0500
Received: by wa-out-1112.google.com with SMTP id v27so277519wah.23
        for <linux-ide@vger.kernel.org>; Wed, 30 Jan 2008 01:29:20 -0800 (PST)
In-Reply-To: <12016853433196-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@dyn-67.arm.linux.org.uk, alessandro.zummo@to
Cc: Tejun Heo <htejun@gmail.com>

libata lets low level drivers build scsi_host_template and
ata_port_operations tables and register them with upper layers.  This
allows low level drivers high level of flexibility but also burdens
them with lots of boilerplate entries in thoes data structures.

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

To rectify the problem, this patch implements SHT initializers and
ata_port_operations inheritance.  SHT initializers can be used to
initialize all the boilerplate entries in a sht.  Three variants of
them exist - BASE, BMDMA and NCQ - for different types of drivers.
Note that entries can be overriden by putting individual initializers
after the helper macro.

Ops handling is a bit more involved to allow LLDs to easily re-use
their own ops tables overriding only specific methods.  This is
basically poor man's class inheritance.  An ops table has ->inherits
field which can be set to any ops table as long as it doesn't create a
loop.  When the host is started, the inheritance chain is followed and
any operation which isn't specified is taken from the nearest ancestor
which has it specified.  This operation is called finalization and
done only once per an ops table and the LLD doesn't have to do
anything special about it other than making the ops table non-const
such that libata can update it.

libata provides four base ops tables lower drivers can inherit from -
base, sata, pmp, sff and bmdma.  To avoid overriding these ops
accidentaly, these ops are declared const and LLDs should always
inherit these instead of using them directly.

After finalization, all the sht and ops table are identical before and
after the patch except for setting .irq_handler to ata_interrupt in
drivers which didn't use to.  The .irq_handler doesn't have any actual
effect and the field will soon be removed by later patch.

* sata_sx4 is still using old style EH and currently doesn't take
  advantage of ops inheritance.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c              |  105 ++-------------
 drivers/ata/ata_generic.c       |   47 +------
 drivers/ata/ata_piix.c          |  165 ++---------------------
 drivers/ata/libata-core.c       |  114 ++++++++++++++++-
 drivers/ata/pata_acpi.c         |   52 +-------
 drivers/ata/pata_ali.c          |  138 ++------------------
 drivers/ata/pata_amd.c          |  209 ++++--------------------------
 drivers/ata/pata_artop.c        |   77 +----------
 drivers/ata/pata_at32.c         |   39 +-----
 drivers/ata/pata_atiixp.c       |   47 +------
 drivers/ata/pata_bf54x.c        |   18 +--
 drivers/ata/pata_cmd640.c       |   49 +------
 drivers/ata/pata_cmd64x.c       |  112 ++--------------
 drivers/ata/pata_cs5520.c       |   44 +------
 drivers/ata/pata_cs5530.c       |   48 +------
 drivers/ata/pata_cs5535.c       |   47 +------
 drivers/ata/pata_cs5536.c       |   47 +------
 drivers/ata/pata_cypress.c      |   47 +------
 drivers/ata/pata_efar.c         |   46 +------
 drivers/ata/pata_hpt366.c       |   48 +------
 drivers/ata/pata_hpt37x.c       |  138 ++------------------
 drivers/ata/pata_hpt3x2n.c      |   48 +------
 drivers/ata/pata_hpt3x3.c       |   49 +-------
 drivers/ata/pata_icside.c       |   46 ++-----
 drivers/ata/pata_isapnp.c       |   37 +-----
 drivers/ata/pata_it8213.c       |   47 +------
 drivers/ata/pata_it821x.c       |   73 ++---------
 drivers/ata/pata_ixp4xx_cf.c    |   39 +-----
 drivers/ata/pata_jmicron.c      |   48 +-------
 drivers/ata/pata_legacy.c       |  276 +++------------------------------------
 drivers/ata/pata_marvell.c      |   50 +-------
 drivers/ata/pata_mpc52xx.c      |   34 +----
 drivers/ata/pata_mpiix.c        |   39 +-----
 drivers/ata/pata_netcell.c      |   49 +-------
 drivers/ata/pata_ninja32.c      |   46 +------
 drivers/ata/pata_ns87410.c      |   41 +-----
 drivers/ata/pata_ns87415.c      |   84 ++----------
 drivers/ata/pata_oldpiix.c      |   47 +------
 drivers/ata/pata_opti.c         |   45 +------
 drivers/ata/pata_optidma.c      |   79 +-----------
 drivers/ata/pata_pcmcia.c       |   64 +--------
 drivers/ata/pata_pdc2027x.c     |   72 +----------
 drivers/ata/pata_pdc202xx_old.c |   91 +++-----------
 drivers/ata/pata_platform.c     |   40 +-----
 drivers/ata/pata_qdi.c          |   63 +--------
 drivers/ata/pata_radisys.c      |   48 +------
 drivers/ata/pata_rz1000.c       |   47 +------
 drivers/ata/pata_sc1200.c       |   50 +------
 drivers/ata/pata_scc.c          |   21 +---
 drivers/ata/pata_serverworks.c  |   79 +-----------
 drivers/ata/pata_sil680.c       |   46 +------
 drivers/ata/pata_sis.c          |  193 +++-------------------------
 drivers/ata/pata_sl82c105.c     |   48 +------
 drivers/ata/pata_triflex.c      |   48 +------
 drivers/ata/pata_via.c          |   77 +----------
 drivers/ata/pata_winbond.c      |   41 +-----
 drivers/ata/pdc_adma.c          |   33 ++---
 drivers/ata/sata_fsl.c          |   19 +---
 drivers/ata/sata_inic162x.c     |   34 +----
 drivers/ata/sata_mv.c           |  100 ++-------------
 drivers/ata/sata_nv.c           |  155 +++-------------------
 drivers/ata/sata_promise.c      |   78 +++---------
 drivers/ata/sata_qstor.c        |   34 ++----
 drivers/ata/sata_sil.c          |   37 +-----
 drivers/ata/sata_sil24.c        |   34 +----
 drivers/ata/sata_sis.c          |   39 +-----
 drivers/ata/sata_svw.c          |   34 +-----
 drivers/ata/sata_sx4.c          |   17 +--
 drivers/ata/sata_uli.c          |   44 +------
 drivers/ata/sata_via.c          |  104 +--------------
 drivers/ata/sata_vsc.c          |   35 +-----
 include/linux/libata.h          |   80 +++++++++++-
 72 files changed, 651 insertions(+), 4068 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 08301ca..2361910 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -58,7 +58,6 @@ enum {
 	AHCI_MAX_PORTS		= 32,
 	AHCI_MAX_SG		= 168, /* hardware max is 64K */
 	AHCI_DMA_BOUNDARY	= 0xffffffff,
-	AHCI_USE_CLUSTERING	= 1,
 	AHCI_MAX_CMDS		= 32,
 	AHCI_CMD_SZ		= 32,
 	AHCI_CMD_SLOT_SZ	= AHCI_MAX_CMDS * AHCI_CMD_SZ,
@@ -267,131 +266,51 @@ static struct class_device_attribute *ahci_shost_attrs[] = {
 };
 
 static struct scsi_host_template ahci_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.change_queue_depth	= ata_scsi_change_queue_depth,
+	ATA_NCQ_SHT(DRV_NAME),
 	.can_queue		= AHCI_MAX_CMDS - 1,
-	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= AHCI_MAX_SG,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= AHCI_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
 	.dma_boundary		= AHCI_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
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
index db4c3cb..0b5b515 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -95,54 +95,13 @@ static int generic_set_mode(struct ata_link *link, struct ata_device **unused)
 }
 
 static struct scsi_host_template generic_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index 129d682..7cb48af 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -283,172 +283,37 @@ static struct pci_driver piix_pci_driver = {
 };
 
 static struct scsi_host_template piix_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
-
-	.port_start		= ata_sff_port_start,
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
-	.cable_detect		= ich_pata_cable_detect,
-
-	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
+static struct ata_port_operations piix_vmw_ops = {
+	.inherits		= &piix_pata_ops,
+	.bmdma_status		= piix_vmw_bmdma_status,
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
+static struct ata_port_operations ich_pata_ops = {
+	.inherits		= &piix_pata_ops,
+	.cable_detect		= ich_pata_cable_detect,
+	.set_dmamode		= ich_set_dmamode,
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
+static struct ata_port_operations piix_sata_ops = {
+	.inherits		= &ata_bmdma_port_ops,
 };
 
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
index e61c5db..0a55405 100644
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
@@ -6884,6 +6934,56 @@ static void ata_host_stop(struct device *gendev, void *res)
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
@@ -6908,9 +7008,13 @@ int ata_host_start(struct ata_host *host)
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
 
@@ -6972,7 +7076,7 @@ int ata_host_start(struct ata_host *host)
  */
 /* KILLME - the only user left is ipr */
 void ata_host_init(struct ata_host *host, struct device *dev,
-		   unsigned long flags, const struct ata_port_operations *ops)
+		   unsigned long flags, struct ata_port_operations *ops)
 {
 	spin_lock_init(&host->lock);
 	host->dev = dev;
@@ -7373,7 +7477,6 @@ int ata_pci_device_resume(struct pci_dev *pdev)
 
 #endif /* CONFIG_PCI */
 
-
 static int __init ata_init(void)
 {
 	ata_probe_timeout *= HZ;
@@ -7484,7 +7587,7 @@ static unsigned int ata_dummy_qc_issue(struct ata_queued_cmd *qc)
 	return AC_ERR_SYSTEM;
 }
 
-const struct ata_port_operations ata_dummy_port_ops = {
+struct ata_port_operations ata_dummy_port_ops = {
 	.check_status		= ata_dummy_check_status,
 	.check_altstatus	= ata_dummy_check_status,
 	.dev_select		= ata_noop_dev_select,
@@ -7512,6 +7615,11 @@ const struct ata_port_info ata_dummy_port_info = {
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
index 244098a..2810488 100644
--- a/drivers/ata/pata_acpi.c
+++ b/drivers/ata/pata_acpi.c
@@ -232,57 +232,17 @@ static int pacpi_port_start(struct ata_port *ap)
 }
 
 static struct scsi_host_template pacpi_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	/* Use standard CHS mapping rules */
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index 8a9044c..ad9dce9 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -301,21 +301,7 @@ static int ali_check_atapi_dma(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template ali_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 /*
@@ -323,29 +309,15 @@ static struct scsi_host_template ali_sht = {
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
@@ -353,113 +325,29 @@ static struct ata_port_operations ali_early_port_ops = {
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
index 567fe6b..0f317e0 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -354,223 +354,60 @@ static void nv_host_stop(struct ata_host *host)
 }
 
 static struct scsi_host_template amd_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
+};
+
+static const struct ata_port_operations amd_base_port_ops = {
+	.inherits	= &ata_bmdma_port_ops,
+	.error_handler	= amd_error_handler,
 };
 
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
-	.mode_filter	= ata_pci_default_filter,
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
-	.mode_filter	= ata_pci_default_filter,
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
index a238c7b..0101e5a 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -314,86 +314,23 @@ static void artop6260_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template artop_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index 86a8ee9..d495c79 100644
--- a/drivers/ata/pata_at32.c
+++ b/drivers/ata/pata_at32.c
@@ -167,46 +167,13 @@ static void pata_at32_set_piomode(struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template at32_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_PIO_SHT(DRV_NAME),
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
index 9623f52..5bc2040 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -221,54 +221,19 @@ static void atiixp_bmdma_stop(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template atiixp_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
 	.bmdma_start 	= atiixp_bmdma_start,
 	.bmdma_stop	= atiixp_bmdma_stop,
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
+	.cable_detect	= atiixp_cable_detect,
+	.set_piomode	= atiixp_set_piomode,
+	.set_dmamode	= atiixp_set_dmamode,
+	.error_handler	= atiixp_error_handler,
 };
 
 static int atiixp_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index 0a6fa94..16f8fa5 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -1358,24 +1358,14 @@ static int bfin_port_start(struct ata_port *ap)
 }
 
 static struct scsi_host_template bfin_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
+	ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize		= SG_NONE,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
 };
 
 static const struct ata_port_operations bfin_pata_ops = {
+	.inherits		= &ata_sff_port_ops,
+
 	.set_piomode		= bfin_set_piomode,
 	.set_dmamode		= bfin_set_dmamode,
 
@@ -1393,14 +1383,12 @@ static const struct ata_port_operations bfin_pata_ops = {
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
index 0ef1d1d..061c891 100644
--- a/drivers/ata/pata_cmd640.c
+++ b/drivers/ata/pata_cmd640.c
@@ -166,53 +166,16 @@ static int cmd640_port_start(struct ata_port *ap)
 }
 
 static struct scsi_host_template cmd640_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index e8c1262..1ac8ecf 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -266,120 +266,30 @@ static void cmd646r1_bmdma_stop(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template cmd64x_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index 5614e76..69a1077 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -140,52 +140,16 @@ static void cs5520_set_piomode(struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template cs5520_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
+	ATA_BMDMA_SHT(DRV_NAME),
 	.sg_tablesize		= LIBATA_DUMB_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
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
index f876aed..e4a16a5 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -161,55 +161,19 @@ static unsigned int cs5530_qc_issue_prot(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template cs5530_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_DUMB_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
+	.sg_tablesize	= LIBATA_DUMB_MAX_PRD,
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
index 0132453..f910a8a 100644
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -158,55 +158,14 @@ static void cs5535_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template cs5535_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index c59c806..69d63aa 100644
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -221,55 +221,14 @@ static void cs5536_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template cs5536_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index fc5f9c4..c459553 100644
--- a/drivers/ata/pata_cypress.c
+++ b/drivers/ata/pata_cypress.c
@@ -110,55 +110,14 @@ static void cy82c693_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template cy82c693_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index 043dcd3..a6129bd 100644
--- a/drivers/ata/pata_efar.c
+++ b/drivers/ata/pata_efar.c
@@ -233,53 +233,15 @@ static void efar_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template efar_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index 6f63b73..9fa47d4 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -290,21 +290,7 @@ static void hpt366_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template hpt36x_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 /*
@@ -312,37 +298,11 @@ static struct scsi_host_template hpt36x_sht = {
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
index 7a69f36..a9d10c6 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -619,21 +619,7 @@ static void hpt37x_bmdma_stop(struct ata_queued_cmd *qc)
 
 
 static struct scsi_host_template hpt37x_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 /*
@@ -641,36 +627,15 @@ static struct scsi_host_template hpt37x_sht = {
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
@@ -678,36 +643,8 @@ static struct ata_port_operations hpt370_port_ops = {
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
@@ -716,36 +653,13 @@ static struct ata_port_operations hpt370a_port_ops = {
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
@@ -754,36 +668,8 @@ static struct ata_port_operations hpt372_port_ops = {
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
index 3a517cb..b77b127 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -339,21 +339,7 @@ static unsigned int hpt3x2n_qc_issue_prot(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template hpt3x2n_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 /*
@@ -361,37 +347,15 @@ static struct scsi_host_template hpt3x2n_sht = {
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
index c09f95a..8857d02 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -102,58 +102,17 @@ static int hpt3x3_atapi_dma(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template hpt3x3_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index 121fe52..f0ec997 100644
--- a/drivers/ata/pata_icside.c
+++ b/drivers/ata/pata_icside.c
@@ -311,21 +311,9 @@ static int pata_icside_port_start(struct ata_port *ap)
 }
 
 static struct scsi_host_template pata_icside_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
+	ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize		= PATA_ICSIDE_MAX_SG,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
 	.dma_boundary		= ~0, /* no dma boundaries */
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
 };
 
 static void pata_icside_postreset(struct ata_link *link, unsigned int *classes)
@@ -357,37 +345,21 @@ static void pata_icside_error_handler(struct ata_port *ap)
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
 
-	.irq_clear		= ata_noop_irq_clear,
-	.irq_on			= ata_irq_on,
-
 	.port_start		= pata_icside_port_start,
-
-	.bmdma_stop		= pata_icside_bmdma_stop,
-	.bmdma_status		= pata_icside_bmdma_status,
 };
 
 static void __devinit
diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
index ef561de..085913e 100644
--- a/drivers/ata/pata_isapnp.c
+++ b/drivers/ata/pata_isapnp.c
@@ -20,45 +20,12 @@
 #define DRV_VERSION "0.2.2"
 
 static struct scsi_host_template isapnp_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_PIO_SHT(DRV_NAME),
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
index 60c30dc..50977b7 100644
--- a/drivers/ata/pata_it8213.c
+++ b/drivers/ata/pata_it8213.c
@@ -243,53 +243,16 @@ static void it8213_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template it8213_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index 3181e2c..f7ac52e 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -632,89 +632,34 @@ static int it821x_port_start(struct ata_port *ap)
 }
 
 static struct scsi_host_template it821x_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index 6eb8cc9..d02629a 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -88,47 +88,14 @@ static unsigned int ixp4xx_mmio_data_xfer(struct ata_device *dev,
 }
 
 static struct scsi_host_template ixp4xx_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_PIO_SHT(DRV_NAME),
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
index 4d25c45..dbfb368 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -121,54 +121,12 @@ static void jmicron_error_handler(struct ata_port *ap)
 /* No PIO or DMA methods needed for this device */
 
 static struct scsi_host_template jmicron_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	/* Use standard CHS mapping rules */
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index 7b2140e..fadb301 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -208,21 +208,12 @@ static int legacy_set_mode(struct ata_link *link, struct ata_device **unused)
 }
 
 static struct scsi_host_template legacy_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_PIO_SHT(DRV_NAME),
+};
+
+static const struct ata_port_operations legacy_base_port_ops = {
+	.inherits	= &ata_sff_port_ops,
+	.cable_detect	= ata_cable_40wire,
 };
 
 /*
@@ -234,55 +225,14 @@ static struct scsi_host_template legacy_sht = {
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
@@ -373,30 +323,9 @@ static unsigned int pdc_data_xfer_vlb(struct ata_device *dev,
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
@@ -427,30 +356,8 @@ static void ht6560a_set_piomode(struct ata_port *ap, struct ata_device *adev)
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
@@ -492,30 +399,8 @@ static void ht6560b_set_piomode(struct ata_port *ap, struct ata_device *adev)
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
@@ -613,30 +498,8 @@ static void opti82c611a_set_piomode(struct ata_port *ap,
 
 
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
@@ -745,30 +608,9 @@ static unsigned int opti82c46x_qc_issue_prot(struct ata_queued_cmd *qc)
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
@@ -930,84 +772,22 @@ static int qdi_port(struct platform_device *dev,
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
@@ -1076,29 +856,9 @@ static int winbond_port(struct platform_device *dev,
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
index 113be4f..bbc9985 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -92,55 +92,13 @@ static void marvell_error_handler(struct ata_port *ap)
 /* No PIO or DMA methods needed for this device */
 
 static struct scsi_host_template marvell_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	/* Use standard CHS mapping rules */
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index 9383efb..6495c31 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -265,40 +265,16 @@ mpc52xx_ata_error_handler(struct ata_port *ap)
 
 
 static struct scsi_host_template mpc52xx_ata_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_PIO_SHT(DRV_NAME),
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
index ced6372..dab54f8 100644
--- a/drivers/ata/pata_mpiix.c
+++ b/drivers/ata/pata_mpiix.c
@@ -151,46 +151,15 @@ static unsigned int mpiix_qc_issue_prot(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template mpiix_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_PIO_SHT(DRV_NAME),
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
index 9fd1a84..65389d1 100644
--- a/drivers/ata/pata_netcell.c
+++ b/drivers/ata/pata_netcell.c
@@ -21,55 +21,12 @@
 /* No PIO or DMA methods needed for this device */
 
 static struct scsi_host_template netcell_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	/* Use standard CHS mapping rules */
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index 1c1b835..c37b951 100644
--- a/drivers/ata/pata_ninja32.c
+++ b/drivers/ata/pata_ninja32.c
@@ -78,54 +78,14 @@ static void ninja32_dev_select(struct ata_port *ap, unsigned int device)
 }
 
 static struct scsi_host_template ninja32_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index d182bdf..5b1982f 100644
--- a/drivers/ata/pata_ns87410.c
+++ b/drivers/ata/pata_ns87410.c
@@ -144,48 +144,15 @@ static unsigned int ns87410_qc_issue_prot(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template ns87410_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_PIO_SHT(DRV_NAME),
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
index 93eb958..38d86a2 100644
--- a/drivers/ata/pata_ns87415.c
+++ b/drivers/ata/pata_ns87415.c
@@ -297,90 +297,32 @@ static u8 ns87560_bmdma_status(struct ata_port *ap)
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
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 
diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
index 44da09a..f6062b3 100644
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -220,53 +220,16 @@ static unsigned int oldpiix_qc_issue_prot(struct ata_queued_cmd *qc)
 
 
 static struct scsi_host_template oldpiix_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index ebb9dc1..3787d39 100644
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -165,53 +165,14 @@ static void opti_set_piomode(struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template opti_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations opti_port_ops = {
+	.inherits	= &ata_bmdma_port_ops,
+	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= opti_set_piomode,
-	.mode_filter	= ata_pci_default_filter,
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
 
 static int opti_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index 3f9d035..eb4b081 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -350,91 +350,22 @@ static int optidma_set_mode(struct ata_link *link, struct ata_device **r_failed)
 }
 
 static struct scsi_host_template optidma_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index 9881a9e..57efbf0 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -128,71 +128,21 @@ static unsigned int ata_data_xfer_8bit(struct ata_device *dev,
 
 
 static struct scsi_host_template pcmcia_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_PIO_SHT(DRV_NAME),
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
index 028af5d..baa9fa7 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -129,84 +129,22 @@ static struct pci_driver pdc2027x_pci_driver = {
 };
 
 static struct scsi_host_template pdc2027x_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index 3ed8667..4daac20 100644
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -262,87 +262,28 @@ static int pdc2026x_check_atapi_dma(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template pdc202xx_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index d2edcbf..0f86ca3 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -47,45 +47,15 @@ static int pata_platform_set_mode(struct ata_link *link, struct ata_device **unu
 }
 
 static struct scsi_host_template pata_platform_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_PIO_SHT(DRV_NAME),
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
index 60238d5..d16b343 100644
--- a/drivers/ata/pata_qdi.c
+++ b/drivers/ata/pata_qdi.c
@@ -154,73 +154,20 @@ static unsigned int qdi_data_xfer(struct ata_device *dev, unsigned char *buf,
 }
 
 static struct scsi_host_template qdi_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_PIO_SHT(DRV_NAME),
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
index 8109b08..94e60b3 100644
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -185,53 +185,15 @@ static unsigned int radisys_qc_issue_prot(struct ata_queued_cmd *qc)
 
 
 static struct scsi_host_template radisys_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
 
 
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index d922698..f9d40be 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -53,54 +53,13 @@ static int rz1000_set_mode(struct ata_link *link, struct ata_device **unused)
 
 
 static struct scsi_host_template rz1000_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations rz1000_port_ops = {
-	.set_mode	= rz1000_set_mode,
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
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-
-	.data_xfer	= ata_data_xfer,
-
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ata_bmdma_error_handler,
-	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.inherits	= &ata_bmdma_port_ops,
 	.cable_detect	= ata_cable_40wire,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-	.irq_on		= ata_irq_on,
-
-	.port_start	= ata_sff_port_start,
+	.set_mode	= rz1000_set_mode,
 };
 
 static int rz1000_fifo_disable(struct pci_dev *pdev)
diff --git a/drivers/ata/pata_sc1200.c b/drivers/ata/pata_sc1200.c
index 725a858..362b7f8 100644
--- a/drivers/ata/pata_sc1200.c
+++ b/drivers/ata/pata_sc1200.c
@@ -179,55 +179,17 @@ static unsigned int sc1200_qc_issue_prot(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template sc1200_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_DUMB_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
+	.sg_tablesize	= LIBATA_DUMB_MAX_PRD,
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
index 55055b2..033d1f3 100644
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -968,24 +968,12 @@ static void scc_port_stop (struct ata_port *ap)
 }
 
 static struct scsi_host_template scc_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static const struct ata_port_operations scc_pata_ops = {
+	.inherits		= &ata_bmdma_port_ops,
+
 	.set_piomode		= scc_set_piomode,
 	.set_dmamode		= scc_set_dmamode,
 	.mode_filter		= scc_mode_filter,
@@ -1003,9 +991,6 @@ static const struct ata_port_operations scc_pata_ops = {
 	.bmdma_status		= scc_bmdma_status,
 	.data_xfer		= scc_data_xfer,
 
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-
 	.freeze			= scc_bmdma_freeze,
 	.error_handler		= scc_error_handler,
 	.post_internal_cmd	= scc_bmdma_stop,
diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index 0b1e882..a5ce863 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -298,89 +298,20 @@ static void serverworks_set_dmamode(struct ata_port *ap, struct ata_device *adev
 }
 
 static struct scsi_host_template serverworks_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index ecdaebe..bc3253d 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -192,54 +192,14 @@ static void sil680_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template sil680_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index ff98050..f155a55 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -514,213 +514,54 @@ static void sis_133_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template sis_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index 51831ac..04fd30b 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -207,54 +207,16 @@ static void sl82c105_bmdma_stop(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template sl82c105_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
 	.bmdma_start 	= sl82c105_bmdma_start,
 	.bmdma_stop	= sl82c105_bmdma_stop,
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
+	.set_piomode	= sl82c105_set_piomode,
+	.error_handler	= sl82c105_error_handler,
 };
 
 /**
diff --git a/drivers/ata/pata_triflex.c b/drivers/ata/pata_triflex.c
index 403eafc..bc4956e 100644
--- a/drivers/ata/pata_triflex.c
+++ b/drivers/ata/pata_triflex.c
@@ -180,54 +180,16 @@ static void triflex_bmdma_stop(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template triflex_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index 47ec47b..c941d5a 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -331,89 +331,20 @@ static void via_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template via_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index 5318248..f235bb0 100644
--- a/drivers/ata/pata_winbond.c
+++ b/drivers/ata/pata_winbond.c
@@ -122,47 +122,14 @@ static unsigned int winbond_data_xfer(struct ata_device *dev,
 }
 
 static struct scsi_host_template winbond_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_PIO_SHT(DRV_NAME),
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
index bc2d12a..a570614 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -143,43 +143,34 @@ static void adma_thaw(struct ata_port *ap);
 static void adma_error_handler(struct ata_port *ap);
 
 static struct scsi_host_template adma_ata_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
-	.proc_name		= DRV_NAME,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
+	ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize		= LIBATA_MAX_PRD,
 	.dma_boundary		= ADMA_DMA_BOUNDARY,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.use_clustering		= ENABLE_CLUSTERING,
-	.emulated		= ATA_SHT_EMULATED,
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
index 7778fd3..e90a4d6 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1202,35 +1202,22 @@ static int sata_fsl_init_controller(struct ata_host *host)
  * scsi mid-layer and libata interface structures
  */
 static struct scsi_host_template sata_fsl_sht = {
-	.module = THIS_MODULE,
-	.name = "sata_fsl",
-	.ioctl = ata_scsi_ioctl,
-	.queuecommand = ata_scsi_queuecmd,
-	.change_queue_depth = ata_scsi_change_queue_depth,
+	ATA_NCQ_SHT("sata_fsl"),
 	.can_queue = SATA_FSL_QUEUE_DEPTH,
-	.this_id = ATA_SHT_THIS_ID,
 	.sg_tablesize = SATA_FSL_MAX_PRD_USABLE,
-	.cmd_per_lun = ATA_SHT_CMD_PER_LUN,
-	.emulated = ATA_SHT_EMULATED,
-	.use_clustering = ATA_SHT_USE_CLUSTERING,
-	.proc_name = "sata_fsl",
 	.dma_boundary = ATA_DMA_BOUNDARY,
-	.slave_configure = ata_scsi_slave_config,
-	.slave_destroy = ata_scsi_slave_destroy,
-	.bios_param = ata_std_bios_param,
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
index ea7e2b1..f94181d 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -120,21 +120,8 @@ static int inic_slave_config(struct scsi_device *sdev)
 }
 
 static struct scsi_host_template inic_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
+	ATA_BMDMA_SHT(DRV_NAME),
 	.slave_configure	= inic_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
 };
 
 static const int scr_map[] = {
@@ -547,26 +534,13 @@ static int inic_port_start(struct ata_port *ap)
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
@@ -574,8 +548,10 @@ static struct ata_port_operations inic_port_ops = {
 	.post_internal_cmd	= inic_post_internal_cmd,
 	.dev_config		= inic_dev_config,
 
-	.port_resume		= inic_port_resume,
+	.scr_read		= inic_scr_read,
+	.scr_write		= inic_scr_write,
 
+	.port_resume		= inic_port_resume,
 	.port_start		= inic_port_start,
 };
 
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 939bf1d..c365650 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -452,61 +452,28 @@ static void mv_channel_reset(struct mv_host_priv *hpriv, void __iomem *mmio,
 			     unsigned int port_no);
 
 static struct scsi_host_template mv5_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
+	ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize		= MV_MAX_SG_CT / 2,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= 1,
-	.proc_name		= DRV_NAME,
 	.dma_boundary		= MV_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
 };
 
 static struct scsi_host_template mv6_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
+	ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize		= MV_MAX_SG_CT / 2,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= 1,
-	.proc_name		= DRV_NAME,
 	.dma_boundary		= MV_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
 };
 
-static const struct ata_port_operations mv5_ops = {
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.cable_detect		= ata_cable_sata,
+static struct ata_port_operations mv5_ops = {
+	.inherits		= &ata_sff_port_ops,
 
 	.qc_prep		= mv_qc_prep,
 	.qc_issue		= mv_qc_issue,
-	.data_xfer		= ata_data_xfer,
-
-	.irq_clear		= ata_noop_irq_clear,
-	.irq_on			= ata_irq_on,
 
-	.error_handler		= mv_error_handler,
-	.post_internal_cmd	= mv_post_int_cmd,
+	.cable_detect		= ata_cable_sata,
 	.freeze			= mv_eh_freeze,
 	.thaw			= mv_eh_thaw,
+	.error_handler		= mv_error_handler,
+	.post_internal_cmd	= mv_post_int_cmd,
 
 	.scr_read		= mv5_scr_read,
 	.scr_write		= mv5_scr_write,
@@ -515,60 +482,15 @@ static const struct ata_port_operations mv5_ops = {
 	.port_stop		= mv_port_stop,
 };
 
-static const struct ata_port_operations mv6_ops = {
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= ata_exec_command,
-	.dev_select		= ata_std_dev_select,
-
-	.cable_detect		= ata_cable_sata,
-
-	.qc_prep		= mv_qc_prep,
-	.qc_issue		= mv_qc_issue,
-	.data_xfer		= ata_data_xfer,
-
-	.irq_clear		= ata_noop_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.error_handler		= mv_error_handler,
-	.post_internal_cmd	= mv_post_int_cmd,
-	.freeze			= mv_eh_freeze,
-	.thaw			= mv_eh_thaw,
-
+static struct ata_port_operations mv6_ops = {
+	.inherits		= &mv5_ops,
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
-	.cable_detect		= ata_cable_sata,
-
+static struct ata_port_operations mv_iie_ops = {
+	.inherits		= &mv6_ops,
 	.qc_prep		= mv_qc_prep_iie,
-	.qc_issue		= mv_qc_issue,
-	.data_xfer		= ata_data_xfer,
-
-	.irq_clear		= ata_noop_irq_clear,
-	.irq_on			= ata_irq_on,
-
-	.error_handler		= mv_error_handler,
-	.post_internal_cmd	= mv_post_int_cmd,
-	.freeze			= mv_eh_freeze,
-	.thaw			= mv_eh_thaw,
-
-	.scr_read		= mv_scr_read,
-	.scr_write		= mv_scr_write,
-
-	.port_start		= mv_port_start,
-	.port_stop		= mv_port_stop,
 };
 
 static const struct ata_port_info mv_port_info[] = {
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 8eb588e..434aee5 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -384,161 +384,60 @@ static struct pci_driver nv_pci_driver = {
 };
 
 static struct scsi_host_template nv_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static struct scsi_host_template nv_adma_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.change_queue_depth	= ata_scsi_change_queue_depth,
+	ATA_NCQ_SHT(DRV_NAME),
 	.can_queue		= NV_ADMA_MAX_CPBS,
-	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= NV_ADMA_SGTBL_TOTAL_LEN,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
 	.dma_boundary		= NV_ADMA_DMA_BOUNDARY,
 	.slave_configure	= nv_adma_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
 };
 
 static struct scsi_host_template nv_swncq_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.change_queue_depth	= ata_scsi_change_queue_depth,
+	ATA_NCQ_SHT(DRV_NAME),
 	.can_queue		= ATA_MAX_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= nv_swncq_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
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
@@ -548,29 +447,17 @@ static const struct ata_port_operations nv_adma_ops = {
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
index a07d319..71fddef 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -153,91 +153,45 @@ static int pdc_pata_cable_detect(struct ata_port *ap);
 static int pdc_sata_cable_detect(struct ata_port *ap);
 
 static struct scsi_host_template pdc_ata_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
+	ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize		= PDC_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
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
index 3c8e97f..107ef09 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -126,44 +126,30 @@ static void qs_thaw(struct ata_port *ap);
 static void qs_error_handler(struct ata_port *ap);
 
 static struct scsi_host_template qs_ata_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
+	ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize		= QS_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ENABLE_CLUSTERING,
-	.proc_name		= DRV_NAME,
 	.dma_boundary		= QS_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
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
index 53f0bae..eac7ca7 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -167,48 +167,17 @@ static struct pci_driver sil_pci_driver = {
 };
 
 static struct scsi_host_template sil_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index 5e57f78..d90d328 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -384,52 +384,34 @@ static struct pci_driver sil24_pci_driver = {
 };
 
 static struct scsi_host_template sil24_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.change_queue_depth	= ata_scsi_change_queue_depth,
+	ATA_NCQ_SHT(DRV_NAME),
 	.can_queue		= SIL24_MAX_CMDS,
-	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= SIL24_MAX_SGE,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
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
index a8adef9..9089c7a 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -86,46 +86,13 @@ static struct pci_driver sis_pci_driver = {
 };
 
 static struct scsi_host_template sis_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index 302854c..26e624a 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -307,51 +307,23 @@ static int k2_sata_proc_info(struct Scsi_Host *shost, char *page, char **start,
 
 
 static struct scsi_host_template k2_sata_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
+	ATA_BMDMA_SHT(DRV_NAME),
 #ifdef CONFIG_PPC_OF
 	.proc_info		= k2_sata_proc_info,
 #endif
-	.bios_param		= ata_std_bios_param,
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
index e3d56bc..8138cda 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -236,24 +236,13 @@ static unsigned int pdc20621_qc_issue_prot(struct ata_queued_cmd *qc);
 
 
 static struct scsi_host_template pdc_sata_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
+	ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
 };
 
-static const struct ata_port_operations pdc_20621_ops = {
+/* TODO: inherit from base port_ops after converting to new EH */
+static struct ata_port_operations pdc_20621_ops = {
 	.tf_load		= pdc_tf_load_mmio,
 	.tf_read		= ata_tf_read,
 	.check_status		= ata_check_status,
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index f7fc045..6ecd13f 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -76,51 +76,13 @@ static struct pci_driver uli_pci_driver = {
 };
 
 static struct scsi_host_template uli_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index 8d64a3d..8b7d78b 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -102,114 +102,26 @@ static struct pci_driver svia_pci_driver = {
 };
 
 static struct scsi_host_template svia_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index 099a2ba..8045a72 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -300,47 +300,18 @@ out:
 
 
 static struct scsi_host_template vsc_sata_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
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
index b6f06a2..27ceed7 100644
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
@@ -607,7 +607,7 @@ struct ata_link {
 
 struct ata_port {
 	struct Scsi_Host	*scsi_host; /* our co-allocated scsi host */
-	const struct ata_port_operations *ops;
+	struct ata_port_operations *ops;
 	spinlock_t		*lock;
 	unsigned long		flags;	/* ATA_FLAG_xxx */
 	unsigned int		pflags; /* ATA_PFLAG_xxx */
@@ -672,6 +672,13 @@ struct ata_port {
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
@@ -741,6 +748,12 @@ struct ata_port_operations {
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
@@ -750,7 +763,7 @@ struct ata_port_info {
 	unsigned long		pio_mask;
 	unsigned long		mwdma_mask;
 	unsigned long		udma_mask;
-	const struct ata_port_operations *port_ops;
+	struct ata_port_operations *port_ops;
 	irq_handler_t		irq_handler;
 	void 			*private_data;
 };
@@ -773,7 +786,7 @@ extern const unsigned long sata_deb_timing_normal[];
 extern const unsigned long sata_deb_timing_hotplug[];
 extern const unsigned long sata_deb_timing_long[];
 
-extern const struct ata_port_operations ata_dummy_port_ops;
+extern struct ata_port_operations ata_dummy_port_ops;
 extern const struct ata_port_info ata_dummy_port_info;
 
 static inline const unsigned long *
@@ -820,7 +833,7 @@ extern int ata_host_activate(struct ata_host *host, int irq,
 			     struct scsi_host_template *sht);
 extern void ata_host_detach(struct ata_host *host);
 extern void ata_host_init(struct ata_host *, struct device *,
-			  unsigned long, const struct ata_port_operations *);
+			  unsigned long, struct ata_port_operations *);
 extern int ata_scsi_detect(struct scsi_host_template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
@@ -1078,6 +1091,63 @@ extern void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
 		      ata_postreset_fn_t postreset);
 
 /*
+ * Base operations to inherit from and initializers for sht
+ *
+ * Operations
+ *
+ * base  : Common to all libata drivers.
+ * sata  : SATA controllers w/ native interface.
+ * pmp   : SATA controllers w/ PMP support.
+ * sff   : SFF ATA controllers w/o BMDMA support.
+ * bmdma : SFF ATA controllers w/ BMDMA support.
+ *
+ * sht initializers
+ *
+ * BASE  : Common to all libata drivers.  The user must set
+ *	   sg_tablesize and dma_boundary.
+ * PIO   : SFF ATA controllers w/ only PIO support.
+ * BMDMA : SFF ATA controllers w/ BMDMA support.  sg_tablesize and
+ *	   dma_boundary are set to BMDMA limits.
+ * NCQ   : SATA controllers supporting NCQ.  The user must set
+ *	   sg_tablesize, dma_boundary and can_queue.
+ */
+extern const struct ata_port_operations ata_base_port_ops;
+extern const struct ata_port_operations sata_port_ops;
+extern const struct ata_port_operations sata_pmp_port_ops;
+extern const struct ata_port_operations ata_sff_port_ops;
+extern const struct ata_port_operations ata_bmdma_port_ops;
+
+#define ATA_BASE_SHT(drv_name)					\
+	.module			= THIS_MODULE,			\
+	.name			= drv_name,			\
+	.ioctl			= ata_scsi_ioctl,		\
+	.queuecommand		= ata_scsi_queuecmd,		\
+	.can_queue		= ATA_DEF_QUEUE,		\
+	.this_id		= ATA_SHT_THIS_ID,		\
+	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,		\
+	.emulated		= ATA_SHT_EMULATED,		\
+	.use_clustering		= ATA_SHT_USE_CLUSTERING,	\
+	.proc_name		= drv_name,			\
+	.slave_configure	= ata_scsi_slave_config,	\
+	.slave_destroy		= ata_scsi_slave_destroy,	\
+	.bios_param		= ata_std_bios_param
+
+/* PIO only, sg_tablesize and dma_boundary limits can be removed */
+#define ATA_PIO_SHT(drv_name)					\
+	ATA_BASE_SHT(drv_name),					\
+	.sg_tablesize		= LIBATA_MAX_PRD,		\
+	.dma_boundary		= ATA_DMA_BOUNDARY
+
+#define ATA_BMDMA_SHT(drv_name)					\
+	ATA_BASE_SHT(drv_name),					\
+	.sg_tablesize		= LIBATA_MAX_PRD,		\
+	.dma_boundary		= ATA_DMA_BOUNDARY
+
+#define ATA_NCQ_SHT(drv_name)					\
+	ATA_BASE_SHT(drv_name),					\
+	.change_queue_depth	= ata_scsi_change_queue_depth
+
+/*
  * printk helpers
  */
 #define ata_port_printk(ap, lv, fmt, args...) \
-- 
1.5.2.4

