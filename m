From: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Subject: ATIIXP support (SATA, ATA133)
Date: Fri, 17 Dec 2004 11:01:05 +0100
Message-ID: <878y7x2qhq.fsf@kosh.ultra.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lana.hrz.tu-chemnitz.de ([134.109.132.3]:30419 "EHLO
	lana.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S262058AbULQKBH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Dec 2004 05:01:07 -0500
Received: from ultra.csn.tu-chemnitz.de ([134.109.116.202] helo=mail.ultra.csn.tu-chemnitz.de)
	by lana.hrz.tu-chemnitz.de with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CfEv4-0004Sp-OW
	for linux-ide@vger.kernel.org; Fri, 17 Dec 2004 11:01:06 +0100
Received: from kosh.ultra.csn.tu-chemnitz.de ([192.168.5.2])
	by mail.ultra.csn.tu-chemnitz.de (8.13.1/8.12.11) with ESMTP id iBHA15m3022662
	for <linux-ide@vger.kernel.org>; Fri, 17 Dec 2004 11:01:05 +0100
Received: from kosh.ultra.csn.tu-chemnitz.de (localhost [127.0.0.1])
	by kosh.ultra.csn.tu-chemnitz.de (8.13.1/8.12.10) with ESMTP id iBHA15TM025906
	for <linux-ide@vger.kernel.org>; Fri, 17 Dec 2004 11:01:05 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

are there plans to support newer ATI IXP chipsets? I mean:

* PCI 1002:4376 which is an ATA133 controller; this should probably work
  with the already existing drivers/ide/pci/atiixp.c driver

* PCI 1002:4379 which is a SATA controller; I verified that it works
  with the drivers/ide/pci/atiixp.c driver of 2.6.9 also.

* PCI 1002:436E and 1002:437A which are both SATA controller. I saw them
  in the windoze driver file only and can not tell whether they work
  with atiixp.c


Although at least one SATA chipset works with the IDE driver, an own
driver using libata would be the better solution. Does there exist
already something which can be tested?



Enrico
