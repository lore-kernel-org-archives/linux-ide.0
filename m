From: Tejun Heo <htejun@gmail.com>
Subject: Re: Fwd: [LIBATA] drives not detected
Date: Tue, 20 Feb 2007 20:17:46 +0900
Message-ID: <45DAD8DA.4000108@gmail.com>
References: <8d158e1f0702150048x4eb73acawc3c3b87d0d80a6d4@mail.gmail.com>	 <8d158e1f0702150052l25fb03fnf17ba315dc6f912d@mail.gmail.com>	 <8d158e1f0702160010k2ed986ddtaccf8d2678ae1231@mail.gmail.com>	 <45D56FE4.3090900@tw.ibm.com>	 <8d158e1f0702160056j11ab6df1v99b4d72866f3e1b2@mail.gmail.com>	 <45D574B1.8080109@tw.ibm.com>	 <8d158e1f0702160148v366ce96bm8e3ff3e7c64a7198@mail.gmail.com>	 <45D58270.4080909@tw.ibm.com> <8d158e1f0702170236h51756aadh6539f5d782774764@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:56951 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932888AbXBTLRu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Feb 2007 06:17:50 -0500
Received: by an-out-0708.google.com with SMTP id b33so323485ana
        for <linux-ide@vger.kernel.org>; Tue, 20 Feb 2007 03:17:49 -0800 (PST)
In-Reply-To: <8d158e1f0702170236h51756aadh6539f5d782774764@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Patrick Ale <patrick.ale@gmail.com>
Cc: albertl@mail.com, linux-ide@vger.kernel.org

Patrick Ale wrote:
> On 2/16/07, Albert Lee <albertcc@tw.ibm.com> wrote:
> 
> Hi,
> 
> To make the fun even more fun.
> when I compile the old IDE drivers, rmmod the libata ones and modprobe
> the IDE drivers for my Promise card, the drives DO get detected.

Hmm...if you can use IDE driver for your root partition, change #undef
ATA_DEBUG to #define ATA_DEBUG in include/linux/libata.h and rebuild the
kernel.  After booting, insmod pata_pdc2027x and please report what the
kernel says.  It might be that the controller doesn't interact well with
libata's device discovery code using reset.  IDE drivers use different
method for device detection so that's probably where the difference is
coming from.

Thanks.

-- 
tejun
