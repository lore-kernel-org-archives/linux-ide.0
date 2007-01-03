From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: add support for ATA_16 commands to ATAPI devices
Date: Tue, 02 Jan 2007 19:50:10 -0500
Message-ID: <459AFDC2.6060900@garzik.org>
References: <200701021939.10496.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48199 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476AbXACAuN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Jan 2007 19:50:13 -0500
In-Reply-To: <200701021939.10496.liml@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Mark Lord wrote:
> This patch adds support for passing ATA_16 commands
> through to ATAPI devices in libata.  In practice, the upper layers will
> still currently prevent ATA_16 commands, as no (?) ATAPI drives support
> them yet.  But it will work if such a drive is ever encountered.
> 
> Support for ATA_16 is necessary for using SG_IO from userspace,
> and an upcoming hdparm release will be updated to use this interface.
> 
> This version is very similar to the earlier first submission,
> except that ATA_12 is no longer passed through to ATAPI
> because of the conflict it has with the SCSI BLANK opcode.
> 
> Signed-off-by:  Mark Lord <mlord@pobox.com>
> 
> --- old/drivers/ata/libata-scsi.c	2007-01-02 19:20:23.000000000 -0500
> +++ new/drivers/ata/libata-scsi.c	2007-01-02 19:20:49.000000000 -0500
> @@ -2650,6 +2650,12 @@
>  
>  static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
>  {
> +	if (cmd == ATA_16)
> +		return ata_scsi_pass_thru;
> +
> +	if (dev->class == ATA_DEV_ATAPI)
> +		return atapi_xlat;
> +

As I said, provide some avenue for the user to choose.

I do not wish to completely eliminate the current behavior, which passes 
through all opcodes to the ATAPI device.  You cannot guarantee that 
ATA_16 is never used for a vendor-reserved opcode, for example.

Your proposed change to the default behavior is ACK'd, as long as the 
current behavior is not completely eliminated, as you have done above.

	Jeff



