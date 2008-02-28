From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Unknown SATA PIIX PCI device ID 0x29b6
Date: Thu, 28 Feb 2008 23:37:36 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802282306190.10087@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:34300 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751795AbYB1Whg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Feb 2008 17:37:36 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Hi

just found out that the eSATA connector on my Intel DQ35JO motherboard 
doesn't work... because it is connected to the controller with product ID 
29b6... And this ID is not yet handled by the driver. Can I have a patch, 
please?:-) I think the correct entry would be

{ 0x8086, 0x29b6, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },

just because it also has two ports. Am I right? I would rather not test 
blindly.

BTW, why are these 2920, 2926, and 29b6 IDs not handled by the ahci 
driver? The board-manual does say ICH9...

Thanks
Guennadi
---
Guennadi Liakhovetski
