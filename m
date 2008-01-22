From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA port multiplier(Sil 3132)  and JMicron 361-363
Date: Wed, 23 Jan 2008 08:19:30 +0900
Message-ID: <47967A02.1030607@gmail.com>
References: <20080112140232.58b171b4.mikpolniak@roadrunner.com>	<47944CC9.7020308@gmail.com>	<20080121140513.4356d551.mikpolniak@roadrunner.com>	<4795482B.5090009@gmail.com> <20080122123550.a1652dca.mikpolniak@roadrunner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:33408 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756388AbYAVXTv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jan 2008 18:19:51 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2274633rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 22 Jan 2008 15:19:51 -0800 (PST)
In-Reply-To: <20080122123550.a1652dca.mikpolniak@roadrunner.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mikp <mikpolniak@roadrunner.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

mikp wrote:
>>> The JMB361 controller is more quirky. I had to reboot and replug 3 or 4
>>> times before the PMP box started working normal. Here is syslog and dmesg of boot 
>>> and reboot to finally get JMB361 working:
>> The log messages are truncated.  Can you please post a clean kernel log
>> including booting, detection of ata5 and detection failure?  Also,
>> please give a shot at different shorter cable.
>>
> I tested this morning with different cables (long and short) and the JMB361 
> worked successfully with the PMP every time. So it appears the previous 
> problem was related to the cable. Although the same cable did work with the 
> SI 3132.

I've seen that sometimes.  I don't know whether PMP devices are picky
about cable or e-SATA cables are crappy tho.

Thanks.

-- 
tejun
