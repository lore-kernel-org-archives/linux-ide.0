From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] libata atapi work #2.1
Date: 17 May 2004 08:56:07 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084805767.3083.10.camel@patibmrh9>
References: <1084721991.3085.6.camel@patibmrh9> <40A7F757.9020200@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:56571 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S261528AbUEQO4Z
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 May 2004 10:56:25 -0400
In-Reply-To: <40A7F757.9020200@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff G:

> something is working...
 
Yes!

In my one sample, even misaligning a dd-shattered stream costs me only
0.5 GB/min at the outside of the disc, so command/ status overhead is
running reasonably low.

> Please let me know what patches (if any
> besides #define) are needed for setup, after
> you include patch #2.2 and #2.3 in the pile.

I will revert to -bk3 vanilla, then apply 2.* from linux-ide, then
report back.

> Two main things on the SCSI end of ATAPI to
> do:
> * issue REQUEST SENSE, to simulate an
> auto-sensing scsi device

I will try to create a desired inference of ATAPI op x03 "REQUEST SENSE"
to immediately follow the failing command, after the pattern of the
existing inference of ATA op xA1 "IDENTIFY".

I will have to discover how to auto sense only after a plain failure,
not inappropriately after a timeout.  Last I checked, the code was
written to see any failure as if it were a timeout.

> * in INQUIRY output, simulate compliance with
> MMC-3.  Linux SCSI stack is not aware that all
> ATAPI devices report zeroes in the SCSI version
> field (as do some USB storage devices).  So,
> we fake it.

I will try to munge the otherwise transparent pass thru of op x12
"INQUIRY" after the pattern of:

http://lxr.linux.no/source/drivers/usb/storage/protocol.c?v=2.6.5#L62

62 static void fix_inquiry_data(Scsi_Cmnd *srb)
...
82         /* Change the SCSI revision number */
83         databuf[2] = (databuf[2] & ~7) | 2;

I suppose there is no saving the transparency of ioctl CDROM_SEND_PACKET
and ioctl SG_IO.  Because of this linux-scsi legacy, we have to lose the
bits that we read from the device.

Pat LaVarre


