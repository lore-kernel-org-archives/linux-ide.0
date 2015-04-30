From: Tim Small <tim@seoss.co.uk>
Subject: Re: printouts about removable disk in the kernel log
Date: Thu, 30 Apr 2015 10:49:47 +0100
Message-ID: <5541FABB.3060702@seoss.co.uk>
References: <CAL_Kpj2BAO781yXF-q2Q1AHoxXZpSXeOHfxDc7uoyeEURJZ5qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecuredomains.com ([78.47.251.4]:34929 "EHLO
	relay1.allsecuredomains.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750801AbbD3KK6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Apr 2015 06:10:58 -0400
In-Reply-To: <CAL_Kpj2BAO781yXF-q2Q1AHoxXZpSXeOHfxDc7uoyeEURJZ5qg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexey Orishko <alexey.orishko@gmail.com>, linux-ide@vger.kernel.org

On 28/04/15 16:49, Alexey Orishko wrote:

> [334203.113976] ata4: hard resetting link
> [334203.836637] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ..
> 
> When a removable disk is connected, kernel log is overwhelmed with
> messages about
> disk and its partition like in example above. Messages in the kernel
> log stop after disk
> was removed (ejected). The messages are not really informative and I
> wonder if they can be
> switched off.


Doing something like:

echo 1 > /sys/block/sdc/device/delete

prior to unplugging the drive will reduce messages on unplug (and will
also spin down the disk etc.).  On some kernel versions it will also
stop the kernel speed limiting the interface (if that's a concern).

Personally I use something like "logcheck" to handle this sort of thing,
and add exclusion patterns for stuff I don't want to hear about.

Tim.

