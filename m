From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: [PATCHSET] libata: PATA driver
	for Celleb
Date: Fri, 26 Jan 2007 16:24:46 +0900
Message-ID: <200701260724.l0Q7OISY027645@toshiba.co.jp>
Mime-Version: 1.0
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imx12.toshiba.co.jp ([61.202.160.132]:32830 "EHLO
	imx12.toshiba.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030719AbXAZHYW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Jan 2007 02:24:22 -0500
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id l0Q7OJNg018438
	for <linux-ide@vger.kernel.org>; Fri, 26 Jan 2007 16:24:19 +0900 (JST)
Received: (from root@localhost)
	by wall11.toshiba.co.jp  id l0Q7OJCl028595
	for linux-ide@vger.kernel.org; Fri, 26 Jan 2007 16:24:19 +0900 (JST)
Received: from mx11.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id l0Q7OIKF010891
	for <linux-ide@vger.kernel.org>; Fri, 26 Jan 2007 16:24:18 +0900 (JST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp, benh@kernel.crashing.org, arnd@arndb.de, paulus@samba.org, linas@austin.ibm.com, jeff@garzik.org, alan@lxorguk.ukuu.org.uk

Dear everyone.

Thank you for many useful comments.
This is the latest patchset for the PATA controller of Celleb. 

This patchset consists of
[1] add another IRQ calls (core and headers)
[2] add another IRQ calls (libata drivers)
[3] PATA driver for Celleb

And patch[3] depends on patch[1,2].

This patchset is based on the Tejun's "devres" git tree, which is
available at the followin URL.

http://htj.dyndns.org/git/?p=libata-tj.git;a=commit;h=efc6607aefe728b2721f6a0126bc527bc23eb46f


Best regards,
Akira Iguchi

