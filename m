From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH] libata-pmp: add schedule timeout to support some PMP
 cards
Date: Tue, 15 Nov 2011 08:43:02 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F1161C24D@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1320033440-1106-1-git-send-email-r66093@freescale.com>
 <20111103160759.GI4417@google.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F11617501@039-SN1MPN1-005.039d.mgd.msft.net>
 <20111110152036.GB27258@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:7382 "EHLO
	TX2EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753677Ab1KOInE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Nov 2011 03:43:04 -0500
In-Reply-To: <20111110152036.GB27258@google.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>



Thanks and Best Regards
Jerry Huang

> -----Original Message-----
> From: Tejun Heo [mailto:htejun@gmail.com] On Behalf Of Tejun Heo
> Sent: Thursday, November 10, 2011 11:21 PM
> To: Huang Changming-R66093
> Cc: linux-ide@vger.kernel.org
> Subject: Re: [PATCH] libata-pmp: add schedule timeout to support some
> PMP cards
> 
> Hello,
> 
> On Thu, Nov 10, 2011 at 08:07:47AM +0000, Huang Changming-R66093 wrote:
> > > Ummm... We can't really issue commands after failure without going
> > > through recovery.  For ahci, it probably works.  For other
> > > controllers, it may not.  Where does this delay come from?  Is
> there
> > > any other way to wait for device readiness?
> > >
> > It is very bad.  I have two PMP cards, one (5 ports) can work well
> > without the delay time before reading PMP SCR, but the other (15
> > ports) must delay enough time before reading the PMP SCR.  It seems
> > there is no other way to detect the device readiness.
> >
> > Maybe I will just delay some time before send SCR command, if it
> > failed, then we will report this error to driver?
> 
> Hmmm... I'm curious what's causing the problem.  Which port multiplier
> are we talking about?  If it's specific to that PMP, we can add quirk
> to support it.  Does the problem also happen when the PMP is connected
> to a different controller?
> 
Hi,
The PMP card we are talking about is JMB393:
Port Multiplier 1.2, 0x197b:0x0325 r0, 15 ports, feat 0x5/0xf.

This issue is observed on Freescale's Sata controller, including p1020e and mpc837xe.

