From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 5/5]: [PCI]: Remove 3 incorrect MSI quirks.
Date: Fri, 26 Oct 2007 04:38:33 -0700 (PDT)
Message-ID: <20071026.043833.88113848.davem@davemloft.net>
References: <20071025.011716.123998434.davem@davemloft.net>
	<9783dadb0710260356g4ef94e3dvadf69d4d263c2361@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:39181
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750747AbXJZLie (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2007 07:38:34 -0400
In-Reply-To: <9783dadb0710260356g4ef94e3dvadf69d4d263c2361@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: david.gaarenstroom@gmail.com
Cc: linux-kernel@vger.kernel.org, jeff@garzik.org, barkalow@iabervon.org, linas@austin.ibm.com, chunhao.huang@hotmail.com, gregkh@suse.de, htejun@gmail.com, brice.goglin@gmail.com, linux-pci@atrey.karlin.mff.cuni.cz, shane.huang@amd.com, linux-ide@vger.kernel.org, brice@myri.com, mchan@broadcom.com

From: "David Gaarenstroom" <david.gaarenstroom@gmail.com>
Date: Fri, 26 Oct 2007 12:56:52 +0200

> 2007/10/25, David Miller <davem@davemloft.net>:
> >
> > Now that we have dealt with the real issue, in that some ATI SATA and
> > USB controllers needed the INTX_DISABLE quirk, we can remove these AMD
> > chipset global MSI disabling quirks.
> 
> IMHO we should remove *all* former ATI "AMD" chipset global MSI
> disabling quirks... The whole idea was to sort things out once and for
> all. At least the RS480 quirk can be removed, now that the USB driver
> has the workaround for the SB400 southbridge USB. I suspect the same
> counts for the other ATI chipsets...

I would like those to be removed, but to be conservative we should
first get some testing feedback that confirms this just like those
provided to me from the AMD folks for the RS690, RX790 and RD580
cases.

Otherwise the risk to break people's systems is very real.
