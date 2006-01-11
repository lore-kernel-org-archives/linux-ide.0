From: Oliver Weihe <o.weihe@deltacomputer.de>
Subject: additional PCI device ID for the sata_svw driver
Date: Wed, 11 Jan 2006 19:23:35 +0100 (CET)
Message-ID: <1716960.1137003815347.SLOX.WebMail.wwwrun@exchange.deltacomputer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:54518 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751711AbWAKSbm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Jan 2006 13:31:42 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello,

please add the following device ID into the sata_svw driver:

[root@localhost ~]# lspci -d 1166:024b
01:0e.0 IDE interface: Broadcom: Unknown device 024b
01:0e.1 IDE interface: Broadcom: Unknown device 024b

Broadcom (Serverworks) HT2000/HT1000 chipset

I've _MINIMALLY_ tested it with a vanilla 2.6.15 (x86_64) and it seems
to work
(created some partitions and filesystems, wrote and read some files).

Regards,
  Oliver Weihe

