From: Bastiaan Jacques <b.jacques@planet.nl>
Subject: ahci: ahci_host_intr() problem(s)?
Date: Sat, 15 Apr 2006 18:59:45 +0200
Message-ID: <200604151859.46130.b.jacques@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from psmtp02.wxs.nl ([195.121.247.11]:40370 "EHLO psmtp02.wxs.nl")
	by vger.kernel.org with ESMTP id S1030291AbWDOQ7f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Apr 2006 12:59:35 -0400
Received: from [192.168.2.10] (ip56538861.direct-adsl.nl [86.83.136.97])
 by psmtp02.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.02 (built Oct 21 2004))
 with ESMTP id <0IXR009JWWJ3FD@psmtp02.wxs.nl> for linux-ide@vger.kernel.org;
 Sat, 15 Apr 2006 18:59:28 +0200 (MEST)
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,


I was looking at ahci_host_intr() when I noticed something strange: it always 
returns 1. Now, that alone is odd because when a function is successful it 
ordinarily returns 0 (zero).

But more importantly, it is called in ahci_interrupt():

			if (!ahci_host_intr(ap, qc))
				if (ata_ratelimit())
					dev_printk(KERN_WARNING, host_set->dev,
					  "unhandled interrupt on port %u\n",
					  i);

So that if-statement is always false; this seems like a logic error to me.

Back to ahci_host_intr itself. it does:

	serr = readl(port_mmio + PORT_SCR_ERR);
	writel(serr, port_mmio + PORT_SCR_ERR);

This looks like first we are reading a value from the port, and then writing 
the same value back without modification. Why?

I would like to fix the first problem described above, but I don't understand 
what this function does.. so perhaps someone who has a greater understanding 
of this code should post a patch. Or explain what it should do :)

---
Bastiaan
