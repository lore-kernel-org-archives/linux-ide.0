From: David Lloyd <dmlloyd@tds.net>
Subject: sata_promise and SATA+PATA controllers in general
Date: Sun, 18 Sep 2005 17:21:44 -0500 (CDT)
Message-ID: <Pine.LNX.4.62.0509181644210.10435@ultros>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound4.mail.tds.net ([216.170.230.94]:33722 "EHLO
	outbound4.mail.tds.net") by vger.kernel.org with ESMTP
	id S932224AbVIRWUd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 18 Sep 2005 18:20:33 -0400
Received: from outaamta02.mail.tds.net (outaamta02.mail.tds.net [216.170.230.32])
	by outbound4.mail.tds.net (8.13.4/8.12.2) with ESMTP id j8IMKWBR010306
	for <linux-ide@vger.kernel.org>; Sun, 18 Sep 2005 17:20:32 -0500 (CDT)
Received: from localhost ([216.165.178.90]) by outaamta02.mail.tds.net
          with ESMTP
          id <20050918222032.ZZRH30338.outaamta02.mail.tds.net@localhost>
          for <linux-ide@vger.kernel.org>; Sun, 18 Sep 2005 17:20:32 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I've got one of those promise controllers with 2 SATA ports and 1 PATA 
port and I've been looking at a couple variations on how the driver has 
been made to work with this setup.

Gentoo has a patch (against 2.6.10) that allows this to work (as far as I 
can tell) by putting an if statement in each operation that is different 
between PATA and SATA, and making the decision at runtime on how to handle 
each port.

This patch does not apply against 2.6.14-rc1 for various reasons.  The 
2.6.14-rc1 driver has separate ata_port_operations structures for PATA and 
SATA; however, since only one can be used at a time, my promise controller 
(PDC20378) as well as any other SATA+PATA controller that follows this 
structure cannot use the PATA port.  I hacked around this by simply using 
the PATA structure exclusively (obviously making my SATA ports useless) to 
allow me to boot, but it got me to thinking.

A while back (almost a year ago, in fact) Jeff Garzik posted a message [1] 
stating that the two things that need to be done to support these types of 
controllers are to add support for multiple ata_port_operations structures 
to both ata_probe_ent and ata_host_set.

I noticed that the sata_promise driver does in fact have separate port_ops 
for pata and sata, but since each controller only supports one of these, 
SATA+PATA controllers are still not fully functional in mainline.

Is this still the right direction to go?

Does this mean have e.g. a pata_port_ops member as well as a sata_port_ops 
member on the ata_probe_ent/ata_host_set, and mark each port as being 
either PATA or SATA with a flag of some sort?  Or, would it be best to 
have a port_ops pointer per port?

[1] http://marc.theaimsgroup.com/?l=linux-ide&m=109606830029825&w=2

- D
