From: MikeW <mw_phil@yahoo.co.uk>
Subject: Re: libata-core.c: =?utf-8?b?YXRhX2ZpbGxfc2coKQ==?= ... sanity check on arithmentic ?
Date: Wed, 8 Aug 2007 10:48:41 +0000 (UTC)
Message-ID: <loom.20070808T121526-382@post.gmane.org>
References: <loom.20070807T172323-813@post.gmane.org> <20070807180714.25b1a8c1@the-village.bc.nu> <loom.20070808T110804-590@post.gmane.org> <20070808110218.601fbda3@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:54267 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753673AbXHHKtF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Aug 2007 06:49:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IIj62-0005qg-Qd
	for linux-ide@vger.kernel.org; Wed, 08 Aug 2007 12:48:59 +0200
Received: from 57.66.65.38 ([57.66.65.38])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 08 Aug 2007 12:48:58 +0200
Received: from mw_phil by 57.66.65.38 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 08 Aug 2007 12:48:58 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Alan Cox <alan <at> lxorguk.ukuu.org.uk> writes:

> 
>>> The specification says that 0x0000 means 64K. A couple of controllers do
>>> get this wrong and we did recently add a second sg list builder for those.
>>> 
>>> Perhaps a comment or two is in order ?
>>> -
>> 
>> Thanks - but which specification is this ?
>> 
>> As far as I am aware there is no spec for DMA controllers running ATA.
> 
> SFF 8038i covers the standard taskfile IDE class PCI device interface for
> PIO and DMA. It also covers the alternate ADMA interface.
> 
>> Since DMA controller details may vary according to hardware, I
>> would have expected that ata_fill_sg() would be one of the overloadable
>> function entries with a driver-specific function that knew about
>> the DMA controller niceties, and how to stuff a sg entry.
> 
> It is -n ot directly however but by overloading qc_prep. That makes more
> sense than overloading fill_sg as not all controllers fit a simple
> SFF like scatter/gather list model in the first place.
> 
> Alan
> -

Thanks for clarifying - as you say, the spec is specific to PCI.
Our silicon has its own host interface which was confused by a length of zero !
Overloading qc_prep seems the way to go here.
As you say, some comments may be in order !

Regards,
MikeW


