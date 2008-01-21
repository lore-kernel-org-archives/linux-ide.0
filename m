From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA port multiplier(Sil 3132)  and JMicron 361-363
Date: Mon, 21 Jan 2008 16:42:01 +0900
Message-ID: <47944CC9.7020308@gmail.com>
References: <20080112140232.58b171b4.mikpolniak@roadrunner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:10566 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757357AbYAUHmI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 02:42:08 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3539219wah.23
        for <linux-ide@vger.kernel.org>; Sun, 20 Jan 2008 23:42:06 -0800 (PST)
In-Reply-To: <20080112140232.58b171b4.mikpolniak@roadrunner.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mikp <mikpolniak@roadrunner.com>
Cc: linux-ide@vger.kernel.org

mikp wrote:
> My SII 3132 port multiplier works with the JMB363 controller on my motherboard using kernel-2.6.24-rc3 but not with the JMB361 esata controller which i have on a second motherboard.
> 
> I get messages:
>    ata5.15: failed to read PMP GSCR[1] (Emask=0x4)
>    ahci 0000:00:12.0: controller can't do PMP, turning off CAP_PMP
> 
> The motherboard maker (ECS) and JMicron data claim that JMB361 has a port multiplier.
> 
> Is there any chance this controller can be made to work in linux? I am willing to test patches.

361 should be able to do PMP.  Care to post full boot log?

-- 
tejun
