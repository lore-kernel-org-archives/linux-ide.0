From: Vincent Legoll <vincent.legoll@hp.com>
Subject: ATAPI DVD not detected
Date: Wed, 21 Feb 2007 19:05:42 +0100
Message-ID: <200702211905.42115.vincent.legoll@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from palrel13.hp.com ([156.153.255.238]:36802 "EHLO palrel13.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422751AbXBUSUi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Feb 2007 13:20:38 -0500
Received: from vlegoll.emea.hpqcorp.net (vlegoll.emea.hpqcorp.net [16.16.149.243])
	by palrel13.hp.com (Postfix) with ESMTP id 2484E347D0
	for <linux-ide@vger.kernel.org>; Wed, 21 Feb 2007 10:07:24 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

A friend of mine has bought a laptop that has a DVD RAM (Matshita UJ-850S)
that is not detected by libata (ata_piix) unless it has booted on a cdrom
inserted in that drive.

A strange thing is that the drive is listed in the BIOS as being slave on
channel 1, with no master. Whereas the HD is master on channel 0 with no
slave connected.

He had no problem installing ubuntu with a cdrom, but after install, when
booting from the HD, the BIOS is probably not initializing the controller
(ICH7) the same way and the DVDRAM is not detected by libata. I tried with
different kernels, 2.6.17-11 (ubuntu current) 2.6.20 (built manually) or even
the 2.6.15-23 that was the one used for installation. Nothing in dmesg, Just
the standard line for the PATA channel.

Should I log a bug on http://bugzilla.kernel.org to track that issue or 
nothing can be done with such broken HW setups / BIOSes ?

I'll get bootlogs and .configs available if needed.

-- 
Vincent Legoll
