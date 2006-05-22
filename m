From: Jeff Garzik <jeff@garzik.org>
Subject: Re: ICH8 and SATA
Date: Mon, 22 May 2006 19:29:22 -0400
Message-ID: <44724952.4040003@garzik.org>
References: <447169C8.9060708@garzik.org> <44723571.1090500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58018 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751302AbWEVX3Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 May 2006 19:29:24 -0400
In-Reply-To: <44723571.1090500@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Jeff Garzik wrote:
>> BTW, Intel sez:
>>
>> "FYI, I added PIIX_FLAG_IGNORE_PCS and was able to boot on ICH8."
>>
> 
> Yeap, that should achieve about the same effect as the experimental 
> patch Andrew posted; also, about the same phantom bug.

Nod, just sending that to note conclusively that ICH8+PCS is a confirmed 
problem case, as confirmed from multiple sources.


> I don't think the phantom device problem is caused by missing 
> dev_select.  We have enough dev_select() during classification.

Just a guess.  Can I easily reproduce this?  I have a bunch of Intel 
machines, ICH5/6/7 (no ICH8 yet), of various flavors.

	Jeff



