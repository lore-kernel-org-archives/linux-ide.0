From: Thomas Malt <tm@linpro.no>
Subject: Problem with Promise TX4 and Maxtor Maxline III 250G
Date: Tue, 28 Dec 2004 21:29:57 +0100
Message-ID: <uixsm5qw4hm.fsf@nfsd.linpro.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:4011 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261235AbUL1Ubo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Dec 2004 15:31:44 -0500
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1CjO0N-0008UO-00
	for <linux-ide@vger.kernel.org>; Tue, 28 Dec 2004 21:31:43 +0100
Received: from nfsd.linpro.no ([80.232.36.130])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 28 Dec 2004 21:31:43 +0100
Received: from tm by nfsd.linpro.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 28 Dec 2004 21:31:43 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


A couple of weeks ago I bought a new 'Maxtor Maxline III 250GB'
(Maxtor 7B250S0) to replace a broken disk in my RAID.

My mainboard is an 'Abit NF7-S' (Athlon XP 3000), with a 'SiI 3112'
SATA chipset. In addition I've got a Promise TX4 card attached.

I'm running a vanilla 2.6.9 kernel.

When I have the 'Maxtor 7B250S0' connected to the Promise TX4, my
system hangs _hard_ when I try to write to it. Both when I try to
create a filesystem with mkfs, and when I try to write zeroes with dd.
The hang doesn't occur right away, but after a couple of minutes of
writing. When I try to make an ext3-filesystem it hangs after
approx. 360 inode tables.

When I connect the 'Maxtor 7B250S0' to the 'SiI 3112' I can use the
disk without problem. When I connect a 'WDC 2500JB' to the Promise TX4
I can use that without problem.

Is it possible this is a bug in the sata_promise driver?

Is there any more information I can provide to help find out?

Thomas
--=20
  =ABIf you wanna know how to play the blues: Get yourself a woman!=BB
                                                      -- Danko Jones

