From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 4/4] pata_platform: Use 16-bit wide data transfer
Date: Mon, 25 Aug 2014 15:34:54 -0400
Message-ID: <20140825193454.GD21688@htj.dyndns.org>
References: <1408790772-5305-1-git-send-email-shc_work@mail.ru>
 <1408790772-5305-3-git-send-email-shc_work@mail.ru>
 <20140823165326.GA13540@mtj.dyndns.org>
 <1408814955.452399984@f133.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:32825 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbaHYTe5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Aug 2014 15:34:57 -0400
Received: by mail-qa0-f54.google.com with SMTP id k15so12873689qaq.13
        for <linux-ide@vger.kernel.org>; Mon, 25 Aug 2014 12:34:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1408814955.452399984@f133.i.mail.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-ide@vger.kernel.org

Hello,

On Sat, Aug 23, 2014 at 09:29:15PM +0400, Alexander Shiyan wrote:
> > Shouldn't we distinguish them instead of forcing 16bit transfer on
> > all?
> 
> I do not see any reason to distinguish. This embodiment can be used with
> 16-bit and 32-bit bus, and even for 64-bit ;)

Hmmm... we do care about doing 32bit when possible as there are cases
where PIO is the only data tarnsfer mode available (it's ancient at
this point but then again we're talking about pata_platform devices).
Are you saying that the controllers in question here wouldn't care
because they're all 16bit only anyway?  Otherwise, we do want to
distinguish them.

Thanks.

-- 
tejun
