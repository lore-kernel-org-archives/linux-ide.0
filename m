From: maximilian attems <max@stro.at>
Subject: Re: [PATCH] AHCI: add Dell PowerEdge SC430 pci id
Date: Fri, 9 May 2008 01:46:17 +0200
Message-ID: <20080508234617.GI27599@baikonur.stro.at>
References: <1210279228-14521-1-git-send-email-max@stro.at> <20080508233435.GA15377@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:59331 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933470AbYEIASj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 May 2008 20:18:39 -0400
Content-Disposition: inline
In-Reply-To: <20080508233435.GA15377@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Fri, May 09, 2008 at 12:34:35AM +0100, Matthew Garrett wrote:
> On Thu, May 08, 2008 at 10:40:28PM +0200, maximilian attems wrote:
> > ATA chipset on Dell PowerEdge SC430 is identified as:
> > 00:1f.2 IDE interface [0101]: Intel Corporation 82801GB/GR/GH (ICH7
> > Family) Serial ATA Storage Controller IDE [8086:27c0] (rev 01)
> > 
> > Kernel load the ahci driver with NCQ support after I added it's
> > device IDs into ahci.c.
> 
> Please don't do that. The BIOS has programmed the chip into IDE mode, 
> not AHCI mode. It seems to have also set up the AHCI BAR, but the 
> majority of chips with this ID won't have been and so the ahci driver 
> will fail with them. If the chip was in AHCI mode, the device ID would 
> automatically have changed to 0x27c1.

thanks for the info.
