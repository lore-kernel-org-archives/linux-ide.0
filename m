From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/4 v2] Introduce ata_id_has_unload()
Date: Thu, 18 Sep 2008 16:24:11 -0700
Message-ID: <200809181624.11949.bzolnier@gmail.com>
References: <87d4j2n3dn.fsf@denkblock.local> <20080917163144.9870.90985.stgit@denkblock.local> <48D13712.1090904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:63767 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755655AbYIRXxj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Sep 2008 19:53:39 -0400
Received: by rv-out-0506.google.com with SMTP id k40so151226rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 18 Sep 2008 16:53:38 -0700 (PDT)
In-Reply-To: <48D13712.1090904@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Elias Oltmanns <eo@nebensachen.de>, Jeff Garzik <jeff@garzik.org>, Randy Dunlap <randy.dunlap@oracle.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 17 September 2008 09:57:54 Tejun Heo wrote:
> Elias Oltmanns wrote:
> > Add a function to check an ATA device's id for head unload support as
> > specified in ATA-7.
> > 
> > Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
> 
> Acked-by: Tejun Heo <tj@kernel.org>

Since there are still some minor concerns with libata version while
the ide one is completely ready I applied this patch to pata tree in
order not to delay wider testing anylonger.

Thanks,
Bart
