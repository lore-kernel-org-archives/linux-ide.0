From: Tejun Heo <htejun@gmail.com>
Subject: Re: Failed to IDENTIFY SATA harddrive on sata_sil24
Date: Tue, 03 Jul 2007 16:52:17 +0900
Message-ID: <468A0031.3040709@gmail.com>
References: <6a3d41200706270814o7675909dtbdafe4a4fa68943c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:41376 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016AbXGCHxg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 03:53:36 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2660356wah
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 00:53:35 -0700 (PDT)
In-Reply-To: <6a3d41200706270814o7675909dtbdafe4a4fa68943c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Tsai <bthomas.tsai@gmail.com>
Cc: linux-ide@vger.kernel.org

Thomas Tsai wrote:
> Hi,
> 
> Does anyone familiar with SiliconImage 3132 SATA controller?
> I'm running siliconimage 3132 as e-Sata controller on my ARM-based board.
> My kernel version is 2.6.18.6. I built libata and sata_sil24 as kernel
> module.
> After I insert libata and sata_sil24 module, and plug external
> harddrive via e-Sata.
> sata_sil24.c can detect phy changed, and found a ATA device.
> And then it will issue IDENTIFY(0xec) command but time out to get
> command completion.
> And Sil3132 seems dead or enter into an unknown state.Since it will
> not issue any interrupts even I remove and replug the e-Sata cable.
> Does anyone have experienced this situation, or any suggestion.
> Thanks.

You need to post the kernel log at least.

-- 
tejun
