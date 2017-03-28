From: Tejun Heo <tj@kernel.org>
Subject: Re: pata_atiixp regression in 4.11-rc1
Date: Tue, 28 Mar 2017 11:58:46 -0400
Message-ID: <20170328155846.GB28157@htj.duckdns.org>
References: <22571b6e-a8f3-05bc-d68b-a728f595af1d@gmail.com>
 <20170327175550.GB13353@htj.duckdns.org>
 <49cdecb0846.6a8a0888@auth.smtp.1and1.co.uk>
 <d9c9cb23-e67f-779d-240d-e02f7d87e405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35679 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752697AbdC1P7m (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Mar 2017 11:59:42 -0400
Received: by mail-pg0-f52.google.com with SMTP id 81so62182761pgh.2
        for <linux-ide@vger.kernel.org>; Tue, 28 Mar 2017 08:59:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <d9c9cb23-e67f-779d-240d-e02f7d87e405@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Markku Pesonen <tourula@gmail.com>
Cc: Darren Stevens <darren@stevens-zone.net>, linux-ide@vger.kernel.org

On Tue, Mar 28, 2017 at 12:57:42PM +0300, Markku Pesonen wrote:
> On 28.03.2017 11:24, Darren Stevens wrote:
> > Hello Tejun
> > 
> > On 27/03/2017, Tejun Heo wrote:
> > > From a431ecd2d459da3c91a612061f09eb422ffe78e2 Mon Sep 17 00:00:00 2001
> > > From: Tejun Heo <tj@kernel.org>
> > > Date: Mon, 27 Mar 2017 13:52:00 -0400
> > > Subject: [PATCH] Revert "pata_atiixp: Don't use unconnected secondary
> > >  port on SB600/SB700"
> > > 
> > > This reverts commit 5946fdaee4ba449e8fbb5d403e1ed69437f916e8.
> > > 
> > > The original commit's assumption that the secondary port is
> > > unconnected turns out to be false.
> > 
> > Not entirely. I based my patch on information in AMD's document
> > 43366_sb7xx_bdg_pub_1.00.p
> 
> I found this in the AMD SB710 Databook, rev 1.60, p. 56:
> "The integrated parallel ATA controller contains a single channel but
> can be configured as primary or secondary channel."
> 
> The IDE connector on my Asrock 980DE3/U3S3 motherboard is configured as
> the secondary channel. The primary channel is used by the optional
> SATA-IDE emulation mode.
> 
> I don't know much about kernel programming, southbridges, or ata
> controllers, but I hope this bit of information helps.

One way or the other, there's a reported case of secondary port being
used, so we can't mark it dummy no matter what the datasheet says.  If
whether the port is marked dummy or not matter much, we can try to do
finer grained blacklisting or try to do something smarter.

Thanks.

-- 
tejun
