From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.20-rc3-mm1 2/2] libata: SiS 180 pata/sata support
Date: Mon, 8 Jan 2007 12:51:16 +0000
Message-ID: <20070108125116.015da28f@localhost.localdomain>
References: <45A19F67.6050909@garzik.org>
	<20070108102809.512b4409@localhost.localdomain>
	<45A22E9F.1050607@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48868 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161271AbXAHMku (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Jan 2007 07:40:50 -0500
In-Reply-To: <45A22E9F.1050607@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Uwe Koziolek <uwe.koziolek@gmx.net>, "linux.ide" <linux-ide@vger.kernel.org>, Sven Ladegast <sven@linux4geeks.de>

> It is /very/ bad policy to force the user to load a driver that drives 
> real hardware, just to be able to access a few functions.  Hardware and 
> probe side effects are a very real possibility, and with this setup, the 

No they are not.

> user has /less/ control than normal over things such as load order when 
> pata_sis is loaded as a dependency.

Where did I put the 2x4

Right....

* Whack * ;)

The only probing the SiS driver does is for devices matching the SiS PCI
identifiers in question. Since they are intergrated bridges it's actually
physically impossible to obtain a box which contains both at once

* Whack * ;)

If it was added as a library then the non library driver would look
contain only a call to register the pci driver and a PCI table. The other
7.5K would be waste space. That also means there is no load order issue.

* Whack * ;)

Now if this was an ISA driver or poked around in ugly places your
argument would make sense. In this case I don't think your argument makes
sense, but if you want a pointless tiny pata_sis module to waste memory
on everyones boxes you can just ask and I'll send you a diff or two.

Alan
