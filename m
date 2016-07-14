From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 04/10] ata: add ata_is_fpdma() accessor
Date: Thu, 14 Jul 2016 11:19:13 -0400
Message-ID: <20160714151913.GL15005@htj.duckdns.org>
References: <1468454751-12466-1-git-send-email-hch@lst.de>
 <1468454751-12466-5-git-send-email-hch@lst.de>
 <20160714143756.GF15005@htj.duckdns.org>
 <5787ACA7.9050808@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:34674 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbcGNPTP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jul 2016 11:19:15 -0400
Received: by mail-yw0-f174.google.com with SMTP id i12so75091177ywa.1
        for <linux-ide@vger.kernel.org>; Thu, 14 Jul 2016 08:19:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5787ACA7.9050808@suse.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, damien.lemoal@hgst.com, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>

Hello, Hannes.

On Thu, Jul 14, 2016 at 05:15:51PM +0200, Hannes Reinecke wrote:
> >> +static inline bool ata_is_fpdma(u8 prot)
> >> +{
> >> +	return ata_prot_flags(prot) & ATA_PROT_FLAG_FPDMA;
> >> +}
> > 
> > ???
> > 
> Yeah, strictly speaking there is no need for ATA_PROT_FLAG_FPDMA.
> I'll be removing it if you insist.

No, it's just really confusing to have a function named ata_is_fpdma()
and then have it test whether the protocol is NCQ or DMA.  If you
wanna do that, name it ata_is_dma_or_fpdma().  ata_is_fpdma() should
test (prot & ATA_PROT_FLAG_FPDMA) == ATA_PROT_FLAG_FPDMA.

Thanks.

-- 
tejun
