From: Catalin BOIE <util@deuroconsult.ro>
Subject: SATA bus freeze with 2.4.21, sii3112A and Intel mb 7505vb, with
 max_kb_per_request 15 (fwd)
Date: Fri, 20 Jun 2003 09:52:12 +0300 (EEST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.53.0306200950070.31152@hosting.rdsbv.ro>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from webhosting.rdsbv.ro ([213.157.185.164]:31112 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S262409AbTFTGiM
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Jun 2003 02:38:12 -0400
Received: from hosting.rdsbv.ro (hosting.rdsbv.ro [213.157.185.164])
	by hosting.rdsbv.ro (8.12.9/8.12.9) with ESMTP id h5K6qCK2001920
	for <linux-ide@vger.kernel.org>; Fri, 20 Jun 2003 09:52:12 +0300
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi!

Motherboard is:
http://www.intel.com/design/servers/SE7505VB2/index.htm?iid=ipp_srvr+mthrbds_se7505VB2_srvr&

Controller is sii3112a

I activated the trick with max_kb_per_request
Kernel 2.4.21 doesn't enable UDMA on the channels.
If I enable DMA (hdparm) the computer ALMOST freeze (hdparm doesn't exit).
I can switch the consoles but with a 5 sec delay.
But, seems that the bus freeze. No activity even after 2 minutes.
I had to reboot.

I tested more and I achived 55MB/s with udma2 and DMA without to freeze.
Why I cannot set udma6 on sii? Maximum that I can set is udma2.

Any ideas?
Thanks!

---
Catalin(ux) BOIE
catab@deuroconsult.ro
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
