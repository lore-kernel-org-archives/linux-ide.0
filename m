From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [RFC PATCH 00/19] ide: remove deprecated host drivers (part 1)
Date: Thu, 08 Dec 2016 17:15:16 +0100
Message-ID: <5007114.YSRHeGyTgl@amdc3058>
References: <1454593456-3162-1-git-send-email-b.zolnierkie@samsung.com>
 <3280015.pSoKvQuVNQ@amdc3058>
 <20161208.102308.460750923427290066.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:53357 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753207AbcLHQPU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 8 Dec 2016 11:15:20 -0500
In-reply-to: <20161208.102308.460750923427290066.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, tj@kernel.org, gnomes@lxorguk.ukuu.org.uk, sergei.shtylyov@cogentembedded.com

On Thursday, December 08, 2016 10:23:08 AM David Miller wrote:
> From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Date: Thu, 08 Dec 2016 14:42:12 +0100
> 
> > Ping.. since there was no negative (or any other) feedback I think that
> > this can be put into -next for some wider exposure..
> 
> I'm not going to apply this and break things on people, sorry.

People building their own kernels with their own kernel config files
and still using IDE drivers (deprecated in 2009 BTW) will have to
update their setups to libata but otherwise nothing is supposed to
break.  So could you please explain in more detail what do you mean
by "break things on people"?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

