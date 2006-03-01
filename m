From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] ata_piix: improve combined mode handling
Date: Wed, 1 Mar 2006 14:16:04 +0900
Message-ID: <20060301051604.GA20697@htj.dyndns.org>
References: <11411439383398-git-send-email-htejun@gmail.com> <440493B7.7060109@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:5720 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932322AbWCAFQK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Mar 2006 00:16:10 -0500
Received: by zproxy.gmail.com with SMTP id n29so53554nzf
        for <linux-ide@vger.kernel.org>; Tue, 28 Feb 2006 21:16:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <440493B7.7060109@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: jfs@keytradebank.com, 0602@eq.cz, linux-ide@vger.kernel.org

On Tue, Feb 28, 2006 at 01:17:27PM -0500, Jeff Garzik wrote:
> Tejun Heo wrote:
> >Hello, all.
> >
> >This patchset is against the current upstream[1] + kill illegal
> >kfree() patch[2].
> 
> 30-second review:  looks OK, though I worry about patch #6.  I'll answer 
> your questions and review in-depth later on.
> 

I'm also a little bit about #6 (the reason why it's not part of #5).
I also thought about masking with available ports but we are trusting
PCS enable bits when both bits are off (early exit when present_mask
is zero), so...

-- 
tejun
