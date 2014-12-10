From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly return
 zeroes after TRIM
Date: Wed, 10 Dec 2014 09:29:27 -0500
Message-ID: <20141210142927.GA6294@htj.dyndns.org>
References: <yq18uiojfq9.fsf@sermon.lab.mkp.net>
 <20141204170611.GB2995@htj.dyndns.org>
 <yq14mtahmil.fsf@sermon.lab.mkp.net>
 <20141205145148.GI4080@htj.dyndns.org>
 <1418184578.2121.3.camel@HansenPartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:35645 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757135AbaLJO3k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Dec 2014 09:29:40 -0500
Received: by mail-qa0-f54.google.com with SMTP id i13so2077517qae.27
        for <linux-ide@vger.kernel.org>; Wed, 10 Dec 2014 06:29:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1418184578.2121.3.camel@HansenPartnership.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org

Hello,

On Wed, Dec 10, 2014 at 07:09:38AM +0300, James Bottomley wrote:
> Conversely, drives that return random junk after a trim cause
> verification failures, so we just elect not to transmit trim down to
> them from the RAID layer.

I see.  Thanks for the explanation.  I suppose the current raid
implementations' metadata handling on partially built devices isn't
developed enough to simply mark those trimmed blocks as unsynced?  If
raid consistency truly is the only reason for this, that approach
seems way more fruitful to me than playing this optional feature game
with hardware vendors which so often leads to eventual abysmal
outcomes.

Thanks.

-- 
tejun
