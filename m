From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] resolve collision of generic ATA_FLAG_LOWTAG and driver
 specific flag
Date: Mon, 13 Apr 2015 11:29:17 -0400
Message-ID: <20150413152917.GE2596@htj.duckdns.org>
References: <201504092009.08703.ronny.hegewald@online.de>
 <20150410111516.GA15230@infradead.org>
 <5528007D.1080703@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35316 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932101AbbDMP3U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Apr 2015 11:29:20 -0400
Received: by qkhg7 with SMTP id g7so185531123qkh.2
        for <linux-ide@vger.kernel.org>; Mon, 13 Apr 2015 08:29:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5528007D.1080703@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Christoph Hellwig <hch@infradead.org>, Ronny Hegewald <ronny.hegewald@online.de>, linux-ide@vger.kernel.org

On Fri, Apr 10, 2015 at 07:55:25PM +0300, Sergei Shtylyov wrote:
> >>-	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 24), /* IRQ loss errata on PCI-X */
> >>+	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 25), /* IRQ loss errata on PCI-X */
> 
>    This one also collides with ATA_FLAG_SAS_HOST.
> 
> >And this will clash as soon as the next flag is added.  Please don't
> >abuse the common flag space for driver specific ones, and add a separate
> >flags field for driver specific flags.
> 
>    Actually, bits 24-31 are reserved for the low-level driver usage (see the
> comment below ATA_FLAG_*), so it's the new ATA_FLAG_LOWTAG and
> ATA_FLAG_SAS_HOST that have violated the convention and should be moved
> (there's plenty of lower bits due to the removal of some obsolete flags).

Yeah, this something dumb I did way back.  Can we please add a
separate field for per-controller flags in port_info and all related
structs so that we don't do this sharing?

Thanks.

-- 
tejun
