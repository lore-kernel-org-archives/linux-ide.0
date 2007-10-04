From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 and sil-4726
Date: Thu, 04 Oct 2007 16:34:49 +0900
Message-ID: <47049799.3030509@gmail.com>
References: <18180.26625.216781.626572@kitty1.shrimp.net>	<470468EE.909@gmail.com>	<18180.30643.554165.292012@kitty1.shrimp.net>	<4704790C.7060901@gmail.com>	<18180.31651.305092.579581@kitty1.shrimp.net>	<470480C9.9030309@gmail.com>	<18180.34107.704754.565573@kitty1.shrimp.net>	<47048C2B.1060202@gmail.com>	<47049344.6010603@gmail.com> <18180.38483.139258.690293@kitty1.shrimp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:48775 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbXJDHe4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 03:34:56 -0400
Received: by nz-out-0506.google.com with SMTP id s18so78112nze
        for <linux-ide@vger.kernel.org>; Thu, 04 Oct 2007 00:34:56 -0700 (PDT)
In-Reply-To: <18180.38483.139258.690293@kitty1.shrimp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: idurdanovic@comcast.net
Cc: linux-ide@vger.kernel.org

Igor Durdanovic wrote:
> Tejun Heo writes:
>>> Can you try to update the firmware as explained in the SIMG support page
>>> and see whether that fixes the problem?
> 
> I am actually trying to put all the sw on the array, will try to
> update firmware later.
> 
> Have some weird problems .. the whole thing just froze, sigh.
> Also, why can't I enable write-caching on each drive behind PM?

You should be.  What do you mean by not being able to enable write-caching?

>> Hmmm... Before doing that, do your drives spin up one-by-one as the
>> above probing progresses?
> 
> Yes, the probing starts with the bottom drive and progresses to the
> top. But it seems for each drive it resets (from the bottom) all
> already probed drives.

SRST failure puts the host port into non-responding state and the driver
resets the host port which in turn resets the PMP, so libata tries to
reinitialize everything.  Can you post boot log with printk timestamp
(CONFIG_PRINTK_TIME) turned on?

-- 
tejun
