From: Marc Bevand <bevand_m@epita.fr>
Subject: Generic bug/race in the IDE/SATA code ?
Date: Mon, 4 Oct 2004 09:10:27 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <cjr423$kjk$1@sea.gmane.org>
References: <m34qm13m8h.fsf@zathras.nivin.org> <41473287.7050101@epita.fr> <20040914191851.A7263@florence.linkmargin.com> <20040915090212.GA3493@hwi.epita.fr> <20040915080812.A7683@florence.linkmargin.com> <20040915134543.GA23786@iah.epita.fr>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:47284 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267863AbUJDJKj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Oct 2004 05:10:39 -0400
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1CEOra-0005aF-00
	for <linux-ide@vger.kernel.org>; Mon, 04 Oct 2004 11:10:34 +0200
Received: from ivry-1-81-57-179-18.fbx.proxad.net ([81.57.179.18])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 04 Oct 2004 11:10:34 +0200
Received: from bevand_m by ivry-1-81-57-179-18.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 04 Oct 2004 11:10:34 +0200
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On 2004-09-15, Marc Bevand <bevand_m@epita.fr> wrote:
|  What the hell could be the problem on Paul's system and mine ?
|  Both of us have a Tyan motherboard (but not the same model).

I realize our problem is very similar to this one (excerpt from
linux-x86_64 release notes):

  Reports that dual Tyan S2885 and S2880 can lock up when multiple IDE channels
  are stressed in parallel. "noapic" or "ideFOO=serialize" seems to work
  around it. Andre Hedrick thinks it's a generic bug/race in the IDE code.

(appart the fact we are stressing SATA channels, and that "noapic"
does not work around the problem for me).

I have done an interesting experiment: conduct the exact same test
under another OS, FreeBSD/amd64 (5.2.1, SMP kernel). The result is
that it works perfectly: the Promise card outputs data at the
continuous rate of 210 MB/s and the system never locks up even after
25min of activity (while it takes about 30sec to happen under Linux).

So is this a generic bug/race in the Linux IDE/SATA code ?

-- 
Marc Bevand                          http://www.epita.fr/~bevand_m
Computer Science School EPITA - System, Network and Security Dept.

