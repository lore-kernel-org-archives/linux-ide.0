From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 3/4] scsi: expose AN support to user space
Date: Thu, 25 Oct 2007 03:15:05 -0400
Message-ID: <47204279.9010901@garzik.org>
References: <200710162121.l9GLLPKo017811@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080901060003050807040904"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46364 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753670AbXJYHPL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Oct 2007 03:15:11 -0400
In-Reply-To: <200710162121.l9GLLPKo017811@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, kristen.c.accardi@intel.com, James.Bottomley@steeleye.com, htejun@gmail.com

This is a multi-part message in MIME format.
--------------080901060003050807040904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

akpm@linux-foundation.org wrote:
> From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> 
> If a scsi_device supports async notification for media change, then let user
> space know this capability exists by creating a new sysfs entry
> "media_change_notify", which will be 1 if it is supported, and 0 if not
> supported.  Create a routine which allows scsi devices to send a uevent when
> media change events occur.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> Acked-by: Jeff Garzik <jeff@garzik.org>
> Cc: Tejun Heo <htejun@gmail.com>
> Cc: James Bottomley <James.Bottomley@steeleye.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/scsi/scsi_lib.c    |   83 +++++++++++++++++++++++++++++++++++
>  drivers/scsi/scsi_scan.c   |    1 
>  drivers/scsi/scsi_sysfs.c  |   13 +++++
>  include/scsi/scsi_device.h |   15 +++++-
>  4 files changed, 111 insertions(+), 1 deletion(-)

committed to libata-dev.git#an as the attached patch

I changed the interface such that it takes a mask of events.  We only 
have one event right now, but it is now trivial to add more events 
within the same interface.


--------------080901060003050807040904
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

commit 4e0af19e75e40d71181c4e515009e81f19a0fc04
Author: Jeff Garzik <jeff@garzik.org>
Date:   Thu Oct 25 03:13:46 2007 -0400

    [SCSI] Emit asynchronous media events
    
    Based originally on a patch by
    Kristen Carlson Accardi <kristen.c.accardi@intel.com>
    
    Signed-off-by: Jeff Garzik <jgarzik@redhat.com>

 drivers/scsi/scsi_lib.c    |   58 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/scsi_sysfs.c  |   13 ++++++++++
 include/scsi/scsi_device.h |   13 +++++++++-
 3 files changed, 83 insertions(+), 1 deletion(-)

4e0af19e75e40d71181c4e515009e81f19a0fc04
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 61fdaf0..46a7f50 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2115,6 +2115,64 @@ scsi_device_set_state(struct scsi_device *sdev, enum scsi_device_state state)
 EXPORT_SYMBOL(scsi_device_set_state);
 
 /**
+ * 	scsi_device_event_notify_thread - send a uevent for each scsi event
+ *	@work: work struct for scsi_device
+ *
+ *	Emit all queued media events as environment variables
+ *	sent during a uevent.
+ */
+static void scsi_event_notify_thread(struct work_struct *work)
+{
+	struct scsi_device *sdev;
+	char *envp[3];
+	unsigned long flags, mask;
+	int i, idx;
+
+	/* must match scsi_device_event enum in scsi_device.h */
+	static char *scsi_device_event_strings[] = {
+		[SDEV_MEDIA_CHANGE] = "SDEV_MEDIA_CHANGE=1",
+	};
+
+	sdev = container_of(work, struct scsi_device, ew.work);
+
+	spin_lock_irqsave(&sdev->list_lock, flags);
+	mask = sdev->event_mask;
+	sdev->event_mask = 0;
+	spin_unlock_irqrestore(&sdev->list_lock, flags);
+
+	idx = 0;
+	for (i = 0; i < SDEV_MEDIA_LAST; i++)
+		if (mask & (1UL << i))
+			envp[idx++] = scsi_device_event_strings[i];
+	envp[idx++] = NULL;
+
+	kobject_uevent_env(&sdev->sdev_gendev.kobj, KOBJ_CHANGE, envp);
+}
+
+/**
+ * 	scsi_device_event_notify - store event info and send an event
+ *	@sdev: scsi_device event occurred on
+ *	@mask: the scsi device event mask
+ *
+ * 	Store the event information and then switch process context
+ * 	so that the event may be sent to user space.
+ * 	This may be called from interrupt context.
+ *
+ * 	Returns 0 if successful, -ENOMEM otherwise.
+ */
+void scsi_device_event_notify(struct scsi_device *sdev, unsigned long mask)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sdev->list_lock, flags);
+	sdev->event_mask |= mask;
+	spin_unlock_irqrestore(&sdev->list_lock, flags);
+
+	execute_in_process_context(scsi_event_notify_thread, &sdev->ew);
+}
+EXPORT_SYMBOL_GPL(scsi_device_event_notify);
+
+/**
  *	scsi_device_quiesce - Block user issued commands.
  *	@sdev:	scsi device to quiesce.
  *
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index d531cee..d6e765c 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -614,6 +614,18 @@ sdev_show_modalias(struct device *dev, struct device_attribute *attr, char *buf)
 }
 static DEVICE_ATTR(modalias, S_IRUGO, sdev_show_modalias, NULL);
 
+static ssize_t
+sdev_show_media_events(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	if (sdev->media_events)
+		return snprintf(buf, 20, "%d\n", 1);
+	else
+		return snprintf(buf, 20, "%d\n", 0);
+}
+static DEVICE_ATTR(media_events, S_IRUGO, sdev_show_media_events, NULL);
+
 /* Default template for device attributes.  May NOT be modified */
 static struct attribute *scsi_sdev_attrs[] = {
 	&dev_attr_device_blocked.attr,
@@ -631,6 +643,7 @@ static struct attribute *scsi_sdev_attrs[] = {
 	&dev_attr_iodone_cnt.attr,
 	&dev_attr_ioerr_cnt.attr,
 	&dev_attr_modalias.attr,
+	&dev_attr_media_events.attr,
 	NULL
 };
 
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index d5057bc..ca208f8 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -46,6 +46,13 @@ enum scsi_device_state {
 				 * to the scsi lld. */
 };
 
+/* must match scsi_device_event_strings in scsi_lib.c */
+enum scsi_device_event {
+	SDEV_MEDIA_CHANGE	= 1,	/* media has changed */
+
+	SDEV_MEDIA_LAST		= SDEV_MEDIA_CHANGE,
+};
+
 struct scsi_device {
 	struct Scsi_Host *host;
 	struct request_queue *request_queue;
@@ -126,12 +133,14 @@ struct scsi_device {
 	unsigned fix_capacity:1;	/* READ_CAPACITY is too high by 1 */
 	unsigned guess_capacity:1;	/* READ_CAPACITY might be too high by 1 */
 	unsigned retry_hwerror:1;	/* Retry HARDWARE_ERROR */
-
+	unsigned media_events:1;	/* dev supports async media events */
 	unsigned int device_blocked;	/* Device returned QUEUE_FULL. */
 
 	unsigned int max_device_blocked; /* what device_blocked counts down from  */
 #define SCSI_DEFAULT_DEVICE_BLOCKED	3
 
+	unsigned long event_mask;	/* SDEV_MEDIA_xxx (1<<x for mask) */
+
 	atomic_t iorequest_cnt;
 	atomic_t iodone_cnt;
 	atomic_t ioerr_cnt;
@@ -275,6 +284,8 @@ extern int scsi_test_unit_ready(struct scsi_device *sdev, int timeout,
 				int retries);
 extern int scsi_device_set_state(struct scsi_device *sdev,
 				 enum scsi_device_state state);
+extern void scsi_device_event_notify(struct scsi_device *sdev,
+				     unsigned long event_mask);
 extern int scsi_device_quiesce(struct scsi_device *sdev);
 extern void scsi_device_resume(struct scsi_device *sdev);
 extern void scsi_target_quiesce(struct scsi_target *);

--------------080901060003050807040904--
