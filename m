From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [BUG] 2.6.29-rc1: ata_piix boot hang due to bmdma32 change
Date: Sat, 31 Jan 2009 13:20:34 +0100
Message-ID: <18820.16914.326060.763062@harpo.it.uu.se>
References: <200901150842.n0F8gpZb014365@harpo.it.uu.se>
	<18805.35930.588019.518198@harpo.it.uu.se>
	<497BBA46.3000605@kernel.org>
	<18812.15758.77573.752769@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:49292 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558AbZAaMUy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 31 Jan 2009 07:20:54 -0500
In-Reply-To: <18812.15758.77573.752769@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Tejun Heo <tj@kernel.org>, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Mikael Pettersson writes:
 > Tejun Heo writes:
 >  > Hello,
 >  > 
 >  > Mikael Pettersson wrote:
 >  > > The problem is still present in 2.6.29-rc2.
 >  > > 
 >  > > More debugging first showed that only the specific machine mentioned
 >  > > above is affected, as I've tested -rc1 on several other ata_piix boxes
 >  > > with various oldish disks and cdroms and none of the others triggered
 >  > > the hang.
 >  > > 
 >  > > Secondly, the hang is due to the HP CD-Writer drive as having only it
 >  > > on the second port suffices to produce the hang. It doesn't matter if
 >  > > it's configured as master or slave.
 >  > > 
 >  > > In any event, this shows that using 32-bit I/O ops should also be a
 >  > > function of the drive you're talking to, not just the controller.
 >  > 
 >  > If you connect the writer to another machine, does it make the machine
 >  > hang too?
 > 
 > I haven't tried it since that machine is at a different geographical
 > location from my other machines. But I can try it next weekend.

I've now tried this CD-Writer on a couple of other boxes.

AMD756 (1022:7409 rev 03), pata_amd
2.6.29-rc3: hang as init starts udev
rc3 + Hugh's libata-sff patch: no hang and no visible issues,
despite this possibly being out of spec for the AMD IDE controller
rc3 + Hugh's patch + Alan's patch: no hang, all ok

440BX/PIIX4 (8086:7111 rev 01), ata_piix
2.6.29-rc3: hang as init starts udev
rc3 + Hugh's libata-sff patch: all ok

430HX/PIIX3 (8086:7010)
2.6.29-rc3: hang during driver init, immediately after drive was identified
rc3 + Hugh's libata-sff patch: all ok
