From: Jeff Garzik <jgarzik@pobox.com>
Subject: Another libata TODO item
Date: Wed, 24 Aug 2005 02:17:11 -0400
Message-ID: <430C10E7.9060502@pobox.com>
Reply-To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:46223 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751469AbVHXGRU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Aug 2005 02:17:20 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>


Difficulty:  beginner / intermediate

Modern network drivers have a per-NIC list of debugging messages that 
can be enabled/disabled at runtime, implemented as a bitmask named 
'msg_enable' in each driver.  VERY useful for tracing specific events 
during debugging.  grep for 'msg_enable', 'netif_msg_', and 'NETIF_MSG_'.

To make libata debugging easier and more fine-grained, we should convert 
DPRINTK/VPRINTK calls in libata to code that looks like

	if (ata_msg_xxx(ap->msg_enable))
		printk(...)

The task involves:

* reviewing net driver msg_enable usage
* reviewing original netif_msg documentation by Donald Becker, at 
(scroll down)
http://www.scyld.com/pipermail/vortex/2001-November/001426.html

* designing a sliding scale of ever-more-verbose classes of messages, 
for libata and libata drivers
* design a method by which userspace may change the per-port msg_enable 
variable in libata

* implement the sliding scale as ATA_MSG_xxx / ata_msg_xxx()
* add msg_enable to struct ata_port
* implement method of setting ap->msg_enable via userspace
* convert messages in libata-core/libata-scsi
* convert messages in each driver
* add 'debug' module option to each driver, in a manner that duplicates 
net driver module options
* test!


