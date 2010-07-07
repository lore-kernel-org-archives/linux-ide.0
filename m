From: Tejun Heo <tj@kernel.org>
Subject: Re: Drives missing at boot
Date: Wed, 07 Jul 2010 07:50:16 +0200
Message-ID: <4C341598.6040004@kernel.org>
References: <AANLkTimVkG9TFgyOTTnrztBjqT4JoOzFaP268vWLAAm9@mail.gmail.com>	<4C2F5ECB.1040505@kernel.org>	<AANLkTinBn35687znO2_IxI3s1opkXrG2HpCRgsejNbMq@mail.gmail.com>	<4C2F61AB.9030806@kernel.org>	<AANLkTilYOT45q8OUJ-_V61_fnYy9HIk6GAv5ZPiomCaT@mail.gmail.com>	<4C317C04.20500@kernel.org>	<AANLkTilupyieml9yaWO9BUNPmQQ0g2w1HLWj6R9MwDZf@mail.gmail.com>	<4C32CE50.6010501@kernel.org> <AANLkTikehTO1j6Gd7Y_g32_P6Yg9KB8Z8qwbNJh10aOU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41560 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937Ab0GGFuT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Jul 2010 01:50:19 -0400
In-Reply-To: <AANLkTikehTO1j6Gd7Y_g32_P6Yg9KB8Z8qwbNJh10aOU@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Knecht <markknecht@gmail.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

On 07/06/2010 08:13 PM, Mark Knecht wrote:
> OK - thanks. The patch seemed to install correctly. I then did
> 
> make clean
> make && make modules_install
> 
> and then a Gentoo command:
> 
> modules-rebuild -X rebuild
> 
> to pick up any package modules that need to be rebuild when I use a
> new kernel. (X drivers, vmware, etc.)
> 
> The kernel boots fine:
> 
> mark@c2stable ~ $ uname -a
> Linux c2stable 2.6.34-gentoo-r1 #4 SMP PREEMPT Tue Jul 6 10:35:15 PDT
> 2010 x86_64 Intel(R) Core(TM) i7 CPU X 980 @ 3.33GHz GenuineIntel
> GNU/Linux
> mark@c2stable ~ $
> 
> I don't know what I'm looking for in the dmesg files but I do see one
> message about a SATA Link being down.

Umm... the patched module isn't being loaded.  If patched, it should
be reporting whether it's hard or soft resetting and some other debug
messages.  One common mistake is not updating initrd with patched
modules.  Is "modules-rebuild -X rebuild" the command for initrd
update?

Thanks.

-- 
tejun
