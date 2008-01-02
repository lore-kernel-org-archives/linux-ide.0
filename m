From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: PIIX driver
Date: Wed, 2 Jan 2008 14:43:35 +0100
Message-ID: <18299.38151.404709.517068@harpo.it.uu.se>
References: <477B82E1.4070209@probil.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:50272 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753796AbYABNnm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Jan 2008 08:43:42 -0500
In-Reply-To: <477B82E1.4070209@probil.ee>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kalev.toots@probil.ee
Cc: linux-ide@vger.kernel.org

Kalev Toots writes:
 > Hello
 > 
 > For specific reason I need to install old FC4 ( kernel 2.6.11 ) to new 
 > hardware ( Intel DP35DP motherboard ).
 > Installation failed and the reason I think is that FC4 ata-piix driver 
 > don't have ICH9 support.
 > Is it possible to port new ata-piix driver ( from kernel 2.6.23 ) to  
 > old kernel.

Sounds like you're running the chip in compatibility mode.
Maybe flip BIOS settings to AHCI mode and let FC4's kernel
use its ahci driver instead?

Backporting the entire driver would be painful. Perhaps
adding some PCI IDs suffices? (I have no idea how much ICH9
differs from whatever FC4 supports.)

I don't know if you need FC4 kernel or FC4 user-space, but
one option is to install on an older supported machine, move
the disk to the new one, and then boot a custom kernel.

Finally you can buy a PCI PATA, SATA, or SCSI controller card
supported by FC4 and forget about the mainboard's ICH9.
