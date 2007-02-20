From: "Patrick Ale" <patrick.ale@gmail.com>
Subject: Re: Fwd: [LIBATA] drives not detected
Date: Tue, 20 Feb 2007 13:05:38 +0100
Message-ID: <8d158e1f0702200405w6a0e817bx3d809540d28b843d@mail.gmail.com>
References: <8d158e1f0702150048x4eb73acawc3c3b87d0d80a6d4@mail.gmail.com>
	 <8d158e1f0702150052l25fb03fnf17ba315dc6f912d@mail.gmail.com>
	 <8d158e1f0702160010k2ed986ddtaccf8d2678ae1231@mail.gmail.com>
	 <45D56FE4.3090900@tw.ibm.com>
	 <8d158e1f0702160056j11ab6df1v99b4d72866f3e1b2@mail.gmail.com>
	 <45D574B1.8080109@tw.ibm.com>
	 <8d158e1f0702160148v366ce96bm8e3ff3e7c64a7198@mail.gmail.com>
	 <45D58270.4080909@tw.ibm.com>
	 <8d158e1f0702170236h51756aadh6539f5d782774764@mail.gmail.com>
	 <45DAD8DA.4000108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:15993 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964854AbXBTMFk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Feb 2007 07:05:40 -0500
Received: by an-out-0708.google.com with SMTP id b33so331815ana
        for <linux-ide@vger.kernel.org>; Tue, 20 Feb 2007 04:05:39 -0800 (PST)
In-Reply-To: <45DAD8DA.4000108@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, linux-ide@vger.kernel.org

On 2/20/07, Tejun Heo <htejun@gmail.com> wrote:
> Hmm...if you can use IDE driver for your root partition, change #undef
> ATA_DEBUG to #define ATA_DEBUG in include/linux/libata.h and rebuild the
> kernel.  After booting, insmod pata_pdc2027x and please report what the
> kernel says.  It might be that the controller doesn't interact well with
> libata's device discovery code using reset.  IDE drivers use different
> method for device detection so that's probably where the difference is
> coming from.

Hi,

Yep, I can do that. My root partition is served by a VIA chipset, so
no problems recompiling and testing stuff.

Give me a day tho, I am doing a pvmove /dev/md/3 /dev/md/5 so I can
safely mess around with the disks without having to worry about the
data :)

I'll keep you posted,

Patrick
