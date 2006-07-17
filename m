From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/12] libata: implement ata_all_ports list
Date: Mon, 17 Jul 2006 15:52:31 +0900
Message-ID: <11531191512553-git-send-email-htejun@gmail.com>
References: <11531191512028-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.200]:23944 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751299AbWGQGvN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Jul 2006 02:51:13 -0400
Received: by nz-out-0102.google.com with SMTP id x7so398399nzc
        for <linux-ide@vger.kernel.org>; Sun, 16 Jul 2006 23:51:12 -0700 (PDT)
In-Reply-To: <11531191512028-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement ata_all_ports list.  All active ata_ports are linked on this
list.  This will be used to dynamically modify libata-wide
configurations.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   13 +++++++++++++
 include/linux/libata.h     |    2 ++
 2 files changed, 15 insertions(+), 0 deletions(-)

a962488760934f639dd202793694339afd2db1cf
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 61db4f5..1477d32 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -70,6 +70,9 @@ static unsigned int ata_dev_init_params(
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
 static void ata_dev_xfermask(struct ata_device *dev);
 
+static DEFINE_MUTEX(ata_all_ports_mutex);
+static LIST_HEAD(ata_all_ports);
+
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
 
@@ -5464,6 +5467,11 @@ int ata_device_add(const struct ata_prob
 
 		ap = host_set->ports[i];
 
+		/* this port is active now, add it to all_ports */
+		mutex_lock(&ata_all_ports_mutex);
+		list_add_tail(&ap->all_ports_entry, &ata_all_ports);
+		mutex_unlock(&ata_all_ports_mutex);
+
 		/* init sata_spd_limit to the current value */
 		if (sata_scr_read(ap, SCR_CONTROL, &scontrol) == 0) {
 			int spd = (scontrol >> 4) & 0xf;
@@ -5594,6 +5602,11 @@ void ata_port_detach(struct ata_port *ap
 	cancel_delayed_work(&ap->hotplug_task);
 	flush_workqueue(ata_aux_wq);
 
+	/* this port is dead now, remove from all_ports */
+	mutex_lock(&ata_all_ports_mutex);
+	list_del_init(&ap->all_ports_entry);
+	mutex_unlock(&ata_all_ports_mutex);
+
 	/* remove the associated SCSI host */
 	scsi_remove_host(ap->host);
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 66c3100..c9ed035 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -555,6 +555,8 @@ struct ata_port {
 	pm_message_t		pm_mesg;
 	int			*pm_result;
 
+	struct list_head	all_ports_entry;
+
 	void			*private_data;
 
 	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
-- 
1.3.2


