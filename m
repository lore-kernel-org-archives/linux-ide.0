From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: PATCH libata-2.6 4/5] Prevent the device from overrunning the
 buffer in __atapi_pio_bytes()
Date: Tue, 29 Mar 2005 20:41:36 +0800
Message-ID: <42494D00.3050807@tw.ibm.com>
References: <423A8AA4.5040601@tw.ibm.com> <58cb370e0503180031d40b0a3@mail.gmail.com> <423A9989.7050008@tw.ibm.com> <42406DF8.6050504@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060101000409010703010206"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:28142 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262262AbVC2MmH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Mar 2005 07:42:07 -0500
In-Reply-To: <42406DF8.6050504@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------060101000409010703010206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Jeff Garzik wrote:
> Albert Lee wrote:
> 
>>  >
>>  > Bartlomiej Zolnierkiewicz wrote:
>>
>>>>
>>>> Problem:
>>>>   Some bad behaved CD-ROM drives will return more data than ask to.
>>>> (I have such CD-RW drive and it crashed the kernel.)
>>>
>>>
>>> These devices are compliant with original ATAPI spec.
>>>
>>> Such condition shouldn't be treated as an error
>>> - extra data should be read and dumped.
>>>
>>>
>> Hi Bart,
>>
>> For read, we can read and discard the extra data from the device.
>> For write, the device is asking for more data than we have.
>> Should we supply some dummy data to the device? Or we just stop and 
>> return it as error?
> 
> 
> For write, we need to pad.  For DMA, we need to add additional zeroes, 
> until the DMA transfer ends on a dword boundary.  For PIO, we must at 
> least pad to a word boundary.
> 
>     Jeff
> 


Attached please find the revised patch for your review.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---------------------------------------
--- libata-2.6-reorder/drivers/scsi/libata-core.c	2005-03-18 12:56:44.000000000 +0800
+++ libata-2.6-extrabytes/drivers/scsi/libata-core.c	2005-03-29 20:23:24.000000000 +0800
@@ -2338,6 +2338,23 @@
  		ap->pio_task_state = PIO_ST_LAST;

  next_sg:
+	/* check whether qc->sg is full */
+	if (unlikely(qc->cursg >= qc->n_elem)) {
+		unsigned char pad_buf[2];
+		unsigned int words = (bytes+1) >> 1; /* pad to word boundary */
+		unsigned int i;
+
+		DPRINTK("ata%u: padding %u bytes\n", ap->id, bytes);
+
+		memset(&pad_buf, 0, sizeof(pad_buf));
+		for (i = 0; i < words; i++) {
+			ata_data_xfer(ap, pad_buf, sizeof(pad_buf), do_write);
+		}
+
+		ap->pio_task_state = PIO_ST_LAST;
+		return;
+	}
+
  	sg = &qc->sg[qc->cursg];

  	page = sg->page;


--------------060101000409010703010206
Content-Type: text/plain;
 name="extrabytes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="extrabytes.diff"

--- libata-2.6-reorder/drivers/scsi/libata-core.c	2005-03-18 12:56:44.000000000 +0800
+++ libata-2.6-extrabytes/drivers/scsi/libata-core.c	2005-03-29 20:23:24.000000000 +0800
@@ -2338,6 +2338,23 @@
 		ap->pio_task_state = PIO_ST_LAST;
 
 next_sg:
+	/* check whether qc->sg is full */
+	if (unlikely(qc->cursg >= qc->n_elem)) {
+		unsigned char pad_buf[2];
+		unsigned int words = (bytes+1) >> 1; /* pad to word boundary */
+		unsigned int i;
+
+		DPRINTK("ata%u: padding %u bytes\n", ap->id, bytes);
+
+		memset(&pad_buf, 0, sizeof(pad_buf));
+		for (i = 0; i < words; i++) {
+			ata_data_xfer(ap, pad_buf, sizeof(pad_buf), do_write);
+		}
+
+		ap->pio_task_state = PIO_ST_LAST;
+		return;
+	}
+
 	sg = &qc->sg[qc->cursg];
 
 	page = sg->page;

--------------060101000409010703010206--


