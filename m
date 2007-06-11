From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PROBLEM + PATCH] Sata port disabled by BIOS gets initialized
Date: Tue, 12 Jun 2007 02:54:20 +0900
Message-ID: <466D8C4C.8040605@gmail.com>
References: <20056641.1181568752111.JavaMail.root@wombat.diezmil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.235]:37915 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752962AbXFKRz0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Jun 2007 13:55:26 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1069238wra
        for <linux-ide@vger.kernel.org>; Mon, 11 Jun 2007 10:55:25 -0700 (PDT)
In-Reply-To: <20056641.1181568752111.JavaMail.root@wombat.diezmil.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shyam_iyer@dell.com
Cc: linux-ide@vger.kernel.org

Hello,

shyam_iyer@dell.com wrote:
>> What happens if the port is enabled by the kernel?
> The BIOS tests for the device will not be performed for the port
> since it is disabled by the BIOS, and there is a potential security
> problem here if they get reenabled in the kernel.

You're trying to protect security by making OS not initialize PCS bits?
 I'm sorry but there are millions of ways to breach that once one has
root access to the OS (e.g. two liner script with setpci and echo to
scsi scan sysfs node) or physical access to the machine (connect the
drive to a different port or host).  If the user doesn't have either, OS
security mechanisms work pretty well and are much more flexible and useful.

Security-by-preserving-PCS just doesn't fly.  Please use Security Mode
feature set for that.

> If the user decides to disable the port through the BIOS, the driver
> needs to respect the user's wish to not use the port and carry on.
> Here the end result is a forceful reinitialization of the port by the
> driver against the user's wishes.

Well, currently, the Linux driver policy is to exploit the hardware
capability to the maximum - e.g. we unlock HPA unconditionally and force
multi-mode controllers into its best possible mode.  We try hard to
ignore BIOS imposed settings/limits.

>> I'm not sure whether this is a good idea and it has potential to
>> break a lot of other configurations.  That part of code is used for
>> *all* ata_piix out there, so we need a really really good reason to
>> change that.  So, please explain what you're trying to fix better.
>> 
> If the fix has a potential to break other things then there could be
> a module parameter that would let the driver accept the bios
> configuration for the pcs register and not modify the config space
> through the driver.

If reprogramming PCS does break specific cases, I'm willing to modify
the driver such that it detects the condition and preserves PCS setting
which is far better than requiring the user to enter some kernel
parameter but you need to give me much better reason if we're gonna go
that way.

Thanks.

-- 
tejun
