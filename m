From: Tejun Heo <htejun@gmail.com>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Tue, 09 Oct 2007 15:54:01 +0900
Message-ID: <470B2589.1080603@gmail.com>
References: <1190521193410-git-send-email-htejun@gmail.com>	<46F9BF3E.5050708@garzik.org>	<46FA1B4E.8090103@gmail.com>	<46FD079F.3010007@garzik.org>	<46FD0D50.8030602@gmail.com>	<46FD1C4A.8010101@garzik.org>	<46FD306C.3050205@gmail.com>	<46FD5DE1.8000206@rtr.ca> <20070928220309.7c9ed816@the-village.bc.nu> <46FDADD9.9050007@garzik.org> <46FE45CE.1050007@rtr.ca> <4700EA52.10701@garzik.org> <47018CEC.6060203@gmail.com> <47024001.6090306@garzik.org> <47024257.4050606@rtr.ca> <470247E1.2070905@garzik.org> <470805F1.6050303@gmail.com> <470AE2E1.5060208@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:2736 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbXJIGyK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Oct 2007 02:54:10 -0400
Received: by rv-out-0910.google.com with SMTP id k20so970757rvb
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2007 23:54:08 -0700 (PDT)
In-Reply-To: <470AE2E1.5060208@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Jeff Garzik wrote:
>>> A few days before that, both PMP and SAS /were/ slated for 2.6.24, and
>>> after I fix the design problems, they will be again.
>>>
>>> One way or another, upstream will /not/ be doing polling PMP in 2.6.24.
>>
>> Just an update to let you know that I've been working on it.  sata_sil24
>> works okay but ahci still craps itself after resetting downstream ports.

This turns out to be a different issue.  SIMG 5723/5744 doesn't like
being driven by ahci controllers (both ICH9 and JMB) and the problem
isn't related to whether polling is used or not.  It's very weird
because SATA tracer doesn't show much difference on the host side wire
between being driven by ahci and sil24/32, but on the fan-out side,
things are seriously broken (repeated COMRESET/COMWAKE/COMINIT and no
FIS successfully being relayed from the host side).

Other than that, I've tested things on various combinations and am
fairly confident with it.  I think we can go for 2.6.24 merge.  Even
things turn out to be bad, we at least have pretty good bisection point.

> Thanks for your patience and perseverance.

Thanks.  :-)

> It looks like it would be too difficult to get SAS PMP working for
> 2.6.24 merge window open, so I think it is only fair to rescind my
> assertion of "polling PMP not in 2.6.24 release."
> 
> Removing the polling remains a design requirement for SAS, but the more
> I look at old-EH-encrusted libsas, the more work I feel it needs before
> its ready for PMP.  Sorry.

I wish libata EH was easier to deal with from SAS side.  I think being
able to present SAS end point as an independent ATA host to libata EH
would probably make life easier for both sides, but I don't have any
actual experience with SAS (yet).

Thanks.

-- 
tejun
