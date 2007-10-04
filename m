From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 and sil-4726
Date: Thu, 04 Oct 2007 16:47:00 +0900
Message-ID: <47049A74.3080000@gmail.com>
References: <18180.26625.216781.626572@kitty1.shrimp.net>	<470468EE.909@gmail.com>	<18180.30643.554165.292012@kitty1.shrimp.net>	<4704790C.7060901@gmail.com>	<18180.31651.305092.579581@kitty1.shrimp.net>	<470480C9.9030309@gmail.com>	<18180.34107.704754.565573@kitty1.shrimp.net>	<47048C2B.1060202@gmail.com>	<47049344.6010603@gmail.com>	<18180.38483.139258.690293@kitty1.shrimp.net>	<47049799.3030509@gmail.com> <18180.39323.750969.577889@kitty1.shrimp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:11516 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509AbXJDHrH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 03:47:07 -0400
Received: by wa-out-1112.google.com with SMTP id v27so108898wah
        for <linux-ide@vger.kernel.org>; Thu, 04 Oct 2007 00:47:07 -0700 (PDT)
In-Reply-To: <18180.39323.750969.577889@kitty1.shrimp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: idurdanovic@comcast.net
Cc: linux-ide@vger.kernel.org

Igor Durdanovic wrote:
>> SRST failure puts the host port into non-responding state and the driver
>> resets the host port which in turn resets the PMP, so libata tries to
>> reinitialize everything.  Can you post boot log with printk timestamp
>> (CONFIG_PRINTK_TIME) turned on?
> 
> Will do if the hard/soft reset appears again, for the moment
> everything behaves differently from before (maybe because the card did
> not reset the array when I switched the laptop off?)

You probably need to power off the array to reproduce the problem.

-- 
tejun
