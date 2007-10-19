From: "peer chen" <peerchen@gmail.com>
Subject: Re: [PATCH] sata_nv,ahci: add the ahci legacy mode support to sata_nv
Date: Fri, 19 Oct 2007 14:58:19 +0800
Message-ID: <cfaab6210710182358t4de355f9wd6d605a7b8076ace@mail.gmail.com>
References: <200709251323031982245@gmail.com> <470FE47B.5060505@garzik.org>
	 <cfaab6210710160108x1328086cse991f668e23e569e@mail.gmail.com>
	 <47181CE1.4000802@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:46157 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbXJSG6V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Oct 2007 02:58:21 -0400
Received: by mu-out-0910.google.com with SMTP id i10so642305mue
        for <linux-ide@vger.kernel.org>; Thu, 18 Oct 2007 23:58:19 -0700 (PDT)
In-Reply-To: <47181CE1.4000802@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, akpm <akpm@linux-foundation.org>, Kuan Luo <kluo@nvidia.com>

Ok,I agree to use AHCI driver for our AHCI controllers no matter their
class codes are IDE/RAID/AHCI. But for those new or upcoming AHCI
controller which DIDs are not included in ahci.c and also IDE/RAID
mode being set in BIOS, no driver will be loaded currently, so I hope
the first patch http://lkml.org/lkml/2007/10/8/93 can be appied for
this case. Any comments?

2007/10/19, Jeff Garzik <jeff@garzik.org>:
> peer chen wrote:
> > I hope one of the following patches can be merged to 2.6.24.
> > ==========================
> > http://lkml.org/lkml/2007/10/8/93
> > http://lkml.org/lkml/2007/9/25/20
>
> Unfortunately I do not feel like this is the right course of action.
>
> Experience from Intel platforms tells us that our users get very unhappy
> when their silicon supports AHCI mode, but they are forced into using a
> less-performant mode.  A popular example is an <unnamed> OEM whose BIOS
> had no method whatsoever for enabling AHCI -- didn't even program the
> PCI BAR -- even though tests showed the AHCI mode worked just fine when
> manually programmed.
>
> AHCI is more likely to provide a /stable/ Serial ATA experience, because
> the silicon deals primarily with sending and receiving FIS's, and not
> much else.  In constrast, experience has shown the legacy IDE interface
> to be a less reliable method of SATA support.  And certainly AHCI is
> much, much faster with less per-command overhead.
>
> Given that AHCI is both faster and more stable, I feel it is the best
> policy to enable AHCI when the hardware supports it, regardless of PCI
> class code (IDE, SATA, or RAID).
>
>
> > Yes, I agree to set the 'swncq' as default for 2.6.24, after all, for
> > our server customers, stability is far more important than the new
> > feature no matter the problem is caused by drive or controller.
>
> Agreed.  Done!
>
>        Jeff
>
>
>
>
>
