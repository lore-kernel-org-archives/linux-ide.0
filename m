From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] amd74xx: don't configure udma mode higher than BIOS did
Date: Mon, 05 Feb 2007 23:07:58 +0900
Message-ID: <45C73A3E.6080700@gmail.com>
References: <20070205075836.GG1625@htj.dyndns.org>	<20070205112410.5a3c3182@localhost.localdomain>	<45C72012.7050605@gmail.com> <20070205132247.6f611e3c@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.227]:48501 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932588AbXBEOID (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 09:08:03 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1612987nze
        for <linux-ide@vger.kernel.org>; Mon, 05 Feb 2007 06:08:03 -0800 (PST)
In-Reply-To: <20070205132247.6f611e3c@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

Alan wrote:
> You get whatever the chip has loaded. The BIOS may pick PIO modes only,

In that case, the code does NOT apply.  All the code does is applying at
most UDMA33 limit if BIOS has configured && enabled UDMA mode.

> the BIOS may not have been run so the UDMA bits could be arbitary. You
> may even get wrongly capped values.

First of all, in 99% of cases, the BIOS has run and if the BIOS hasn't
run, the register is most likely to contain reset values which wouldn't
trigger the limit and even if the limit is wrongly triggered, the worst
that happens is limiting transfer speed to udma33.

> Also another case you broke is kexec.

1. If kexec is done while either of amd74xx or pata_amd is loaded, the
currently configured mode is what the kexeced kernel would use as
reference.  If the port has been slowed down during operation, yeah, it
would be sub-optimal but again the worst can happen is udma33.

2. If kexec is done after pata_amd is unloaded, pata_amd restored the
BIOS value on unload.  Should be identical to clean boot.

>> So, I think the benefit (correct configuration on most machines) easily
>> outweighs the danger (incorrectly capping speed to working udma33 on
>> non-PC).
> 
> Yours is the first complaint I've seen about this hardware detection in
> *THREE* years. Its a bigger problem with libata but thats because of the
> drive side detect and also because currently we work on the basis in
> libata that host side detect defines cable, while old ide (when behaving
> and correctly working) works on the basis that if the host says 80wire and
> the drive says 40 wire (or vice versa) then its 40.

CK804 IDE, at least mine, reports 80c in a lot of cases where it
shouldn't.  I dunno the reason but it also makes drives confused about
cable type.  Maybe it has the wrong capacitor attached or something.
This is A8N-E from ASUS, probably one of the popular ones using nf4.

When that happens, libata EH does its job and slows the interface to
udma33 after quite a few error messages.  On IDE, if this happens, the
drive is put into PIO mode making the machine painful to use.

I dunno why this is the first report in three years.  I might have a
defective board but I don't think that's the case as BIOS gets it right
everytime.

Googling...  I'm listing a few which seem similar.

  http://search.luky.org/linux-kernel.2005/msg30919.html
  http://www.centos.org/modules/newbb/viewtopic.php?topic_id=4662
  http://blog.gmane.org/gmane.linux.bios/month=20060601/page=6

When this type of errors occur, people try to swap cables, swap
positions and some of those combinations would probably work and the
problem would be considered solved.  I mean, really, very little of bugs
actually get reported to relevant people.

Please keep in mind that no one has reported driver side detection is
wrong in all these years even when in some cases we just assume 80c on
host side and depended on driver side detection (amd74xx UDMA66
controllers), but I'm pretty sure it has caused some griefs out in the wild.

I agree with you that this is a hack and ugly as hell.  I don't like it
either, but it solves an existing problem which could have and possibly
will hit many users.  So, I think this problem should at least be
verified.  If it's just my BIOS/motherboard that's crazy, I have no
problem forgetting about this.

So, anyone with CK804 (a.k.a NF4) up for some testing?

-- 
tejun
