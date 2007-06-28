From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: [PATCH 2.6.22-rc4] libata: SiS180 pata support
Date: Thu, 28 Jun 2007 23:02:49 +0200
Message-ID: <468421F9.8070809@gmx.net>
References: <200706060104.18055.uwe.koziolek@gmx.net> <20070605231912.GW31565@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:34344 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758668AbXF1VCw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Jun 2007 17:02:52 -0400
In-Reply-To: <20070605231912.GW31565@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Nevermind, I did it myself:
> This ensures that we can easily make changes specific to the PATA port
> on the newer SATA chips, and also does what I've been requesting -- use
> the standard ata_bmdma_error_handler(), rather than creating custom code
> that achieves the same effect.
>
>
> diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
> index ec3ae93..0752104 100644
> --- a/drivers/ata/pata_sis.c
> +++ b/drivers/ata/pata_sis.c
>   
Jeff,
Did you have added  the patch you have  mailed on 06.06. anywhere or is
this patch an email only patch. And how to continue?

Uwe
