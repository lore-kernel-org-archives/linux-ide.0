From: Marco Trevisan <trevisan@ost.it>
Subject: sata_via broken?
Date: Mon, 15 Dec 2003 19:12:46 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <3FDDF99E.1080107@ost.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [212.103.193.198] ([212.103.193.198]:23046 "EHLO mail.ost.lan")
	by vger.kernel.org with ESMTP id S263886AbTLOSLY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Dec 2003 13:11:24 -0500
Received: from localhost (mail-cvs [127.0.0.1])
	by mail.ost.lan (Postfix) with ESMTP id E754A2C354
	for <linux-ide@vger.kernel.org>; Mon, 15 Dec 2003 19:11:22 +0100 (CET)
Received: from ost.it (nb-marco.ost.lan [10.2.1.92])
	by mail.ost.lan (Postfix) with ESMTP id CC6042C34C
	for <linux-ide@vger.kernel.org>; Mon, 15 Dec 2003 19:11:13 +0100 (CET)
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>

Hello all,

I'm experiencing problems in having the vt8237 S-ATA controller working
properly on my board (MSI KT6-Delta).
I'm running 2.6.0-test11-bk10 (distro: Debian 'testing').
After browsing the list archive, I found something about this problem
(threads: "SATA and 2.6.0-test9"and "Linux 2.6.0-test9"), but no solution...
I then surfed the net and it seems that there is a patch for 2.4.22
kernels (I don't know wether it works or not).

So my questions are:
1) is this issue to be resolved shortly in 2.6.0-testX ?
2) Which SATA PCI controller is known to work properly under 2.6.0-test11 ?

The machine is currently under testing, so I can try experimental
patches if it can help the process.

Thanks in advance for any reply.

     Marco Trevisan



