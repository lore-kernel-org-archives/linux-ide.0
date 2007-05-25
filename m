From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: always use polling SETXFER
Date: Fri, 25 May 2007 13:58:59 +0200
Message-ID: <4656CF83.5020402@gmail.com>
References: <20070314053338.GA15600@htj.dyndns.org> <4656C144.2080705@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:14849 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170AbXEYL7N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 May 2007 07:59:13 -0400
Received: by wr-out-0506.google.com with SMTP id 76so295230wra
        for <linux-ide@vger.kernel.org>; Fri, 25 May 2007 04:59:12 -0700 (PDT)
In-Reply-To: <4656C144.2080705@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hello, Jeff.

Jeff Garzik wrote:
> Since I wrote them up in IRC, I might as well post them here and get it
> archived:

Just about to reply on IRC.  :-)

> We need to figure out a better polling solution.
> 
> For SAS and advanced SATA, polling really has no meaning at all, when
> you consider what polling IDENTIFY DEVICE and polling SET FEATURES are
> trying to solve.  To the advanced hardware, it's all a bunch of packets.
>  An event that appears "late" to the eyes of the PATA world is now
> presented as changing data fields in the packet stream.
> 
> We are going to have to deal with the HSM issue underlying the need to
> do SET FEATURES - XFER MODE polling, and ultimately IDENTIFY DEVICE
> polling too.
> 
> This is the main reason why I have resisted applying "[PATCH] libata:
> always use polling SETXFER" -- polling implies a model that does not
> exist on SAS/SATA and advanced SATA.  It's only luck that AHCI includes
> a real register to poll.
> 
> To illustrate:  Fixing this problem The Right Way(tm) will yield a
> result that would allow ahci.c to operate in an interrupt-driven mode,
> examining the contents of the FIS's returned. Polling status can already
> be replaced by examining the D2H and SDB FIS areas.
> 
> And by definition, on AHCI (and sata_sil24, IIRC) the status will not
> change unless a new FIS has arrived.
> 
> Polling is still fine on PCI IDE-like controllers (older ones), but
> advanced controllers require us to coalesce the polling bandaid into a
> test for a sequence of events.
> 
> We cannot escape the "hard part."  :)

I don't think the "hard part" exists at all.

1. There are only a handful of PATA devices which raise IRQ too early.
For native SATA devices, it's much more difficult to get it wrong if you
consider the SATA non-data and PIO transport protocol.  For PATA devices
bridged to SATA, again, there's nothing much we can do.  The bridge
implements HSM and would send D2H Reg FIS on command completion IRQ.  If
the PATA shows incorrect register values at that stage, well, that's it.

3. Intelligent controllers such as AHCI and sil24 implement some part of
HSM in the silicon.  sil24 implements most of it, ahci a bit less, but,
even for ahci, the too early interrupt can trigger internal HSM failure.
 I don't think we can do much in such cases.  sil24 doesn't even update
the TF area if command is not in progress.  In the intelligent
controllers, the problem polling SETXFER tries to solve is in lower
layer than OS driver.

So, I don't think the problem exists for SATA in the first place.  At
least there hasn't been any report of it and doing SETXFER by polling
can handle all the existing cases.  We can and probably should deal with
such SATA devices when and if they come up.  How are we gonna verify the
controller doesn't crap itself and ahci TF register monitoring HSM can
work around the weirdo when we don't have any such device?  Even if we
determine that we need to do HSM over intelligent SATA controller now, I
think we still need to push polling SETXFER first to take care of the
existing cases.

Thanks.

-- 
tejun
