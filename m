From: Tomasz Koziara <toko@os.pl>
Subject: dvd reading error
Date: Sun, 7 Nov 2004 15:06:47 +0000
Message-ID: <20041107150647.59c650ae.toko@os.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:62945 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261637AbUKGQLd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Nov 2004 11:11:33 -0500
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1CQpdc-000729-00
	for <linux-ide@vger.kernel.org>; Sun, 07 Nov 2004 17:11:32 +0100
Received: from 62.254.189.226 ([62.254.189.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 07 Nov 2004 17:11:32 +0100
Received: from toko by 62.254.189.226 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 07 Nov 2004 17:11:32 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

Specs:
os: gentoo
kernel: 2.6.9
drive: MATSHITADVD-RAM UJ-812

I am getting the following errors when trying
to play/read dvd media:

Buffer I/O error on device hdc, logical block 1670
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x50
ide: failed opcode was 100
end_request: I/O error, dev hdc, sector 668

IDE related kernel config:
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y

I will sincerely appreciate any hints on how to get by.

Best Regards,
Tomek

