From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 4/5] sata_mv new mv_sata_hardreset handler
Date: Thu, 03 Apr 2008 23:09:52 +0900
Message-ID: <47F4E530.5040901@gmail.com>
References: <47F1736F.8020104@rtr.ca> <47F1755F.9000303@rtr.ca> <47F2F002.9070401@gmail.com> <47F3E3A8.10309@rtr.ca> <47F429B0.7020204@gmail.com> <47F44572.5010100@rtr.ca> <47F44BCB.7030005@gmail.com> <47F4E341.9080609@rtr.ca> <47F4E3E4.5080706@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:37518 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865AbYDCOKA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Apr 2008 10:10:00 -0400
Received: by wr-out-0506.google.com with SMTP id c48so2321154wra.1
        for <linux-ide@vger.kernel.org>; Thu, 03 Apr 2008 07:09:59 -0700 (PDT)
In-Reply-To: <47F4E3E4.5080706@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Mark Lord wrote:
> Though, mind you.. as soon as your rework *does* hit upstream,
> I'll happily submit further sata_mv patches to take full advantage.
> 
> The less custom code in sata_mv in the end, the happier I'll be.
> That's why there's a comment there right now reminding me of it.

Yeap, I fully agree.  Also, the said change will probably go into 2.6.26 
too.  It's unfortunate that your sata_mv work overlaps too much with 
recent API overhauls.  I don't know how Jeff will merge stuff but 
merging sata_mv changes first is fine by me.  I'll update API changes 
accordingly and run it by you.

Thanks.

-- 
tejun
