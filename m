From: sean <seandarcy2@gmail.com>
Subject: Re: ahci or ata-piix for ich6?
Date: Sat, 30 Apr 2005 21:12:23 -0400
Message-ID: <d51a2h$h1f$1@sea.gmane.org>
References: <d502d3$sl8$1@sea.gmane.org> <20050430171827.GA14203@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:65245 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261506AbVEABtb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Apr 2005 21:49:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DS3TA-0007rv-5r
	for linux-ide@vger.kernel.org; Sun, 01 May 2005 03:42:04 +0200
Received: from ool-4356fcdd.dyn.optonline.net ([67.86.252.221])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 01 May 2005 03:42:04 +0200
Received: from seandarcy2 by ool-4356fcdd.dyn.optonline.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 01 May 2005 03:42:04 +0200
In-Reply-To: <20050430171827.GA14203@tuxdriver.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

John W. Linville wrote:
> On Sat, Apr 30, 2005 at 09:55:17AM -0400, sean wrote:
> 
>>I have a mobo with the 915G, 82801FB/FBW (ICH6/ICH6W) SATA 
>>controller. Which SATA driver in 2.6.12-rc3?
> 
> 
> If you configured AHCI in the BIOS, then ahci should work.  Otherwise
> ata_piix is the choice.  In fact, for ICH6 ata_piix is smart enough
> to disable AHCI on its own, if it gets loaded.  So, ata_piix is the
> safe choice (ignoring any issues favoring AHCI).
> 
> For those observing, the reason this is an issue is because Intel
> used the same PCI ID for ICH6 in either IDE or AHCI mode.  So, there
> is no obvious choice for kudzu and the like to make.
> 
> John

Aha!  I don't have ( or least can't find ) any ahci option 
in my bios for the gigabyte GA-8i915g board. I've asked on 
the alt gigabyte newgroup.

thanks

sean

