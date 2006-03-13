From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 4/4] libata: make per-dev transfer mode limits per-dev
Date: Mon, 13 Mar 2006 18:33:39 +0900
Message-ID: <20060313093339.GC2091@htj.dyndns.org>
References: <11421469561848-git-send-email-htejun@gmail.com> <44152DB1.1020502@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.194]:47034 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932394AbWCMJdo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 04:33:44 -0500
Received: by zproxy.gmail.com with SMTP id 14so1241188nzn
        for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 01:33:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <44152DB1.1020502@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

On Mon, Mar 13, 2006 at 03:30:41AM -0500, Jeff Garzik wrote:
> Tejun Heo wrote:
> >Now that each ata_device has xfer masks, per-dev limits can be made
> >per-dev instead of per-port.  Make per-dev limits per-dev.
> >
> >Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> Doesn't this patch break stuff?  As you said in a previous patch, the 
> per-dev masks aren't used yet?
> 

No, it doesn't break stuff.  per-dev masks are applied in
ata_dev_xfermask().

@@ -2667,6 +2670,8 @@ static unsigned int ata_dev_xfermask(str
 		struct ata_device *d = &ap->device[i];
 		if (!ata_dev_present(d))
 			continue;
+		xfer_mask &= ata_pack_xfermask(d->pio_mask, d->mwdma_mask,
+					       d->udma_mask);
 		xfer_mask &= ata_id_xfermask(d->id);
 		if (ata_dma_blacklisted(d))
 			xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);

-- 
tejun
