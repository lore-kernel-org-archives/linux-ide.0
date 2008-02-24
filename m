From: Tejun Heo <htejun@gmail.com>
Subject: Re: new ata_port_operations for .pmp_{read,write} ?
Date: Sun, 24 Feb 2008 16:03:48 +0900
Message-ID: <47C116D4.1090600@gmail.com>
References: <4730E312.3090900@navy.mil> <4737C16E.3070607@gmail.com> <4738827D.9060405@pobox.com> <4738F935.1000708@gmail.com> <47BC798F.6070900@pobox.com> <47BE17CA.6060406@rtr.ca> <47BE1833.9090501@rtr.ca> <47BE2C0C.3020801@gmail.com> <47BE2DBD.9010704@rtr.ca> <47BE2F9E.5040206@gmail.com> <47BE32B5.5020300@rtr.ca> <47BE3325.8060209@rtr.ca> <47BE4701.2030104@rtr.ca> <47BE4DFE.2030407@rtr.ca> <47BEDAF2.8000301@rtr.ca> <47BFAC06.5030805@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:25205 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbYBXHDz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Feb 2008 02:03:55 -0500
Received: by rv-out-0910.google.com with SMTP id k20so673848rvb.1
        for <linux-ide@vger.kernel.org>; Sat, 23 Feb 2008 23:03:54 -0800 (PST)
In-Reply-To: <47BFAC06.5030805@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>, Jeff Garzik <jgarzik@pobox.com>

Hello, Mark.

Mark Lord wrote:
> Mark Lord wrote:
>> An alternative to all this, might be to expose the "select_pmp()"
>> function shown in the sample code, and have libata-pmp.c call that,
>> instead of having the new new .pmp_{read,write} functions. 
> ..
> 
> I wonder if this might be more viable than first thought.
> 
> Say the LLD, be it ata_piix or sata_mv or sata_svw, were to provide
> an option ata_operations method for "select_pmp_port(pmp)",
> which the core could invoke prior to any direct manipulation
> of the shadow registers.

I don't really think that's a good solution.  That's the quickest
solution for sata_mv but it just works around more fundamental problem
of assuming SFF behavior in core layer which we need to drop anyway.

> I really would like to keep the LLD code small, and have good solid
> core routines for non-hardware specific functionality.  All of this stuff
> I'm beginning to do with sata_mv would be trivial if I wanted to bloat
> the LLD, but really.. only a tiny bit of it need be custom to sata_mv.
> 
> The existing SFF reset/probe/pmp stuff is just about exactly what
> sata_mv needs.. and I feel a strong desire to not clone/duplicate
> that hard-won functionality.

I strongly agree but am having difficult time agreeing with the proposed
approach.

> Much of it I can see being shared with other half-and-half chipset drivers
> as we add PMP functionality to those.

Do we have other chips which have PMP support but still uses mixed SFF
interface?

> Maybe that's just the embedded side me showing through?
> 
> It is tricky to define the right interfaces, though, as each chipset
> does throw its own unique curve balls at us.

Yeah, exactly.  I think what needs to be done is to separate out SFF
assumptions from core layer, factor out SFF-proper helpers and use them
to implement LLDs for quasi-SFF controllers.

Thanks.

-- 
tejun
