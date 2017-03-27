From: Tejun Heo <tj@kernel.org>
Subject: Re: pata_atiixp regression in 4.11-rc1
Date: Mon, 27 Mar 2017 13:49:02 -0400
Message-ID: <20170327174902.GA13353@htj.duckdns.org>
References: <22571b6e-a8f3-05bc-d68b-a728f595af1d@gmail.com>
 <CGME20170327092244epcas1p18acab65df487d4813421302740fa946b@epcas1p1.samsung.com>
 <1562903.8NG6OqSh5o@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:36185 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751453AbdC0R5L (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 27 Mar 2017 13:57:11 -0400
Received: by mail-yw0-f182.google.com with SMTP id i203so37163146ywc.3
        for <linux-ide@vger.kernel.org>; Mon, 27 Mar 2017 10:57:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1562903.8NG6OqSh5o@amdc3058>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Markku Pesonen <tourula@gmail.com>, linux-ide@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>

Hello,

On Mon, Mar 27, 2017 at 11:22:41AM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> added patch author to Cc:
> 
> On Sunday, March 26, 2017 10:31:17 AM Markku Pesonen wrote:
> > Hello,
> > 
> > While testing Linux 4.11-rc1, I noticed that the IDE port on my
> > Asrock 980DE3/U3S3 motherboard stopped working.
> > 
> > Reverting commit 5946fdaee4ba449e8fbb5d403e1ed69437f916e8
> > (pata_atiixp: Don't use unconnected secondary port on SB600/SB700)
> > made things work again.
> > 
> > Apparently the secondary port is used on this motherboard.

I'm gonna revert the commit for now.

Thanks.

-- 
tejun
