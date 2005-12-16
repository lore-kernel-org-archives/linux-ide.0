From: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: PATCH: libata - oldpiix driver
Date: Fri, 16 Dec 2005 21:59:55 +0100
Message-ID: <20051216205955.GA21669@electric-eye.fr.zoreil.com>
References: <1134053330.17102.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:37002 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1750823AbVLPVBJ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Dec 2005 16:01:09 -0500
Content-Disposition: inline
In-Reply-To: <1134053330.17102.28.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> :
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-mm2/drivers/scsi/pata_oldpiix.c linux-2.6.14-mm2/drivers/scsi/pata_oldpiix.c
> --- linux.vanilla-2.6.14-mm2/drivers/scsi/pata_oldpiix.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.14-mm2/drivers/scsi/pata_oldpiix.c	2005-12-07 17:26:37.000000000 +0000
[...]
> +static int oldpiix_qc_issue_prot(struct ata_queued_cmd *qc)
> +{
[...]
> +		if(adev->dma_mode)
> +			oldpiix_set_dmamode(ap, adev);
> +		else
> +			oldpiix_set_dmamode(ap, adev);

Where is the difference ?

--
Ueimor
