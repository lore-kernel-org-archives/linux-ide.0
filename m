From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 and sil-4726
Date: Thu, 04 Oct 2007 16:16:20 +0900
Message-ID: <47049344.6010603@gmail.com>
References: <18180.26625.216781.626572@kitty1.shrimp.net>	<470468EE.909@gmail.com>	<18180.30643.554165.292012@kitty1.shrimp.net>	<4704790C.7060901@gmail.com>	<18180.31651.305092.579581@kitty1.shrimp.net>	<470480C9.9030309@gmail.com> <18180.34107.704754.565573@kitty1.shrimp.net> <47048C2B.1060202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.232]:38625 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976AbXJDHQ1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 03:16:27 -0400
Received: by nz-out-0506.google.com with SMTP id s18so74562nze
        for <linux-ide@vger.kernel.org>; Thu, 04 Oct 2007 00:16:27 -0700 (PDT)
In-Reply-To: <47048C2B.1060202@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: idurdanovic@comcast.net, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Igor Durdanovic wrote:
>> Tejun Heo writes:
>>>> ata4.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
>>>> ata4.00: hard resetting link
>>>> ata4.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>> ata4.01: hard resetting link
>>>> ata4.01: softreset failed (SRST command error)
>>>> ata4.01: reset failed (errno=-5), retrying in 10 secs
>>> Eeeek, the above sequence repeats for each downstream port.  Weird.  How
>>> reproducible is the problem?  Every time?
>> I just rebooted and got exactly the same log (did diff), it seems very
>> reproducible.
> 
> Can you try to update the firmware as explained in the SIMG support page
> and see whether that fixes the problem?

Hmmm... Before doing that, do your drives spin up one-by-one as the
above probing progresses?

Thanks.

-- 
tejun
