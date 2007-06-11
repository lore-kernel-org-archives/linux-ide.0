From: Peter Ganzhorn <peter.ganzhorn@googlemail.com>
Subject: Re: [PATCH] AHCI powersaving and port-stopping (2.6.22-rc4)
Date: Mon, 11 Jun 2007 13:20:46 +0200
Message-ID: <466D300E.4080201@googlemail.com>
References: <873b0yvk14.fsf-genuine-vii@john.fremlin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:51516 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbXFKLUw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Jun 2007 07:20:52 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1445125ugf
        for <linux-ide@vger.kernel.org>; Mon, 11 Jun 2007 04:20:51 -0700 (PDT)
In-Reply-To: <873b0yvk14.fsf-genuine-vii@john.fremlin.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: John Fremlin <john@fremlin.org>
Cc: linux-ide@vger.kernel.org, power@bughost.org

What Intel chipsets do include "AHCI chipset"?
I guess you are talking about the SATA controller of certain new Intel 
chipsets, aren't you?
Just recently I noticed that my new notebooks SATA controller won't work 
with the libata Intel ICH* drivers, though ICH8 was mentioned in the 
description.
My SATA controller identifies as "Intel Corporation Mobile SATA AHCI 
Controller" and seems to work with libata AHCI.
I was wondering when support for this controller will be added through 
the ICH* driver, but is it possible that this SATA controller is 
supposed to be used with the standard AHCI driver?

The chipset is an i965 (ICH8M).

Peter


John Fremlin wrote:
> Tejun Heo has made an excellent patch for saving power with the AHCI
> chipset. It saves about 1 W on my Thinkpad X60s.
>
> This patch will stop the ports when they are idle. To turn it on, 
>
>      echo 1 > /sys/module/libata/parameters/powersave
>
> This is very different from the patch I posted a while ago turning on
> a few bits in the CMD register (ALPE and ASP) and which Intel is
> apparently now trying. That only saves around 250mW. Tejun's patch
> saves about 1 W. It should also make the ALPE and ASP stuff irrelevant
> because it performs the same operation in software where better
> information about usage is (theoretically) available.
>
> I have updated the patch for 2.6.22-rc4. That is the extent of my
> involvement - if it works, thank Tejun Heo. But problems are quite
> likely to have been introduced by my clumsy update, so if it doesn't
> work, blame me first.
>
>   
> ------------------------------------------------------------------------
>
> _______________________________________________
> Power mailing list
> Power@bughost.org
> http://www.bughost.org/mailman/listinfo/power
>   

