From: Tejun Heo <htejun@gmail.com>
Subject: Re: What's needed for PMP support?
Date: Thu, 21 Feb 2008 12:39:59 +0900
Message-ID: <47BCF28F.5080702@gmail.com>
References: <4730E312.3090900@navy.mil> <4737C16E.3070607@gmail.com> <4738827D.9060405@pobox.com> <4738F935.1000708@gmail.com> <47BC798F.6070900@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:24146 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754232AbYBUDkH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Feb 2008 22:40:07 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2109569rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 20 Feb 2008 19:40:04 -0800 (PST)
In-Reply-To: <47BC798F.6070900@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, Mark.

Mark Lord wrote:
> Tejun, I've added PMP to sata_mv, and am now trying to get it
> to work with a Marvell PM attached.
> 
> And the behaviour I see is very bizarre.
> 
> After hard+soft resets, the PM signature is found,
> and libata interrogates the PM registers.
> 
> It successfully reads register 0, and then register 1.
> But all subsequent registers read out (incorrectly) as zeros.

Hmmm...

> I've traced the taskfiles in/out, and it all looks proper
> except for the actual data coming back from the PM.
> 
> After some experimentation, I found that all of the PM registers
> were readable, if I simple inserted a  sata_pmp_read(link, 0, &junk)
> in front of each issue of sata_pmp_read(link, reg, &r_val).

Hmmmmmmm...

> Then the PM is recognized and all, but fails port enumerations
> probably due to either my hack or the same original bug (whatever that is?)
> 
> I'm confused.

That makes two of us.

> The PM itself works fine here on sata_sil24 and AHCI(jmicron),

Yeah, Marvell PMPs behave very nicely with sil24 and ahci.

> so it's obviously the sata_mv driver or chipset that's being weird.
> 
> Ever seen anything like this before?

No.

> I'm trying to use stock libata functions for all of this 	where possible,
> so there's not really that much new/necessary code in sata_mv for this.
> I do force the PMP value for outgoing-FIS's (non standard register for it),
> but that's about all that's custom here.
> 
> The driver uses ATA register mode emulation for all commands
> other than READ/WRITE disk stuff, including for the PM register accesses.
> 
> Ever seen anything like this before?

No but I had my fair share of problems doing PMP support for both sil24
and ahci.  Any chance you can get access to a bus analyzer?  I had a
very weird problem w/ ahci PMP support which I don't think I could fix
if I didn't have access to a bus analyzer at the time.  (I don't
remember details now tho.)

-- 
tejun
