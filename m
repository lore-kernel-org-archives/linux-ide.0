From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: Loud "pop" coming from hard drive on reboot
Date: Wed, 18 Apr 2007 17:27:03 -0400
Message-ID: <46268D27.9070809@redhat.com>
References: <88SeR-5Sf-15@gated-at.bofh.it> <46265307.7060405@rtr.ca> <46265966.1040102@redhat.com> <200704182322.20514.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:53085 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992793AbXDRV3v (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Apr 2007 17:29:51 -0400
In-Reply-To: <200704182322.20514.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Stephen.Clark@seclark.us, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, 7eggert@gmx.de, emisca <emisca.ml@gmail.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>

Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 18 April 2007, Chuck Ebbert wrote:
>> Mark Lord wrote:
>>> Mark Lord wrote:
>>>> With the patch applied, I don't see *any* new activity in those
>>>> S.M.A.R.T.
>>>> attributes over multiple hibernates (Linux "suspend-to-disk").
>>> Scratch that -- operator failure.  ;)
>>> The patch makes no difference over hibernates in the SMART logs.
>>>
>>> It's still logging extra Power-Off_Retract_Count pegs,
>>> which it DID NOT USED TO DO not so long ago.
>>>
>> Just to add to the fun, my problems are happening with the "old"
>> IDE drivers...
> 
> The issue you are experiencing results in the same problem (disk doing
> power off retract) but it has a totally different root cause - your notebook
> loses power on reboot.  It is actually a hardware problem and as you have
> reported the same problem is present when using "the other" OS.
> 

My "power off retract count" increases whether I do a halt/poweroff or
a reboot. The only difference is the volume of the noise.

And I just noticed my "seek error rate" is increasing.

/me plans purchase of another drive, definitely not Seagate...

> I think that the issue needs to be fixed (by detecting affected notebook(s)
> using DMI?) in Linux PM handling and not in IDE subsystem because:
>
> * there may be some other hardware devices affected by the power loss
>   (== they require shutdown sequence)
>
> * the same problem will bite if somebody decides to use libata (FC7?)

Yeah, this needs fixing too. I've been playing with another notebook and
the power does stay on during reboot, so I wonder how widespread the problem is?
