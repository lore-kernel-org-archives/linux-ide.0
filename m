From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFT] libata hpa support
Date: Wed, 21 Mar 2007 18:50:24 +0000
Message-ID: <20070321185024.31673dd3@lxorguk.ukuu.org.uk>
References: <20070223170625.GA29931@athena.road.mcmartin.ca>
	<20070321130140.GA4328@athena.road.mcmartin.ca>
	<20070321183455.00f4732b@lxorguk.ukuu.org.uk>
	<46016E58.5010509@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56800 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933256AbXCURq4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Mar 2007 13:46:56 -0400
In-Reply-To: <46016E58.5010509@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Kyle McMartin <kyle@canonical.com>, linux-ide@vger.kernel.org, mjg59@ubuntu.com

> That reminds me, there have been suggestions in the past that we should 
> do a security freeze after probing and configuring.

And as has been observed previously from a security perspective there is
no point.

	Break into box
	security freeze - annoying
	Patch boot block to load my disk destroyer
	Reboot

You need to the security freeze in the firmware at boot, or it is the
same whether you do it in kernel or in the initrd or early boot, except
that its pagable code, its configurable and its easier to work with when
it is in user space.

Paranoid people get PCI boot roms that lock their disks.

