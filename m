From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 3/4]: [PCI]: Add quirk for devices which disable MSI
 when INTX_DISABLE is set.
Date: Tue, 23 Oct 2007 22:33:15 -0700 (PDT)
Message-ID: <20071023.223315.10295721.davem@davemloft.net>
References: <20071023.195310.131105752.davem@davemloft.net>
	<1193203821.8788.4.camel@concordia>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:34887
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754851AbXJXFdb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Oct 2007 01:33:31 -0400
In-Reply-To: <1193203821.8788.4.camel@concordia>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: michael@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, jeff@garzik.org, barkalow@iabervon.org, linas@austin.ibm.com, chunhao.huang@hotmail.com, gregkh@suse.de, htejun@gmail.com, brice.goglin@gmail.com, david.gaarenstroom@gmail.com, linux-pci@atrey.karlin.mff.cuni.cz, shane.huang@amd.com, linux-ide@vger.kernel.org, brice@myri.com, mchan@broadcom.com

From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 24 Oct 2007 15:30:21 +1000

> That looks like 6 hunks doing exactly the same thing? What about
> creating a pci_intx_quirked() (or something) that checks the flag and
> then does/or does not call pci_intx().

Good idea, I'll add that to the patch.
