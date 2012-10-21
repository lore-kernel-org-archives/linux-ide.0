From: Tom Rini <tom.rini@gmail.com>
Subject: BUG: 65fe1f0 (ahci: implement aggressive SATA...) fail to boot
Date: Sun, 21 Oct 2012 10:57:17 -0700
Message-ID: <20121021175717.GA3543@bill-the-cat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56648 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932374Ab2JUR5W (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Oct 2012 13:57:22 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1485357pbb.19
        for <linux-ide@vger.kernel.org>; Sun, 21 Oct 2012 10:57:22 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shane Huang <shane.huang@amd.com>, linux-ide@vger.kernel.org
Cc: Aaron Lu <aaron.lwe@gmail.com>, Jeff Garzik <jgarzik@redhat.com>

Hello,

I've got an Asus motherboard with:
00:11.0 SATA controller: Advanced Micro Devices [AMD] nee ATI
SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] (rev 40)
...
02:00.0 SCSI storage controller: OCZ Technology Group, Inc. RevoDrive 3
X2 PCI-Express SSD 240 GB (Marvell Controller) (rev 02)

And with 65fe1f0 merged I no longer see all devices on the RevoDrive.
Happy to provide whatever further information might be helpful.

-- 
Tom
