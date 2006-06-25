From: Tejun Heo <htejun@gmail.com>
Subject: [ANNOUNCE] libata: new EH, NCQ, hotplug and Power Management patches against v2.6.17
Date: Sun, 25 Jun 2006 16:30:03 +0900
Message-ID: <20060625073003.GA21435@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0102.google.com ([72.14.214.203]:8559 "EHLO
	hu-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751418AbWFYH3u (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 25 Jun 2006 03:29:50 -0400
Received: by hu-out-0102.google.com with SMTP id 23so526305huc
        for <linux-ide@vger.kernel.org>; Sun, 25 Jun 2006 00:29:49 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, all.

libata-tj-stable patches against v2.6.17 and v2.6.17.1 are available.

* New Power Management added
* Port Multiplier support is dropped for the time being

The patches add the following features to v2.6.17.

* New error handling
* IRQ driven PIO (from Albert Lee)
* SATA NCQ support
* Hotplug support
* New PM (Power Management)

The following drivers support new features.

ahci:		new EH, irq-pio, hotplug, NCQ
ata_piix:	new EH, irq-pio, warmplug (HW restriction), PM
sata_nv:	new EH, irq-pio, hotplug
sata_sil:	new EH, irq-pio, hotplug, PM
sata_sil24:	new EH, irq-pio, hotplug, PM, NCQ
sata_sis:	new EH, irq-pio, warmplug, EXPERIMENTAL
sata_svw:	new EH, irq-pio, warmplug, EXPERIMENTAL
sata_uli:	new EH, irq-pio, warmplug, EXPERIMENTAL
sata_via:	new EH, irq-pio, warmplug, EXPERIMENTAL
sata_vsc:	new EH, irq-pio, warmplug, EXPERIMENTAL

More info can be found at the following URL.

 http://home-tj.org/wiki/index.php/Libata-tj-stable

Patches against v2.6.17 are avaialbe at the following URL.

 http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17-20060625.tar.bz2

Please read README carefully before trying the patches.

Thanks.

-- 
tejun
