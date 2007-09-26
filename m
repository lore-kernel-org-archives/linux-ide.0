From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Chipset selection for NCQ md RAID
Date: Wed, 26 Sep 2007 01:03:37 -0400
Message-ID: <76366b180709252203t6cb790c8lc3d71b4f56670061@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:38467 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbXIZFDi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Sep 2007 01:03:38 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1907349rvb
        for <linux-ide@vger.kernel.org>; Tue, 25 Sep 2007 22:03:38 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Given the current kernel (2.6.22.8), which SATA chipset would you feel
most comfortable plugging in to achieve:

- 16 1TB Hitachi 7K1000 drives
- NCQ support
- Kernel md RAID (ie hardware RAID not necessary)
- Max transfer rate to OS (PCIe should handle 16 drives given their
current transfer rate?)

(Assuming the required number of chips of any chipset could be made
available on the bus.)
If support for SiI chips is the most robust, would multiple
SiI3124/SiI3132 chips be most reliable? Or is support for something
like a Marvell 88SX6081 good enough so that only 2 chips are needed?.
I have not owned any of these chips, and my impression is that the SiI
chips have some of the most robust support. The comments at the top of
sata_mv.c scare me, even if they might be out of date... :)

What about port multiplier support? Do they ever introduce stability
problems with the drivers?

Is native libata support for high-density Areca cards planned? Does
anyone know if the manufacturer driver is good enough to rely on for
the above config to "just work"? I'd personally like to stay within
libata. (Comments from any Areca Linux users with an ARC-1261ML?
http://www.areca.com.tw/products/pcie341.htm)

Thanks in advance, -Andrew
