From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: pata_atiixp regression in 4.11-rc1
Date: Mon, 27 Mar 2017 11:22:41 +0200
Message-ID: <1562903.8NG6OqSh5o@amdc3058>
References: <22571b6e-a8f3-05bc-d68b-a728f595af1d@gmail.com>
 <CGME20170327092244epcas1p18acab65df487d4813421302740fa946b@epcas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:59526 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbdC0JWr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 27 Mar 2017 05:22:47 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0ONG01UYTVDXEA60@mailout4.samsung.com> for
 linux-ide@vger.kernel.org; Mon, 27 Mar 2017 18:22:45 +0900 (KST)
In-reply-to: <22571b6e-a8f3-05bc-d68b-a728f595af1d@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Markku Pesonen <tourula@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>


added patch author to Cc:

On Sunday, March 26, 2017 10:31:17 AM Markku Pesonen wrote:
> Hello,
> 
> While testing Linux 4.11-rc1, I noticed that the IDE port on my
> Asrock 980DE3/U3S3 motherboard stopped working.
> 
> Reverting commit 5946fdaee4ba449e8fbb5d403e1ed69437f916e8
> (pata_atiixp: Don't use unconnected secondary port on SB600/SB700)
> made things work again.
> 
> Apparently the secondary port is used on this motherboard.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

