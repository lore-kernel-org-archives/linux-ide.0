From: Tejun Heo <tj@kernel.org>
Subject: Re: Long delays while hibernating
Date: Wed, 23 Dec 2009 16:47:05 +0900
Message-ID: <4B31CAF9.8070104@kernel.org>
References: <74fd948d0912221950m1ade8475pfe3ec3018e14d834@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49395 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbZLWHnk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Dec 2009 02:43:40 -0500
In-Reply-To: <74fd948d0912221950m1ade8475pfe3ec3018e14d834@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pedro Ribeiro <pedrib@gmail.com>
Cc: linux-ide@vger.kernel.org

On 12/23/2009 12:50 PM, Pedro Ribeiro wrote:
> Hi,
> 
> I have a 2.6.32.2 kernel with the TuxOnIce and KDB patches. When I
> hibernate, the penultimate phase is the "Atomic copy/restore". On
> normal conditions, this takes 1 second or less.
> 
> I have a Thinkpad T400 with an ultrabay, which is a hot-swappable
> drive enclosure, which can take in an optical drive (my case), hard
> disk or extra battery.
> To save some battery, I use the script here
> http://www.thinkwiki.org/wiki/How_to_hotswap_UltraBay_devices#Script_for_Ultrabay_eject
> to power off the ultrabay.
> 
> Then when I hibernate with the ultrabay powered off, the "Atomic
> copy/restore" phase takes 30 seconds and sometimes even a hard lockup
> occurs.
> Just at the start of "Atomic copy/restore", the drive gets polled (the
> light flashes for a second and makes some loading noise) and then
> takes the CPU to 100% (I can hear the fan roar) for 30 seconds.
> 
> I'm sure this is related to the fact that the ultrabay is powered off.
> There nothing else that triggers this.
> 
> I tried using KDB to interrupt during this phase but that doesn't
> work. Only after the operation is complete KDB jumps in, so there is
> no way to interrupt whatever is happening.
> 
> I reported this issue to the TuxOnIce developer, and he asked me to
> report it to you.

Can you please attach the output of dmidecode?

Thanks.

-- 
tejun
