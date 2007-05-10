From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: add human-readable error value decoding
Date: Thu, 10 May 2007 11:43:09 +0200
Message-ID: <4642E92D.5010509@gmail.com>
References: <46428103.3040003@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:64999 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643AbXEJJn0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 May 2007 05:43:26 -0400
Received: by nz-out-0506.google.com with SMTP id o1so515689nzf
        for <linux-ide@vger.kernel.org>; Thu, 10 May 2007 02:43:25 -0700 (PDT)
In-Reply-To: <46428103.3040003@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>

Robert Hancock wrote:
> This adds human-readable decoding of the ATA status and error registers
> (similar
> to what drivers/ide does) as well as the SATA Serror register to libata
> error
> handling output. This prevents the need to pore through standards documents
> to figure out the meaning of the bits in these registers when looking at
> error
> reports. Some bits that drivers/ide decoded are not decoded here, since
> the bits
> are either command-dependent or obsolete, and properly parsing them
> would add
> too much complexity.
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>
> 
> --- linux-2.6.21.1/drivers/ata/libata-eh.c    2007-04-27
> 15:49:26.000000000 -0600
> +++ linux-2.6.21.1edit/drivers/ata/libata-eh.c    2007-05-09
> 19:47:53.000000000 -0600
> @@ -1523,6 +1523,27 @@ static void ata_eh_report(struct ata_por
>             ata_port_printk(ap, KERN_ERR, "(%s)\n", desc);
>     }
> 
> +    if (ehc->i.serror)
> +        ata_port_printk(ap, KERN_ERR,
> +          "SError: {%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s}\n",
> +          ehc->i.serror & SERR_DATA_RECOVERED ? "RecovDataErr " : "",
> +          ehc->i.serror & SERR_COMM_RECOVERED ? "RecovCommErr " : "",
> +          ehc->i.serror & SERR_DATA ? "UnrecovDataErr " : "",
> +          ehc->i.serror & SERR_PERSISTENT ? "PersistErr " : "",
> +          ehc->i.serror & SERR_PROTOCOL ? "ProtocolErr " : "",
> +          ehc->i.serror & SERR_INTERNAL ? "HostInternalErr " : "",
> +          ehc->i.serror & SERR_PHYRDY_CHG ? "PHYRdyChg " : "",
> +          ehc->i.serror & SERR_PHY_INT_ERR ? "PHYInternalErr " : "",
> +          ehc->i.serror & SERR_COMM_WAKE ? "CommWake " : "",
> +          ehc->i.serror & SERR_10B_8B_ERR ? "10B8BErr " : "",
> +          ehc->i.serror & SERR_DISPARITY ? "Disparity " : "",
> +          ehc->i.serror & SERR_CRC ? "CRCErr " : "",
> +          ehc->i.serror & SERR_HANDSHAKE ? "HandshakeErr " : "",
> +          ehc->i.serror & SERR_LINK_SEQ_ERR ? "LinkSeqErr " : "",
> +          ehc->i.serror & SERR_TRANS_ST_ERROR ? "TransStatTransErr " : "",
> +          ehc->i.serror & SERR_UNRECOG_FIS ? "UnrecogFIS " : "",
> +          ehc->i.serror & SERR_DEV_XCHG ? "DevExchanged " : "" );

I'm not really convinced whether this is necessary.  The human readable
form is also a bit cryptic and can get quite long.  So, mild NACK from me.

-- 
tejun
