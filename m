From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly return
 zeroes after TRIM
Date: Mon, 5 Jan 2015 11:28:30 -0500
Message-ID: <20150105162830.GP15833@htj.dyndns.org>
References: <yq18uiojfq9.fsf@sermon.lab.mkp.net>
 <20141204170611.GB2995@htj.dyndns.org>
 <yq14mtahmil.fsf@sermon.lab.mkp.net>
 <20141205145148.GI4080@htj.dyndns.org>
 <1418184578.2121.3.camel@HansenPartnership.com>
 <20141210142927.GA6294@htj.dyndns.org>
 <yq1oarbcj6f.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:40558 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428AbbAEQ2e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2015 11:28:34 -0500
Received: by mail-qg0-f49.google.com with SMTP id f51so2409681qge.22
        for <linux-ide@vger.kernel.org>; Mon, 05 Jan 2015 08:28:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <yq1oarbcj6f.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, linux-ide@vger.kernel.org

Hello, Martin.

On Wed, Dec 10, 2014 at 04:02:32PM -0500, Martin K. Petersen wrote:
> >>>>> "Tejun" == Tejun Heo <tj@kernel.org> writes:
> 
> Tejun> If raid consistency truly is the only reason for this, that
> Tejun> approach seems way more fruitful to me than playing this optional
> Tejun> feature game with hardware vendors which so often leads to
> Tejun> eventual abysmal outcomes.
> 
> The other use case is the filesystem one where it is common to zero
> block ranges for bitmaps, etc. In many workloads there's is a
> significant win to trimming over writing out many blocks of zeroes.

Isn't that kinda niche and specialized tho?  Besides, in this use
case, the kernel is essentially just serving as the whitelist and
nothing else.  Userland would have to issue TRIMs directly.  I'm not
against this patch being merged but this really looks like an
ultimately futile effort to me.

Thanks.

-- 
tejun
