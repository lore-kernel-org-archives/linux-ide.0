From: Michael Spiegle <mike@nauticaltech.com>
Subject: AHCI driver for ICH6M
Date: Tue, 31 Jan 2006 21:21:29 -0800
Message-ID: <1138771289.15467.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from blue.nauticaltech.com ([64.71.32.16]:31749 "EHLO
	blue.nauticaltech.com") by vger.kernel.org with ESMTP
	id S1030389AbWBAFnX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Feb 2006 00:43:23 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello Jeff,
I was trying to use the AHCI driver included in kernel 2.6.15 to drive
the SATA controller on my Asus Z71V laptop which supposedly has an ICH6M
controller.  I noticed that the PCI ID of my controller shows up in the
AHCI source code, so I assume that means I should have support.  I'm not
terribly good with linux or C, but I think I was able to troubleshoot my
issue down to a specific line of code.  Ultimately, I get the error:

ahci: probe of 0000:00:1f.2 failed with error -12

in my dmesg output.  I was trying to debug the AHCI driver code by
inserting print statements.  I found that the driver stops processing at
this point in the code:

ahci.c:
mmio_base = pci_iomap(pdev, AHCI_PCI_BAR, 0);

Specifically, the pci_iomap function seems to check for
pci_resource_start and pci_resource_len which both return false.
Looking at the code, if either len or start is false, the code returns
NULL, then I get the error observed above in dmesg.

Is this a possible bug, or is AHCI support somehow stripped from my
chipset?

Thank you for your time.  If this is not the proper way to contact you
about issues regarding the driver, I am sorry.  I am very new to these
things.

Michael Spiegle
mike@nauticaltech.com

