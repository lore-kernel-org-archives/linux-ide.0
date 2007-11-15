From: Michael Tokarev <mjt@tls.msk.ru>
Subject: sata_nv on MCP51: NCQ possible?
Date: Thu, 15 Nov 2007 12:00:33 +0300
Message-ID: <473C0AB1.8050907@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hobbit.corpit.ru ([81.13.94.6]:22366 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753344AbXKOJAf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Nov 2007 04:00:35 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

While trying to test NCQ thing again, I come across
a problem, it seems: the only hardware available for
testing to me right now is an ASUS M2NPV-VM motherboard,
which is based on Nvidia nForce 430/GeForce 6150.
lspci shows this:

 00:0f.0 IDE interface: nVidia Corporation MCP51 Serial ATA Controller (rev a1)

I see no command queuing enabled by linux (queue depth: 0/32),
and there's no way to enable it in sysfs, either.

Looking at sources (sata_nv.c), it seems this chipset is
marked as "GENERIC" with no ADMA/NCQ support - at least
in 2.6.23 kernel.

Does this chipset support ADMA/NCQ (just not supported in
the driver), or am I out of luck with this testing?

Thanks.

/mjt
