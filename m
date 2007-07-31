From: Bob Ham <rah@bash.sh>
Subject: hpt374 sata (Highpoint Rocket 1540)
Date: Tue, 31 Jul 2007 12:08:44 +0100
Message-ID: <1185880124.3483.25.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from waffl.ing.me.uk ([217.147.94.6]:33116 "EHLO waffl.ing.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751822AbXGaMKj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Jul 2007 08:10:39 -0400
Received: from localhost ([127.0.0.1] helo=teasel.arb.net)
	by waffl.ing.me.uk with esmtp (Exim 4.60 #1 )
	id 1IFpkI-0000GO-Mq
	for <linux-ide@vger.kernel.org>; Tue, 31 Jul 2007 12:18:34 +0100
Received: from localhost
	([127.0.0.1] helo=larkspur.bristol-cyps.org.uk ident=bccl)
	by teasel.arb.net with esmtp (Exim 4.63)
	(envelope-from <rah@bash.sh>)
	id 1IFpan-0005dk-Aw
	for linux-ide@vger.kernel.org; Tue, 31 Jul 2007 12:08:45 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi there,

I've had a Highpoint Rocket 1540 (not "RocketRAID") SATA controller for
a while now, using a proprietary binary driver from Highpoint in a linux
2.4 kernel.  The chipset is an hpt374.  The hpt366 driver freezes on
boot, as reported by others.  There are rumours[0][1] of a SATA driver
for the hpt372N/302N chips using libata.  In 2.6.22, there are PATA
drivers for hpt3xx, but no SATA.

[0] http://linuxmafia.com/faq/Hardware/sata.html#highpoint
[1] http://lkml.org/lkml/2006/1/3/211

I'm wondering if there are or will be libata drivers, or any drivers for
that matter, for hpt374-based SATA cards?

Cheers,

Bob Ham


