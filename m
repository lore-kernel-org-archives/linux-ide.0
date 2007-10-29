From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 5/5]: [PCI]: Remove 3 incorrect MSI quirks.
Date: Sun, 28 Oct 2007 18:08:54 -0700 (PDT)
Message-ID: <20071028.180854.244270309.davem@davemloft.net>
References: <9783dadb0710260356g4ef94e3dvadf69d4d263c2361@mail.gmail.com>
	<20071026.043833.88113848.davem@davemloft.net>
	<9783dadb0710281311o619a6bd4r2f7b1c4cbaa325e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:55535
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753001AbXJ2BIx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Oct 2007 21:08:53 -0400
In-Reply-To: <9783dadb0710281311o619a6bd4r2f7b1c4cbaa325e9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: david.gaarenstroom@gmail.com
Cc: shane.huang@amd.com, linux-kernel@vger.kernel.org, jeff@garzik.org, barkalow@iabervon.org, linas@austin.ibm.com, chunhao.huang@hotmail.com, gregkh@suse.de, htejun@gmail.com, brice.goglin@gmail.com, linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org, brice@myri.com, mchan@broadcom.com

From: "David Gaarenstroom" <david.gaarenstroom@gmail.com>
Date: Sun, 28 Oct 2007 21:11:13 +0100

> > I would like those to be removed, but to be conservative we should
> > first get some testing feedback that confirms this just like those
> > provided to me from the AMD folks for the RS690, RX790 and RD580
> > cases.
> 
> The patch works fine for my laptop with the RS480 chipset (with a
> SB400 southbridge).
> But it would be nice if AMD tested it as well...

So please submit "The patch" :-)
