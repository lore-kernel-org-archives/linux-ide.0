From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream-fixes] libata:	update	atapi_eh_request_sense()
 such that lbam/lbah contains buffer size
Date: Wed, 12 Dec 2007 17:38:56 +0900
Message-ID: <475F9E20.4000800@gmail.com>
References: <475F51AE.1010305@gmail.com> <1197446739.3467.4.camel@Athas>	 <475F98C9.6080804@gmail.com> <1197447366.3467.10.camel@Athas>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:5376 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756381AbXLLIjE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Dec 2007 03:39:04 -0500
Received: by rv-out-0910.google.com with SMTP id k20so136955rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 12 Dec 2007 00:39:03 -0800 (PST)
In-Reply-To: <1197447366.3467.10.camel@Athas>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Will Trives <will@trivescon.com.au>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, yannick.dirou@axetic.com, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hello,

Will Trives wrote:
>> This drive or media does not support the 'BLANK media' command
>>> wodim: Cannot blank disk, aborting.
>>> wodim: Some drives do not support all blank types.
>>> wodim: Try again with wodim blank=all.
>> wodim suggests "blank=all", does it work?
>>
> Nope same thing happens.
> 
> "dvd+rw-format /dev/sr0 -force"  Works ok though.

This looks like a wodim or drive/media problem and for some reason wodim
thinks that the media can't be blanked.  Hmmm.. why do you need -force
to dvd+rw-format?  What happens if you don't use -force?

-- 
tejun
