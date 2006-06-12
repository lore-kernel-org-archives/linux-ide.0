From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/10] libata: kill per-device PM
Date: Tue, 13 Jun 2006 00:50:28 +0900
Message-ID: <11501274281240-git-send-email-htejun@gmail.com>
References: <11501274284082-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:13646 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1752082AbWFLPuf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 11:50:35 -0400
Received: by py-out-1112.google.com with SMTP id x31so1732389pye
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2006 08:50:35 -0700 (PDT)
In-Reply-To: <11501274284082-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

As new PM implementation will expand the existing controller-wide PM
to trigger ATA bus wide PM operations, it collides with per-device PM.
Kill per-device PM in preparation for new PM framework.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ata_piix.c    |    2 -
 drivers/scsi/libata-core.c |   83 --------------------------------------------
 drivers/scsi/libata-scsi.c |   16 --------
 include/linux/libata.h     |    4 --
 4 files changed, 0 insertions(+), 105 deletions(-)

aa2de6bd3de34adcf6a736a70e88f90aba652c3b
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 521b718..75aa47f 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -220,8 +220,6 @@ static struct scsi_host_template piix_sh
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
 };
 
 static const struct ata_port_operations piix_pata_ops = {
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 51d3b4b..d9fdbbd 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4947,84 +4947,6 @@ static int ata_do_simple_cmd(struct ata_
 	return err;
 }
 
-static int ata_flush_cache(struct ata_device *dev)
-{
-	u8 cmd;
-
-	if (!ata_try_flush_cache(dev))
-		return 0;
-
-	if (ata_id_has_flush_ext(dev->id))
-		cmd = ATA_CMD_FLUSH_EXT;
-	else
-		cmd = ATA_CMD_FLUSH;
-
-	return ata_do_simple_cmd(dev, cmd);
-}
-
-static int ata_standby_drive(struct ata_device *dev)
-{
-	return ata_do_simple_cmd(dev, ATA_CMD_STANDBYNOW1);
-}
-
-static int ata_start_drive(struct ata_device *dev)
-{
-	return ata_do_simple_cmd(dev, ATA_CMD_IDLEIMMEDIATE);
-}
-
-/**
- *	ata_device_resume - wakeup a previously suspended devices
- *	@dev: the device to resume
- *
- *	Kick the drive back into action, by sending it an idle immediate
- *	command and making sure its transfer mode matches between drive
- *	and host.
- *
- */
-int ata_device_resume(struct ata_device *dev)
-{
-	struct ata_port *ap = dev->ap;
-
-	if (ap->flags & ATA_FLAG_SUSPENDED) {
-		struct ata_device *failed_dev;
-
-		ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 200000);
-
-		ap->flags &= ~ATA_FLAG_SUSPENDED;
-		while (ata_set_mode(ap, &failed_dev))
-			ata_dev_disable(failed_dev);
-	}
-	if (!ata_dev_enabled(dev))
-		return 0;
-	if (dev->class == ATA_DEV_ATA)
-		ata_start_drive(dev);
-
-	return 0;
-}
-
-/**
- *	ata_device_suspend - prepare a device for suspend
- *	@dev: the device to suspend
- *	@state: target power management state
- *
- *	Flush the cache on the drive, if appropriate, then issue a
- *	standbynow command.
- */
-int ata_device_suspend(struct ata_device *dev, pm_message_t state)
-{
-	struct ata_port *ap = dev->ap;
-
-	if (!ata_dev_enabled(dev))
-		return 0;
-	if (dev->class == ATA_DEV_ATA)
-		ata_flush_cache(dev);
-
-	if (state.event != PM_EVENT_FREEZE)
-		ata_standby_drive(dev);
-	ap->flags |= ATA_FLAG_SUSPENDED;
-	return 0;
-}
-
 /**
  *	ata_port_start - Set port up for dma.
  *	@ap: Port to initialize
@@ -5872,11 +5794,6 @@ EXPORT_SYMBOL_GPL(ata_pci_default_filter
 EXPORT_SYMBOL_GPL(ata_pci_clear_simplex);
 #endif /* CONFIG_PCI */
 
-EXPORT_SYMBOL_GPL(ata_device_suspend);
-EXPORT_SYMBOL_GPL(ata_device_resume);
-EXPORT_SYMBOL_GPL(ata_scsi_device_suspend);
-EXPORT_SYMBOL_GPL(ata_scsi_device_resume);
-
 EXPORT_SYMBOL_GPL(ata_eng_timeout);
 EXPORT_SYMBOL_GPL(ata_port_schedule_eh);
 EXPORT_SYMBOL_GPL(ata_port_abort);
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 45a49be..0c30e6c 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -399,22 +399,6 @@ void ata_dump_status(unsigned id, struct
 	}
 }
 
-int ata_scsi_device_resume(struct scsi_device *sdev)
-{
-	struct ata_port *ap = ata_shost_to_port(sdev->host);
-	struct ata_device *dev = __ata_scsi_find_dev(ap, sdev);
-
-	return ata_device_resume(dev);
-}
-
-int ata_scsi_device_suspend(struct scsi_device *sdev, pm_message_t state)
-{
-	struct ata_port *ap = ata_shost_to_port(sdev->host);
-	struct ata_device *dev = __ata_scsi_find_dev(ap, sdev);
-
-	return ata_device_suspend(dev, state);
-}
-
 /**
  *	ata_to_sense_error - convert ATA error to SCSI error
  *	@id: ATA device number
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 369f821..17c8ced 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -657,10 +657,6 @@ extern int sata_scr_write(struct ata_por
 extern int sata_scr_write_flush(struct ata_port *ap, int reg, u32 val);
 extern int ata_port_online(struct ata_port *ap);
 extern int ata_port_offline(struct ata_port *ap);
-extern int ata_scsi_device_resume(struct scsi_device *);
-extern int ata_scsi_device_suspend(struct scsi_device *, pm_message_t state);
-extern int ata_device_resume(struct ata_device *);
-extern int ata_device_suspend(struct ata_device *, pm_message_t state);
 extern int ata_ratelimit(void);
 extern unsigned int ata_busy_sleep(struct ata_port *ap,
 				   unsigned long timeout_pat,
-- 
1.3.2


