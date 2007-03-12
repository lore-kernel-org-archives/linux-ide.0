From: Tejun Heo <htejun@gmail.com>
Subject: regarding ACPI support in 2.6.21
Date: Mon, 12 Mar 2007 23:32:44 +0900
Message-ID: <45F5648C.7020506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello, all.

Currently, libata-acpi has the following problems.

1. Matching controller/device to ACPI node.  It currently uses ap->cbl
== ATA_CBL_SATA test to choose between two formats - the traditional ATA
nodes with master/slave devices and new native SATA nodes.  This is
incorrect as ata_piix even if it's SATA should map to traditional ATA
nodes while in ahci 00 _ADR in traditional format shouldn't trigger
"don't know how to handle SATA port multiplier".

2. Although this isn't very clear in the spec, but some methods seem to
be designed to be used only over suspend/resume cycle.  SATA aware
methods (w/ _SDD) should probably called after every PHY event (device
might have been hardreset), but _GTM/_STM/_GTF combination does look
like they should be used only over suspend/resume cycles.  This is caus

I think it might be better to give up ACPI support in 2.6.21 and target
2.6.22.  What do you think?

Thanks.

-- 
tejun
