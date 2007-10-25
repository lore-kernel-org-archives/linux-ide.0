From: "Kalra Ashish-B00888" <ashish.kalra@freescale.com>
Subject: PMP device port link speed issues
Date: Thu, 25 Oct 2007 15:48:16 +0530
Message-ID: <2A6F278C5B66C4459AF4013E77A40CD301003114@zin33exm20.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from de01egw01.freescale.net ([192.88.165.102]:59115 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754264AbXJYKS3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 06:18:29 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l9PAIQCK005919
	for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 03:18:27 -0700 (MST)
Received: from zin33exm20.fsl.freescale.net (zin33exm20.ap.freescale.net [10.232.192.5])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9PAIOhJ002753
	for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 05:18:25 -0500 (CDT)
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Kalra Ashish-B00888 <ashish.kalra@freescale.com>

While testing the "sata_fsl" driver with a Sil3726 based PMP, we had a
specific configuration where the host port to PMP link speed was
1.5Gbps, while the PMP has configured it's device port(s) link speed to
3Gbps. This configuration causes NCQ hangs on certain Seagate drives,
probably because of the link speed difference between host and PMP
device & PMP device ports and drives.
 
Does it makes sense to limit the PMP device port link speeds to the host
port link speed ? 
 
I believe currently sata_pmp_attach() is calling sata_link_init_spd()
for each PMP device port and thus causing PMP device port link speeds
being configured independent of host port link speed. Probably the PMP
device port links should be limited to the host link speed. 
 
Thanks, 
 
Ashish Kalra.
Freescale Semiconductor.
