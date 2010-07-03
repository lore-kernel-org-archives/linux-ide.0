From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: Re: Drives missing at boot
Date: Sat, 03 Jul 2010 14:42:10 -0500
Message-ID: <4C2F9292.708@hardwarefreak.com>
References: <AANLkTimVkG9TFgyOTTnrztBjqT4JoOzFaP268vWLAAm9@mail.gmail.com>	<4C2F5ECB.1040505@kernel.org>	<AANLkTinBn35687znO2_IxI3s1opkXrG2HpCRgsejNbMq@mail.gmail.com>	<4C2F87C1.8000701@hardwarefreak.com> <AANLkTimVJEO-yF3GZ2ghX6DNPuAu-A-MNNO9x8Q1EpRc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:52478 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755776Ab0GCTmM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Jul 2010 15:42:12 -0400
In-Reply-To: <AANLkTimVJEO-yF3GZ2ghX6DNPuAu-A-MNNO9x8Q1EpRc@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Knecht <markknecht@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Mark Knecht put forth on 7/3/2010 2:21 PM:

> Note two things:
> 
> 1) All the drives are always reported by BIOS at boot time. Now, that
> doesn't guarantee that the drives spin up. It may only mean they can
> be read by BIOS, but they are there as far as I can tell. They show up
> in the boot screens and in BIOS itself if I drop in to play with
> settings.

I missed that.  I thought I read it was both.  My bad.

> QUESTION: There are some settings in BIOS for delaying the drive. (Or
> something. I'm using the machine and not in BIOS) There were settings
> from 0 to 35 seconds if I remember correctly. Possibly I should try
> setting each drive to a different value to different value to stagger
> power up?

If that PSU meets published specs you shouldn't need delayed spin up with
those 5 drives.

> If you need more info or have other ideas please let me know.

Your answers here should have pretty much eliminated hardware issues as the
cause, unless that particular mobo has BIOS or other issues I'm unaware of.

I've found it's always best to ask about hardware with this kind of report
just to eliminate possibilities.  All that gear is good quality stuff.  If the
problem is due to hardware, it's because one of your components is defective,
but we don't see evidence of that at this point.

Also, TTBOMK, if a SATA drive motor doesn't spin up, the drive firmware won't
report the drive as ready upstream, thus the BIOS won't list the drive.

-- 
Stan


