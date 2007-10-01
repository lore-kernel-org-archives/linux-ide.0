From: Chuck Ebbert <cebbert@redhat.com>
Subject: sata_nv in 2.6.23-rc8 only detects one of two controllers
Date: Mon, 01 Oct 2007 17:39:09 -0400
Message-ID: <470168FD.8080605@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:39771 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757072AbXJAVjL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Oct 2007 17:39:11 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l91LdAo9021001
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Mon, 1 Oct 2007 17:39:10 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l91Ld9Lt007341
	for <linux-ide@vger.kernel.org>; Mon, 1 Oct 2007 17:39:10 -0400
Received: from [172.16.83.145] (dhcp83-145.boston.redhat.com [172.16.83.145])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id l91Ld9TW011909
	for <linux-ide@vger.kernel.org>; Mon, 1 Oct 2007 17:39:09 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

2.6.18:
libata version 2.00 loaded.
sata_nv 0000:00:07.0: version 2.0
ACPI: PCI Interrupt Link [LTID] enabled at IRQ 20
GSI 18 sharing vector 0xE9 and IRQ 18
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LTID] -> GSI 20 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata1: SATA max UDMA/133 cmd 0xB400 ctl 0xB002 bmdma 0xA400 irq 233
ata2: SATA max UDMA/133 cmd 0xAC00 ctl 0xA802 bmdma 0xA408 irq 233
scsi0 : sata_nv
...
ACPI: PCI Interrupt Link [LT3D] enabled at IRQ 47
GSI 19 sharing vector 0x32 and IRQ 19
ACPI: PCI Interrupt 0000:80:07.0[A] -> Link [LT3D] -> GSI 47 (level, low) -> IRQ 50
PCI: Setting latency timer of device 0000:80:07.0 to 64
ata5: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xD400 irq 50
ata6: SATA max UDMA/133 cmd 0xDC00 ctl 0xD802 bmdma 0xD408 irq 50


2.6.23-rc8:
libata version 2.21 loaded.
sata_nv 0000:00:07.0: version 3.5
ACPI: PCI Interrupt Link [LTID] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LTID] -> GSI 22 (level, low) -> IRQ 22
sata_nv 0000:00:07.0: Using ADMA mode
PCI: Setting latency timer of device 0000:00:07.0 to 64
scsi1 : sata_nv
...
[No messages print for the second controller]


https://bugzilla.redhat.com/show_bug.cgi?id=313491
