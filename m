From: Bryan Fink <bfink@eventmonitor.com>
Subject: Re: gigabyte iRam not seen by linux
Date: Wed, 15 Mar 2006 14:34:45 -0500
Message-ID: <44186C55.5060702@eventmonitor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rs27.luxsci.com ([66.216.127.24]:25537 "EHLO rs27.luxsci.com")
	by vger.kernel.org with ESMTP id S1750910AbWCOTeH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Mar 2006 14:34:07 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, pegasus@nerv.eu.org, htejun@gmail.com, edmudama@gmail.com, albertcc@tw.ibm.com

> The patch at the tail of this mail makes ata_dev_try_classify() ignore
> diagnostic code in FEATURE.  If the iRam successfully gets attached
> with the patch, can you please post 'hdparm -I /dev/sdX' and 'hdparm
> --Istdout /dev/sdX' of the iRam?  
> 
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -477,7 +477,7 @@ ata_dev_try_classify(struct ata_port *ap
>  	else if ((device == 0) && (err == 0x81))
>  		/* do nothing */ ;
>  	else
> -		return ATA_DEV_NONE;
> +		/*return ATA_DEV_NONE*/;
>  
>  	/* determine if device is ATA or ATAPI */
>  	class = ata_dev_classify(&tf);


Hi, I'm having the same trouble with this card as everyone else. I'm 
wondering if anyone would care to comment about what the above patch may 
break.  Is it going to disable safeguards, such that if a disk in my 
system actually does crash, I won't know it?  Or, is it simply going to 
mean that I should be careful to only plug things into the system that I 
know are supported?

I'm in contact with Gigabyte, trying to get their opinion on the 
matter.  I know others have said that they are very unhelpful when it 
comes to linux support, but I'm hoping that if we can show them what's 
wrong, they could roll up a fix in a firmware release.

-Bryan

