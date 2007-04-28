From: "Berck E. Nash" <flyboy@gmail.com>
Subject: Re: libata Intel PIIX/ICH fails to detect both PATA drives, spews
 ACPI errors
Date: Sat, 28 Apr 2007 10:20:16 -0600
Message-ID: <46337440.9040509@gmail.com>
References: <45705618.2020608@gmail.com> <45E447DD.9050308@gmail.com> <45F3F8AA.4060501@gmail.com> <45F4FCA3.1080301@gmail.com> <45F54147.1060509@gmail.com> <45F546C0.1030502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:10979 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756373AbXD1QUX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Apr 2007 12:20:23 -0400
Received: by py-out-1112.google.com with SMTP id a29so1034992pyi
        for <linux-ide@vger.kernel.org>; Sat, 28 Apr 2007 09:20:23 -0700 (PDT)
In-Reply-To: <45F546C0.1030502@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
>>>>> Berck E. Nash wrote:
>>>>>> Testing the new libata ICH PATA drivers.  There's one PATA port on this
>>>>>> chip, and I've got two optical drives connected to it.  The master drive
>>>>>> fails to detect.  The slave detects and works properly.
>>>>> Can you test 2.6.20.1 and post full dmesg?
>>>> Here's 2.6.20.2...  No ACPI errors, but still doesn't detect both drives.
>>> Please apply the attached patch and see if it works.  If it works,
>>> please post the result of hdparm -I /dev/srX of the optical drive.  Thanks.

> ------------------------------------------------------------------------
> 
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index dc42ba1..6e7775a 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -105,7 +105,8 @@ enum {
>  	PIIX_FLAG_AHCI		= (1 << 27), /* AHCI possible */
>  	PIIX_FLAG_CHECKINTR	= (1 << 28), /* make sure PCI INTx enabled */
>  
> -	PIIX_PATA_FLAGS		= ATA_FLAG_SLAVE_POSS,
> +	PIIX_PATA_FLAGS		= ATA_FLAG_SLAVE_POSS |
> +				  ATA_FLAG_SETXFER_POLLING,
>  	PIIX_SATA_FLAGS		= ATA_FLAG_SATA | PIIX_FLAG_CHECKINTR,
>  
>  	/* combined mode.  if set, PATA is channel 0.

Since this patch fixes the problem, is there some reason it still hasn't
been included?

Berck
