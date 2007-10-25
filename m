From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 4/4]: [PCI]: Add MSI INTX_DISABLE quirks for ATI
 SB700/800 SATA and IXP SB400 USB
Date: Thu, 25 Oct 2007 00:59:38 -0700 (PDT)
Message-ID: <20071025.005938.104394521.davem@davemloft.net>
References: <20071023.195343.35661973.davem@davemloft.net>
	<5CAB7B5D6F8AB84AA868A46B47A507055D936C@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:43272
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753459AbXJYH7g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 03:59:36 -0400
In-Reply-To: <5CAB7B5D6F8AB84AA868A46B47A507055D936C@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shane.Huang@amd.com
Cc: linux-kernel@vger.kernel.org, jeff@garzik.org, barkalow@iabervon.org, linas@austin.ibm.com, gregkh@suse.de, htejun@gmail.com, brice.goglin@gmail.com, david.gaarenstroom@gmail.com, linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org, brice@myri.com, mchan@broadcom.com

From: "Shane Huang" <Shane.Huang@amd.com>
Date: Wed, 24 Oct 2007 14:43:21 +0800

> This patch and the third one seems can make my SB700 SATA controller
> work under MSI(simply tested on 2.6.23-rc5). 
> 
> So you may withdraw the RS690/RD580/RX790 MSI disablement patches
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commi
> t;h=4be8f906435a6af241821ab5b94b2b12cb7d57d8
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commi
> t;h=aea6a433f50cd89b9cbd10850fd0b32f961f9883
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commi
> t;h=f122392f679ebed39db08074f935d770504623eb
> after the commit of these MSI/INTx quirks.

Thank you for testing!

I will add this change to my patch set.
