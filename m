From: Jiada Wang <stephen.jiadawang@gmail.com>
Subject: Re: [patch] libata handle HDIO_SET_DMA HDIO_GET_DMA ioctl
Date: Fri, 18 Jan 2013 22:24:24 +0900
Message-ID: <CAK4xk3ju8RrZsM28wJqDgJKE2ZwK1KWV=bYeJFibS_sZ7Xmfrw@mail.gmail.com>
References: <CAK4xk3h7FVCsSzE3M1AJKV8rF0S0C+HiEvu0a6D24joPe-n7jA@mail.gmail.com>
	<50F930D2.4050506@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:35447 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab3ARNYZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jan 2013 08:24:25 -0500
Received: by mail-qc0-f170.google.com with SMTP id d42so1046029qca.1
        for <linux-ide@vger.kernel.org>; Fri, 18 Jan 2013 05:24:25 -0800 (PST)
In-Reply-To: <50F930D2.4050506@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Hi Sergei

Thank you for your reply

inserted the patch below,
I noticed libata doesn't support to use PIO mode when DMA mode is
available, is there any specific reasons?


>From d92586d8a707f06dc0b8189fd22483a9d8a753d4 Mon Sep 17 00:00:00 2001
From: Jiada Wang <jiada_wang@mentor.com>
Date: Wed, 26 Dec 2012 17:00:39 +0900
Subject: [PATCH] libata: handle HDIO_SET_DMA & HDIO_GET_DMA ioctl

currently HDIO_SET_DMA & HDIO_GET_DMA are not handled in libata,
this patch add support to handle HDIO_SET_DMA & HDIO_GET_DMA ioctl,
which enables user to set ata device work in PIO or DMA mode.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/ata/libata-core.c |  2 +-
 drivers/ata/libata-scsi.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/libata.h    |  1 +
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 71e8385..6b16952 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3136,7 +3136,7 @@ int ata_down_xfermask_limit(struct ata_device
*dev, unsigned int sel)
  return 0;
 }

-static int ata_dev_set_mode(struct ata_device *dev)
+int ata_dev_set_mode(struct ata_device *dev)
 {
  struct ata_port *ap = dev->link->ap;
  struct ata_eh_context *ehc = &dev->link->eh_context;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 2222635..beac285 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -660,6 +660,8 @@ int ata_sas_scsi_ioctl(struct ata_port *ap, struct
scsi_device *scsidev,
 {
  int val = -EINVAL, rc = -EINVAL;
  unsigned long flags;
+ struct ata_device *dev = __ata_scsi_find_dev(ap, scsidev);
+ int dma;

  switch (cmd) {
  case ATA_IOC_GET_IO32:
@@ -699,6 +701,40 @@ int ata_sas_scsi_ioctl(struct ata_port *ap,
struct scsi_device *scsidev,
  return -EACCES;
  return ata_task_ioctl(scsidev, arg);

+ case HDIO_GET_DMA:
+ return put_user(dev->xfer_mode == dev->dma_mode,
+ (long __user *) arg);
+ case HDIO_SET_DMA:
+ if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
+ return -EACCES;
+
+ if (copy_from_user(&dma, arg, sizeof(dma)))
+ return -EFAULT;
+
+ if (dma) {
+ if (!ata_dma_enabled(dev))
+ return -EINVAL;
+
+ dev->xfer_mode = dev->dma_mode;
+ dev->xfer_shift = ata_xfer_mode2shift(dev->dma_mode);
+ if (ap->ops->set_dmamode)
+ ap->ops->set_dmamode(ap, dev);
+ } else {
+ if (dev->pio_mode == 0xff)
+ return -EINVAL;
+
+ dev->xfer_mode = dev->pio_mode;
+ dev->xfer_shift = ATA_SHIFT_PIO;
+ if (ap->ops->set_piomode)
+ ap->ops->set_piomode(ap, dev);
+ }
+
+ ata_eh_acquire(ap);
+ rc = ata_dev_set_mode(dev);
+ ata_eh_release(ap);
+
+ return rc;
+
  default:
  rc = -ENOTTY;
  break;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6e887c7..88664b67 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1067,6 +1067,7 @@ extern int ata_cable_80wire(struct ata_port *ap);
 extern int ata_cable_sata(struct ata_port *ap);
 extern int ata_cable_ignore(struct ata_port *ap);
 extern int ata_cable_unknown(struct ata_port *ap);
+extern int ata_dev_set_mode(struct ata_device *dev);

 /* Timing helpers */
 extern unsigned int ata_pio_need_iordy(const struct ata_device *);
--
1.7.12.3

2013/1/18 Sergei Shtylyov <sshtylyov@mvista.com>:
> Hello.
>
>
> On 18-01-2013 11:55, Jiada Wang wrote:
>
>> The purpose of this patch is to switch SATA device in PIO mode and DMA
>> mode,
>> And get current transfer mode,
>
>
>> Please kindly give me your comments
>
>
>    You posted the patch in the form on which it's hard to give comments.
> Never attach the patches (especially with non-text/plain MIME type), instert
> them inline instead.
>
>> Thanks,
>
>
>> Jiada
>
>
> MBR, Sergei
>



-- 
BRs
Stephen
