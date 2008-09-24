From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: What's the SB600 64-bit DMA problem?
Date: Wed, 24 Sep 2008 18:19:39 +0800
Message-ID: <B90463BC30D2E446BA423D888DC85E50C8358F@sshaexmb1.amd.com>
References: <20080920151712.10515.qmail@science.horizon.com>	 <da824cf30809201528o27478ae2h5894e39932622d3b@mail.gmail.com>	 <20080921001529.23400.qmail@science.horizon.com> <65a6ef750809231730h52f6bf47g23b33db1d2f4ca08@mail.gmail.com> <48DA0C8B.3000406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-va3.frontbridge.com ([216.32.180.16]:50444 "EHLO
	VA3EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbYIXKTx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Sep 2008 06:19:53 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <48DA0C8B.3000406@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Mark Nelson <mdnelson8@gmail.com>
Cc: George Spelvin <linux@horizon.com>, grundler@google.com, linux-ide@vger.kernel.org, jgarzik@redhat.com, "Huang, Shane" <Shane.Huang@amd.com>

Hi Tejun and Mark,


> -----Original Message-----
> From: Tejun Heo [mailto:htejun@gmail.com] 
> > 
> >>From git commit a878539ef994787c447a98c2e3ba0fe3dad984ec ("ahci:
> > work around ATI SB600 h/w quirk"), it looks like the initial
> > idea was to limit each command to a maximum of 255 sectors (but
> > to still allow 64bit DMA), but according to a later commit
> > (4cde32fc4b32e96a99063af3183acdfd54c563f0; "ahci: SB600
> > workaround is suspect... play it safe for now") this did not
> > solve the lockups. But there are references in the thread above
> > to broken MSI on the SB600 possibly being the cause of the problem,
> > and now that commit 22b5e7a74280deae560c20ee1a9b502b35181327
> > ("ahci: SB600 ahci can't do MSI, blacklist that 
> capability") has gone in
> > maybe this is why you're able to get 64bit DMA working? (although
> > we do need more hints on how to conclusively test this)
> 
> Hmm... I doubt MSI has anything to do with 64bit DMA but then again
> anything is possible.  Shane, anything came out of the testing?


SB600 255 sectors limit and SB600 64 bit DMA bug are two different bugs,
the first one appears on many boards while the latter appears on some of
them
(our reference boards can NOT reproduce it).

As to SB600 SATA MSI bug, since we found that there is such kind of bug,
all our SB600 BIOS for reference boards disabled SATA MSI capability
itself.
(we assume all the SB600 BIOS in the marketing should disable MSI too,
but,
in fact, some did not as you know).

So I'm not able to do the test so far due to the MSI disabled BIOS.
If there is some guy whose SB600 BIOS is enabled, he may do some
verification
for us.

http://marc.info/?l=linux-ide&m=117810966106759&w=2
I remember "pci=nomsi" did not work before the workaround of 32bit SB600
SATA DMA? Tejun, is that true?


Anyway, I suggest we keep current SB600 workarounds.


Thanks
Shane

