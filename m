From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: [PATCH 0/4] drivers/ata: add another IRQ calls
Date: Tue, 16 Jan 2007 19:45:58 +0900
Message-ID: <200701161045.l0GAjnux029094@toshiba.co.jp>
Mime-Version: 1.0
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imx12.toshiba.co.jp ([61.202.160.132]:61875 "EHLO
	imx12.toshiba.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbXAPKpx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Jan 2007 05:45:53 -0500
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id l0GAjpUC011645
	for <linux-ide@vger.kernel.org>; Tue, 16 Jan 2007 19:45:51 +0900 (JST)
Received: (from root@localhost)
	by wall11.toshiba.co.jp  id l0GAjp11024674
	for linux-ide@vger.kernel.org; Tue, 16 Jan 2007 19:45:51 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id l0GAjoFq021530
	for <linux-ide@vger.kernel.org>; Tue, 16 Jan 2007 19:45:50 +0900 (JST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp, benh@kernel.crashing.org, arnd@arndb.de, paulus@samba.org, linas@austin.ibm.com, jeff@garzik.org, alan@lxorguk.ukuu.org.uk

Dear everyone.

This is the patchset (based on 2.6.20-rc4) for PATA controller
of Celleb. Now, I add two IRQ calls (irq_on, irq_ack) in
ata_port_operations. If these calls are not defined, ata_irq_on()
and ata_irq_ack() are used. Using them, the size of pata_scc.c
is reduced considerably.

I think the abstraction level of these calls are more acceptable
as libata I/F than low-level taskfile accessors.
Please give me any comments.

Best regards,
Akira Iguchi
