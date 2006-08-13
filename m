From: Martin Michlmayr <tbm@cyrius.com>
Subject: amd74xx: Unknown symbol pci_get_legacy_ide_irq on ARM
Date: Sun, 13 Aug 2006 22:00:18 +0200
Message-ID: <20060813200018.GA22511@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:44816 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1751396AbWHMUAd
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 Aug 2006 16:00:33 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On ARM, I get the following error when I load the amd74xx module:

    Unknown symbol pci_get_legacy_ide_irq

This driver is the only driver which makes use of
pci_get_legacy_ide_irq.  Can someone update it?  Alternatively,
Kconfig should probably be updated so the driver cannot be seletected
on some architectures (at least ARM, possibly others).
-- 
Martin Michlmayr
http://www.cyrius.com/
