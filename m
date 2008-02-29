From: Tejun Heo <htejun@gmail.com>
Subject: Re: devres and requesting resources
Date: Fri, 29 Feb 2008 23:17:58 +0900
Message-ID: <47C81416.1010305@gmail.com>
References: <47C75392.3020606@garzik.org>	<20080229112651.5b2a7f6f@core>	<47C7F664.5040102@garzik.org>	<47C7FA8B.7040306@gmail.com> <20080229140106.41ccc843@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:36937 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887AbYB2OSW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Feb 2008 09:18:22 -0500
Received: by wf-out-1314.google.com with SMTP id 28so4019310wff.4
        for <linux-ide@vger.kernel.org>; Fri, 29 Feb 2008 06:18:20 -0800 (PST)
In-Reply-To: <20080229140106.41ccc843@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Linux IDE mailing list <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Alan Cox wrote:
>> controller like ICH AHCIs.  ata_generic or ide generic might attach to a
>> controller which is already being driven by ahci under certain
>> configurations.
> 
> ata_generic will not nor ata_legacy both are much too smart for that. The
> legacy old IDE driver might but that probably isn't going to be fixed by
> devres and is trivial to fix in that driver (just steal the code from
> pata_legacy).

Yeah, I saw the behavior with ahci + ide generic combination.  I think
it was on SB600.  Heh... neat trick in pata_legacy().  Hmm... it's
probably better to do at generic device level and with a generic helper.

>> have different requirements can just open code pci_request_regions() and
>> pcim_iomap().  pcim_request_regions() should provide sensible default
>> behavior for common cases.
> 
> Which is arguably the current behaviour. Changing the behaviour and not
> the name is a really bad idea and will cause problems in future so don't
> do that.
>> I think the best solution is to allow duplicate request regions for
>> managed devices which is okay as we know we're holding the resource and
>> let drivers which need to reserve all regions call pci_request_regions()
>> before calling pcim_request_regions().
> 
> How about
> 
> 	pcim_request_all_regions()
> 
> for the behaviour Jeff wants, simple, direct, differently named and
> obvious what it does.

Sounds good to me.  Jeff?

-- 
tejun
