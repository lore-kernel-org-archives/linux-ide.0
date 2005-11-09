From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH/RFC 3/3] libata: check qc->err_mask for the internal commands
Date: Wed, 09 Nov 2005 01:31:24 -0500
Message-ID: <437197BC.4090101@pobox.com>
References: <437181D5.8070903@tw.ibm.com> <43718523.1000408@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:51935 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030428AbVKIGb2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Nov 2005 01:31:28 -0500
In-Reply-To: <43718523.1000408@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

Albert Lee wrote:
> Patch 3/3:
>   check qc->err_mask for the internal commands.
> 
> Problem:
>   The results of internal commands issued by libata itself were not checked.
> 
>   For example, ata_dev_identify() only checks the device status (qc->tf.command).
>   However, checking the device status is not enough to detect all errors.
> 
> Changes:
>   - check qc->err_mask for the internal commands:
>     - ata_dev_identify()
>     - ata_dev_set_xfermode()
>     - ata_dev_reread_id()
>     - ata_dev_init_params() 
>     - atapi_request_sense()
> 
> The patch accesses qc (and ap) after the qc is completed.
> This is bad from the object life cycle point of view and might cause race.
> However, since libata has complete control over the hardware when libata issues the internal commands
> and it seems noboby else may issue command at the same time, 
> accessing qc after ata_qc_complete() looks to be ok here.
> 
> p.s. 
>      The patch above can also make ata_dev_identify() detect the
>      "phantom slave device" problem.
> 
>      The "phantom slave device" was seen in specific PATA master-only configuration.
>      The master device responds to some commands issued to the slave device, and
>      make a illusion that the slave device exists.
>      The device status register of the "phantom slave device" always read as zero.
>      So, using (qc->tf.command & ATA_ERR) cannot detect the error.
>      Checking qc->err_mask can make ata_dev_identify() detect such 
>      "phantom slave device" and exclude the phantom device.
> 
> For your review and advice, thanks.
> 
> Albert
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com> 

In general this seems like an OK direction to take, but I am a bit 
worried about the object lifetime issues that you mention.  It is IMO 
worth considering a better lifetime strategy at this point, before 
applying this [worthwhile] change.

	Jeff


