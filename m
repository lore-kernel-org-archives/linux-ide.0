From: MikeW <mw_phil@yahoo.co.uk>
Subject: Re: libata-core.c: =?utf-8?b?YXRhX2ZpbGxfc2coKQ==?= ... SATA AHCI
Date: Wed, 8 Aug 2007 11:17:43 +0000 (UTC)
Message-ID: <loom.20070808T131038-725@post.gmane.org>
References: <loom.20070807T172323-813@post.gmane.org> <20070807180714.25b1a8c1@the-village.bc.nu> <loom.20070808T110804-590@post.gmane.org> <20070808110218.601fbda3@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:55792 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbXHHLSE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Aug 2007 07:18:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IIjY6-0000j0-EC
	for linux-ide@vger.kernel.org; Wed, 08 Aug 2007 13:17:58 +0200
Received: from 57.66.65.38 ([57.66.65.38])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 08 Aug 2007 13:17:58 +0200
Received: from mw_phil by 57.66.65.38 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 08 Aug 2007 13:17:58 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Alan Cox <alan <at> lxorguk.ukuu.org.uk> writes:

>
> SFF 8038i covers the standard taskfile IDE class PCI device interface for
> PIO and DMA. It also covers the alternate ADMA interface.
>
>> Since DMA controller details may vary according to hardware, I
>> would have expected that ata_fill_sg() would be one of the overloadable
>> function entries with a driver-specific function that knew about
>> the DMA controller niceties, and how to stuff a sg entry.
>
> It is not directly however but by overloading qc_prep. That makes more
> sense than overloading fill_sg as not all controllers fit a simple
> SFF like scatter/gather list model in the first place.
>
> Alan
> -

I note also that Intel's Serial ATA AHCI spec has a 22-bit DMA byte count
in the PRDT, so 0 == 64k cannot be assumed here either.

Cheers,
MikeW

