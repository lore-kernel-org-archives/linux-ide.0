From: Tejun Heo <htejun@gmail.com>
Subject: [ANNOUNCE] libata-tj-stable against v2.6.17.4 available
Date: Sat, 8 Jul 2006 21:32:42 +0900
Message-ID: <20060708123242.GE2592@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0102.google.com ([72.14.214.195]:7486 "EHLO
	hu-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964812AbWGHMbu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 08:31:50 -0400
Received: by hu-out-0102.google.com with SMTP id 23so1804897huc
        for <linux-ide@vger.kernel.org>; Sat, 08 Jul 2006 05:31:49 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, all.

libata-tj-stable patches against v2.6.17.4 are available.

* Hotplug-by-polling added
* Port Multiplier support added back (sil3726 support added)

The patches add the following features to v2.6.17.4.

* New error handling
* IRQ driven PIO (from Albert Lee)
* SATA NCQ support
* Hotplug support
* New PM (Power Management)
* Hotplug-by-poll
* Port Multiplier support

The following drivers support new features.

ahci:		new EH, irq-pio, hotplug, NCQ
ata_piix:	new EH, irq-pio, warmplug (HW restriction), PM
sata_nv:	new EH, irq-pio, hotplug
sata_sil:	new EH, irq-pio, hotplug, PM
sata_sil24:	new EH, irq-pio, hotplug, PM, NCQ, PMP
sata_sis:	new EH, irq-pio, hotplug-poll, EXPERIMENTAL
sata_svw:	new EH, irq-pio, hotplug-poll, EXPERIMENTAL
sata_uli:	new EH, irq-pio, hotplug-poll, EXPERIMENTAL
sata_via:	new EH, irq-pio, warmplug, EXPERIMENTAL
sata_vsc:	new EH, irq-pio, hotplug-poll, EXPERIMENTAL

More info can be found at the following URL.

 http://home-tj.org/wiki/index.php/Libata-tj-stable

Patches against v2.6.17.4 are avaialbe at the following URL.

 http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17.4-20060708.tar.bz2

Please read README carefully before trying the patches.

Thanks.

-- 
tejun
