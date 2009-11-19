From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 4/5] pata: Update experimental tags
Date: Thu, 19 Nov 2009 16:48:26 -0500
Message-ID: <4B05BD2A.5070706@pobox.com>
References: <20091117144450.15430.83450.stgit@localhost.localdomain> <200911191645.29885.bzolnier@gmail.com> <20091119162738.7e8e5665@lxorguk.ukuu.org.uk> <200911191838.11791.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34943 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753655AbZKSVs3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Nov 2009 16:48:29 -0500
In-Reply-To: <200911191838.11791.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 11/19/2009 12:38 PM, Bartlomiej Zolnierkiewicz wrote:
>
> Index: b/drivers/ata/pata_hpt3x2n.c
> ===================================================================
> --- a/drivers/ata/pata_hpt3x2n.c
> +++ b/drivers/ata/pata_hpt3x2n.c
> @@ -133,7 +133,7 @@ static int hpt3x2n_cable_detect(struct a
>   	/* Restore state */
>   	pci_write_config_byte(pdev, 0x5B, scr2);
>
> -	if (ata66&  (1<<  ap->port_no))
> +	if (ata66&  (2>>  ap->port_no))
>   		return ATA_CBL_PATA40;
>   	else
>   		return ATA_CBL_PATA80;


Applied.

Note to Alan -- even if cable detect wants more changes, this is a nice, 
self-contained fix easily backported to stable@, etc.  So I preferred 
the above form of change.

Please do send any updates you guys (Bart | Alan) have on top of 
libata-dev.git#upstream.

Thanks,

	Jeff



