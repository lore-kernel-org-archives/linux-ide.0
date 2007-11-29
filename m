From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 14/14] libata: use PIO for misc ATAPI commands
Date: Fri, 30 Nov 2007 01:14:25 +0900
Message-ID: <474EE561.7010207@gmail.com>
References: <1196346817387-git-send-email-htejun@gmail.com>	<11963468202627-git-send-email-htejun@gmail.com> <20071129160555.38ee2edc@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:34344 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758659AbXK2QOh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 11:14:37 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1591105rvb
        for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2007 08:14:36 -0800 (PST)
In-Reply-To: <20071129160555.38ee2edc@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com

Alan Cox wrote:
>> Private command type / transfer length filtering in sata_promise,
>> pata_it821x and pata_pdc2027x are removed as core layer filtering is
>> more conservative.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> NAK - as before
> 
> This is the wrong way to do stuff. Stop penalizing the 99.99% of users
> with perfectly sane hardware. In addition I note that the whitelist for
> drives would rapidly be thousands of entries long and unmanagable.

Well, I guess we'll have to agree to disagree here.  I just don't think
that penalty is worth considering and definitely don't think whitelist
is necessary at all.

> Blacklist the problem drives - there aren't that many as far as I can see
> from Fedora. Also don't confuse this with the pata_ali ATAPI problems
> which are most of the ones I do find.

If we're gonna take that road, let's lift 16 byte alignment check during
-rc cycles.  It's something which masks the problem half way.  It only
hinders the debugging process.

Thanks.

-- 
tejun
