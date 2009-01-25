From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [BUG] 2.6.29-rc1: ata_piix boot hang due to bmdma32 change
Date: Sun, 25 Jan 2009 11:23:10 +0100
Message-ID: <18812.15758.77573.752769@harpo.it.uu.se>
References: <200901150842.n0F8gpZb014365@harpo.it.uu.se>
	<18805.35930.588019.518198@harpo.it.uu.se>
	<497BBA46.3000605@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:57990 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903AbZAYKXd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 25 Jan 2009 05:23:33 -0500
In-Reply-To: <497BBA46.3000605@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo writes:
 > Hello,
 > 
 > Mikael Pettersson wrote:
 > > The problem is still present in 2.6.29-rc2.
 > > 
 > > More debugging first showed that only the specific machine mentioned
 > > above is affected, as I've tested -rc1 on several other ata_piix boxes
 > > with various oldish disks and cdroms and none of the others triggered
 > > the hang.
 > > 
 > > Secondly, the hang is due to the HP CD-Writer drive as having only it
 > > on the second port suffices to produce the hang. It doesn't matter if
 > > it's configured as master or slave.
 > > 
 > > In any event, this shows that using 32-bit I/O ops should also be a
 > > function of the drive you're talking to, not just the controller.
 > 
 > If you connect the writer to another machine, does it make the machine
 > hang too?

I haven't tried it since that machine is at a different geographical
location from my other machines. But I can try it next weekend.

My hang goes away with Hugh Dickins' fix for ata_sff_data_xfer32 [1]
which fixed a CD-ROM error (not hang) on his ata_piix box, and his
patch also fixed a CD-ROM error on a another person's pata_ali box [2].

The patch changes ata_sff_data_xfer32 to use 16-bit PIO instead of 32-bit
on any 1/2/3 byte "slop" after the main payload. But Alan thinks that
AMD chipsets cannot handle that [3]. (One of my test boxes is an old
AMD-chipset Athlon, I can test both my problematic CD-writer and the
possibly AMD-incompatible fix on it next weekend.)

[1] <http://marc.info/?l=linux-kernel&m=123254501314058&w=2>
[2] <http://marc.info/?l=linux-ide&m=123277213928172&w=2>
[3] <http://marc.info/?l=linux-kernel&m=123257958112434&w=2>

/Mikael
