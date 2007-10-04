From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 and sil-4726
Date: Thu, 04 Oct 2007 15:46:03 +0900
Message-ID: <47048C2B.1060202@gmail.com>
References: <18180.26625.216781.626572@kitty1.shrimp.net>	<470468EE.909@gmail.com>	<18180.30643.554165.292012@kitty1.shrimp.net>	<4704790C.7060901@gmail.com>	<18180.31651.305092.579581@kitty1.shrimp.net>	<470480C9.9030309@gmail.com> <18180.34107.704754.565573@kitty1.shrimp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:18228 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbXJDGqK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 02:46:10 -0400
Received: by wa-out-1112.google.com with SMTP id v27so93717wah
        for <linux-ide@vger.kernel.org>; Wed, 03 Oct 2007 23:46:10 -0700 (PDT)
In-Reply-To: <18180.34107.704754.565573@kitty1.shrimp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: idurdanovic@comcast.net
Cc: linux-ide@vger.kernel.org

Igor Durdanovic wrote:
> Tejun Heo writes:
>>> ata4.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
>>> ata4.00: hard resetting link
>>> ata4.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>> ata4.01: hard resetting link
>>> ata4.01: softreset failed (SRST command error)
>>> ata4.01: reset failed (errno=-5), retrying in 10 secs
>> Eeeek, the above sequence repeats for each downstream port.  Weird.  How
>> reproducible is the problem?  Every time?
> 
> I just rebooted and got exactly the same log (did diff), it seems very
> reproducible.

Can you try to update the firmware as explained in the SIMG support page
and see whether that fixes the problem?

-- 
tejun
