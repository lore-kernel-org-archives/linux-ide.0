From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: Recommended SATA controller?
Date: Mon, 08 Mar 2004 10:26:07 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <opr4jdttniq1sf88@mail.broadpark.no>
References: <opr4idafayq1sf88@mail.broadpark.no> <404B93D9.5090402@stesmi.com> <404B9500.9060706@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.broadpark.no ([217.13.4.2]:4307 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S262328AbUCHJWJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Mar 2004 04:22:09 -0500
In-Reply-To: <404B9500.9060706@stesmi.com>
List-Id: linux-ide@vger.kernel.org
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: linux-ide@vger.kernel.org

On Sun, 07 Mar 2004 22:32:48 +0100, Stefan Smietanowski 
<stesmi@stesmi.com> wrote:

> Stefan Smietanowski wrote:
>
>> Arve Knudsen wrote:
>>
>>> Hi
>>>
>>> As it seems the Silicon Image driver won't be radically improved 
>>> anytime soon(?), I'm thinking of purchasing a dedicated SATA 
>>> controller. Can anyone recommend me a fairly cheap 2-port controller 
>>> that's known to work well with Linux (2.6-series)? Stability is 
>>> imperative, I just had a solid freeze and I'm afraid it might have to 
>>> do with disk activity (playing MP3s while compiling). Might Promise 
>>> (Ultra 150) or Adaptect (1210 SA) be worth considering?
>>
>>
>> I sent a list the other day about my harddrives dieing on me and after
>> following up my search I came across that there is some kind of either
>> driver or hardware error on the VIA 8237 controller's SATA part, but
>> ONLY if you run it in "DISK" mode. It works fine in "RAID" mode.
>>
>> I can't give you specifics on what works or doesn't as I've only tried
>> 2.4 so far but the promise one seems to work fine for me in 2.4 right
>> now.
>>
>> So stay away from the 8237 in case you decide to get a motherboard with
>> SATA on instead (not much more expensive really than getting a seperate
>> SATA PCI card.
>
> Specifically three identical hard drives died on me in case you missed
> the email, all in the same way. Low level formatting them cured two
> but not the third. It is being RMA'd as we speak.
>
> The problem is not only with Maxtor harddrives (as it was with me) but
> with all brands. Drives that have died that I have read about are
> WD, Maxtor and Seagate. I can't remember if Hitachi was on the list or
> not but I wouldn't touch Hitachi (ex-IBM) with a 10 foot pole so that's
> why I don't remember. Many people have seen the same problem as I did.
> Some could use powermax to lowlevel the drive and some couldn't.
> Using a different controller with the lowlevel formatted drive seems
> to work for others as it does for me.
This sounds ugly indeed, I never quite trusted VIA (I have an nVidia based 
board right now). If I recall correctly, there was a corruption issue with 
VIA ATA controllers in the past? I think I'll go with a separate Promise 
card, its difficult to find a cheap mobo with anything but Via or SiI SATA 
anyway.

Regards

Arve Knudsen
