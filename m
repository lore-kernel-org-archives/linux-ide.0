From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 14/14] libata: use PIO for misc ATAPI commands
Date: Fri, 30 Nov 2007 01:16:56 +0900
Message-ID: <474EE5F8.1030409@gmail.com>
References: <1196346817387-git-send-email-htejun@gmail.com>	<11963468202627-git-send-email-htejun@gmail.com> <20071129160555.38ee2edc@the-village.bc.nu> <474EE561.7010207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:39380 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758968AbXK2QRG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 11:17:06 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1591870rvb
        for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2007 08:17:03 -0800 (PST)
In-Reply-To: <474EE561.7010207@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com

Tejun Heo wrote:
> Alan Cox wrote:
>>> Private command type / transfer length filtering in sata_promise,
>>> pata_it821x and pata_pdc2027x are removed as core layer filtering is
>>> more conservative.
>>>
>>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> NAK - as before
>>
>> This is the wrong way to do stuff. Stop penalizing the 99.99% of users
>> with perfectly sane hardware. In addition I note that the whitelist for
>> drives would rapidly be thousands of entries long and unmanagable.
> 
> Well, I guess we'll have to agree to disagree here.  I just don't think
> that penalty is worth considering and definitely don't think whitelist
> is necessary at all.

Also, what do other people think about the subject?  IIRC, Jeff agrees
with Alan, right?  Albert, Mark, what do you guys think?

Thanks.

-- 
tejun
