From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] AHCI: add Dell PowerEdge SC430 pci id
Date: Fri, 9 May 2008 00:34:35 +0100
Message-ID: <20080508233435.GA15377@srcf.ucam.org>
References: <1210279228-14521-1-git-send-email-max@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mjg.x.mythic-beasts.com ([93.93.128.6]:54376 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754201AbYEHXey (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 May 2008 19:34:54 -0400
Content-Disposition: inline
In-Reply-To: <1210279228-14521-1-git-send-email-max@stro.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: maximilian attems <max@stro.at>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Thu, May 08, 2008 at 10:40:28PM +0200, maximilian attems wrote:
> ATA chipset on Dell PowerEdge SC430 is identified as:
> 00:1f.2 IDE interface [0101]: Intel Corporation 82801GB/GR/GH (ICH7
> Family) Serial ATA Storage Controller IDE [8086:27c0] (rev 01)
> 
> Kernel load the ahci driver with NCQ support after I added it's
> device IDs into ahci.c.

Please don't do that. The BIOS has programmed the chip into IDE mode, 
not AHCI mode. It seems to have also set up the AHCI BAR, but the 
majority of chips with this ID won't have been and so the ahci driver 
will fail with them. If the chip was in AHCI mode, the device ID would 
automatically have changed to 0x27c1.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
