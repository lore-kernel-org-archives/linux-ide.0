From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] amd74xx: don't configure udma mode higher than BIOS did
Date: Mon, 05 Feb 2007 23:17:07 +0900
Message-ID: <45C73C63.1090108@gmail.com>
References: <20070205075836.GG1625@htj.dyndns.org>	<20070205112410.5a3c3182@localhost.localdomain>	<45C72012.7050605@gmail.com>	<45C723FF.2060405@gmail.com> <20070205132442.1516678b@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:52767 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932794AbXBEORN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 09:17:13 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1615152nze
        for <linux-ide@vger.kernel.org>; Mon, 05 Feb 2007 06:17:12 -0800 (PST)
In-Reply-To: <20070205132442.1516678b@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

Alan wrote:
>> To prevent that, the value is cached on driver probe and written back on
>> driver detach on pata_amd, which is necessary even when there is no
> 
> Which is useless.

I can agree to 'not always effective' but its useful in common driver
load/unload cases.

>> suspend/resume as mode programming alters the content of the register.
>> amd74xx cannot be unloaded, so caching is enough.  Also, doesn't
>> suspend/resume cycle store and restore PCI space anyway?
> 
> If I load the driver after a kexec or after a suspend/resume cycle both
> of which are quite valid your code breaks.

I wrote about kexec in the other reply.  And about loading after
suspend/resume, yeap, it's outside of saved area, so it'll probably
contain reset or random value.  Again, the worst that happens is
limiting transfer mode to udma33, which, considering the likelihood of
the scenario weighted against the common case, is acceptable, IMHO.

I think the first thing we need to do is verifying this problem.  If
this is a rare problem, let's forget about it.  If it can be easily
reproduced, we need to do something about it one way or the other -
maybe sniffing BIOS mode as I did or maybe different smart trick.

Thanks.

-- 
tejun
