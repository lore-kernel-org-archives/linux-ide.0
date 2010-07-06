From: Tejun Heo <tj@kernel.org>
Subject: Re: Drives missing at boot
Date: Tue, 06 Jul 2010 08:32:42 +0200
Message-ID: <4C32CE0A.3080400@kernel.org>
References: <AANLkTimVkG9TFgyOTTnrztBjqT4JoOzFaP268vWLAAm9@mail.gmail.com>	<4C2F5ECB.1040505@kernel.org>	<AANLkTinBn35687znO2_IxI3s1opkXrG2HpCRgsejNbMq@mail.gmail.com>	<4C2F87C1.8000701@hardwarefreak.com>	<AANLkTimVJEO-yF3GZ2ghX6DNPuAu-A-MNNO9x8Q1EpRc@mail.gmail.com>	<4C2F9292.708@hardwarefreak.com>	<AANLkTikPsRvvpSZirSygnZqyGKcS-Bz0eVeASZZqvZwH@mail.gmail.com>	<AANLkTintf2mwgBVuk_4GmfHTzyJebP2kyfcNGij_epy-@mail.gmail.com>	<4C31796C.8050209@kernel.org> <AANLkTinvNGha7SfaAWYIjUJwR9ZelCbHAWK0qvvllF9S@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47456 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752746Ab0GFGcw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Jul 2010 02:32:52 -0400
In-Reply-To: <AANLkTinvNGha7SfaAWYIjUJwR9ZelCbHAWK0qvvllF9S@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Knecht <markknecht@gmail.com>
Cc: Stan Hoeppner <stan@hardwarefreak.com>, Linux Kernel List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 07/05/2010 06:48 PM, Mark Knecht wrote:
>    I tried a Gentoo install CD from last march. It's a 2.6.31 type
> kernel. Problem is the buffer depths are not big enough to capture the
> complete dmesg contents and I don't know a command line option to make
> it larger on the fly. If you know of one that's got a larger buffer -
> or a command to increase it at boot time - then let me know and I'll
> try again.
> 
>    I'm attaching what I was able to catch for both AHCI and IDE
> settings in BIOS for the storage configuration option.

That's enough.

>    It seems to me that even in AHCI mode the machine does see all the
> hard drives. Maybe there's something about my boot partition that's
> having problems in AHCI mode only? If it sees /dev/sda then why
> wouldn't it find grub and at least show a grub menu?

The ahci driver is working fine.  If the system can't boot w/ ahci
mode, the problem is probably on the bios side and most likely caused
by getting the boot device wrong as Robert suggested.  Just choose one
after another until it boots should do the trick.

Thanks.

-- 
tejun
