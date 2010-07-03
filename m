From: Tejun Heo <tj@kernel.org>
Subject: Re: Drives missing at boot
Date: Sat, 03 Jul 2010 18:01:15 +0200
Message-ID: <4C2F5ECB.1040505@kernel.org>
References: <AANLkTimVkG9TFgyOTTnrztBjqT4JoOzFaP268vWLAAm9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54257 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753216Ab0GCQBR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Jul 2010 12:01:17 -0400
In-Reply-To: <AANLkTimVkG9TFgyOTTnrztBjqT4JoOzFaP268vWLAAm9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Knecht <markknecht@gmail.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

(cc'ing linux-ide)

On 07/02/2010 07:56 PM, Mark Knecht wrote:
> Hi,
>    I have a newish machine - maybe 3 months old - which unreliably
> finds its disk drives at each boot. Probably 40% of the time booting 1
> or more drives will be missing.
> 
>    So far I've been unable to determine what might be wrong. Sometimes
> it finds all 5 drives, sometimes only 4 or 3 drives. It's not always
> the same drives that are missing. Shown below are two successive warm
> boots. The machien had been running with all 5 drives working. The
> first time through it missed both /dev/sdd and /dev/sde while the very
> next time it found all 5 drives. Each of the 5 drives has been missing
> one or more times at different boots. (I.e. - it's not always drive
> sdd for instance.)
> 
>    Every time I boot the AMI BIOS screen says all 5 drives are there.
> I have found that if I drop into BIOS before going to grub that
> selecting each drive one at a time and reading through it's setup
> seems to make the boot more reliable, but not 100%. Probably 80%
> reliable.
> 
>    I don't know what info is required to look at this. I'm running the
> newest Gentoo kernel but it's been happening with all kernels I've
> tried since I built the machine. I'm attaching the kernel config as
> well as dmesg from the last boot which had all the drives. The only
> difference in dmesg when the drives don't show up (that I've spotted)
> is that the missing drive just isn't in dmesg. (I.e. no error messages
> that I could spot.)
> 
>    Let me know what I might try or what other info you might want. The
> motherboard is an Asus Rampage II Extreme with an i7-980x 6 core/12
> thread processor. sda, sdb & sdc are part of a RAID1, sdd & sde are
> part of a RAID0.

Can you please *attach* full logs of a successful boot and several
failing boots?

Thanks.

-- 
tejun
