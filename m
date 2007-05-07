From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Re: 2.6.19.1, sata_sil: sata dvd writer doesn't work
Date: Mon, 07 May 2007 10:24:25 +0200
Message-ID: <463EE239.8060709@gmail.com>
References: <46362672.7080103@gmx.net> <4636DCA9.9050803@gmail.com> <4636FBB7.3030605@gmx.net> <463AE631.9030701@gmail.com> <463B7903.4070206@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000707090102060205080009"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:29695 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136AbXEGIYh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 May 2007 04:24:37 -0400
Received: by py-out-1112.google.com with SMTP id a29so1126615pyi
        for <linux-ide@vger.kernel.org>; Mon, 07 May 2007 01:24:36 -0700 (PDT)
In-Reply-To: <463B7903.4070206@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Beichl <daniel_beichl@gmx.net>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------000707090102060205080009
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello, Daniel.

Daniel Beichl wrote:
>> Okay, I've been thinking about it for some time.  I think I know what's
>> going on now.  Those authentication related commands are issued by
>> invoking ioctls on the device node.  The cdrom driver receives the
>> ioctls and issues respective SCSI commands for it.  All those DVD auth
>> commands either transfer or receive data from the device and thus
>> specifies certain data direction when they're issued.  libata selects
>> command protocol accordingly.
>>
>> It's all good and dandy till now but the problem is that those commands
>> can be issued with data length of zero!  This is allowed by the SCSI MMC
>> standard and used to probe whether the command succeeds or not before
>> taking further actions.  When this happens, libata chooses command
>> protocol according to the data direction, but has to feed 0-length data
>> to the DMA engine.  It seems sata_sil dma engine barfs if that happens.
>>  Can you please add the following code snippet at the head of
>> atapi_xlat()?
>>
>>     if (!nodata && !qc->nbytes) {
>>         printk("XXX forcing PIO for 0 length data cdb %02x\n",
>>             scmd->cmnd[0]);
>>         dump_stack();
>>         using_pio = 1;
>>     }
>>
>> Also, do you mind cc'ing linux-ide@vger.kernel.org?
>>
>>   
> Hi Tejun,
> 
> 
> i inserted the code snippet you mentioned to atapi_xlat() in libata-scsi.c
> and the dvd authentication succeeds.
> 
> Please see the attached dmesg file for the generated stack dumps.

Good to know it works.  :-)

> The question is whether this is the right place to fix it, as this seems
> to limit all
> drivers to pio if a zero data length command is transferred.
> It would make more sense to me if the individual driver decides this by
> performing a similar check in the check_atapi_dma function implemented
> by the
> individual driver. I did this for the sata_sil driver in the attached
> patch.

The thing is that those commands don't transfer any data at all, so it
doesn't really matter whether the data phase is specified as DMA or PIO.
 ATA_PROT_ATAPI degenerates into ATA_PROT_ATAPI_NODATA if there is no
data to transfer (in ATA spec they share the same protocol state machine
and the data request status bit dictates what actually happens).

I think this actually should be fixed in the cdrom driver.  It shouldn't
issue data command with 0 data length with data protocol.  Can you test
whether the attached patch works?  Also, it seems we'll need to add a
WARN_ON() in sr such that bugs like this can be caught more easily.

Thanks.

-- 
tejun

--------------000707090102060205080009
Content-Type: text/x-patch;
 name="DATA_NONE-if-len-zero.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="DATA_NONE-if-len-zero.patch"

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index b36f44d..5a5639d 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -1533,7 +1533,10 @@ void init_cdrom_command(struct packet_co
 		memset(buf, 0, len);
 	cgc->buffer = (char *) buf;
 	cgc->buflen = len;
-	cgc->data_direction = type;
+	if (len)
+		cgc->data_direction = type;
+	else
+		cgc->data_direction = CGC_DATA_NONE;
 	cgc->timeout = CDROM_DEF_TIMEOUT;
 }
 

--------------000707090102060205080009--
