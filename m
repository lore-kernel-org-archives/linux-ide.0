From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_nv,ahci: add the ahci legacy mode support to sata_nv
Date: Fri, 19 Oct 2007 03:25:49 -0400
Message-ID: <47185BFD.2010909@garzik.org>
References: <200709251323031982245@gmail.com> <470FE47B.5060505@garzik.org>	 <cfaab6210710160108x1328086cse991f668e23e569e@mail.gmail.com>	 <47181CE1.4000802@garzik.org> <cfaab6210710182358t4de355f9wd6d605a7b8076ace@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42196 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751700AbXJSHZ4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Oct 2007 03:25:56 -0400
In-Reply-To: <cfaab6210710182358t4de355f9wd6d605a7b8076ace@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: peer chen <peerchen@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, akpm <akpm@linux-foundation.org>, Kuan Luo <kluo@nvidia.com>

peer chen wrote:
> Ok,I agree to use AHCI driver for our AHCI controllers no matter their
> class codes are IDE/RAID/AHCI. But for those new or upcoming AHCI
> controller which DIDs are not included in ahci.c and also IDE/RAID
> mode being set in BIOS, no driver will be loaded currently, so I hope
> the first patch http://lkml.org/lkml/2007/10/8/93 can be appied for
> this case. Any comments?

hmmm is that the correct URL?  That one updates sata_nv to support AHCI 
controllers?.

I would think you would want to add the RAID class code to ahci.c 
instead?  And just some regular PCI IDs?

	Jeff


