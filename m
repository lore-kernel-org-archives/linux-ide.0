From: Kim Roland Rasmussen <kim.rasmussen@cebitec.uni-bielefeld.de>
Subject: Problems with Promise SATAII TX4
Date: Wed, 30 Mar 2005 02:10:08 +0200
Message-ID: <20050330001007.GA16954@cebitec.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sauron.cebitec.uni-bielefeld.de ([129.70.160.28]:19840 "EHLO
	smtp-relay.CeBiTec.Uni-Bielefeld.DE") by vger.kernel.org with ESMTP
	id S261678AbVC3AKO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Mar 2005 19:10:14 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp-relay.CeBiTec.Uni-Bielefeld.DE (Postfix) with ESMTP id 2B137423
	for <linux-ide@vger.kernel.org>; Wed, 30 Mar 2005 02:10:10 +0200 (MEST)
Received: from smtp-relay.CeBiTec.Uni-Bielefeld.DE ([127.0.0.1])
 by localhost (sauron [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 22923-04-8 for <linux-ide@vger.kernel.org>;
 Wed, 30 Mar 2005 02:10:09 +0200 (MEST)
Received: from sif.valhalla (pD9FF95B1.dip.t-dialin.net [217.255.149.177])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-relay.CeBiTec.Uni-Bielefeld.DE (Postfix) with ESMTP id B2416421
	for <linux-ide@vger.kernel.org>; Wed, 30 Mar 2005 02:10:08 +0200 (MEST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all,

Together with a couple of others I have been bitten by problems with the
Promise SATAII TX4 controller.

Common to all is that at some point the kernel log contains the "irq
<SOME NUMBER>: nobody cared!" error message, followed by a call/stack
trace. This is quickly followed up by a "Disabling IRQ #<SOME NUMBER>"
which effectively kills the SATA controller and access to the disks.

Although a somewhat unusual request, could I ask somebody to look at
this

    http://forums.gentoo.org/viewtopic-p-2247734.html

developing thread in the Gentoo Forums. There's simply to much
information there to repost here.

In my case (posted under <rasmussen>) I temporarily seem to have gotten
around it by replacing a driver with another of a different brand.
However, this is not the case for others.

Any idea of what's going on? To me it looks like some interrupt isn't
cleared or something like that (but I'm just guessing).

Cheers,
  Kim

