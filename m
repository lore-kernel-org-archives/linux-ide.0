From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Wed, 09 Feb 2011 19:46:32 -0600
Message-ID: <4D534378.3050304@gmail.com>
References: <4D51A648.20707@cfl.rr.com> <20110209085935.GE6558@htj.dyndns.org> <4D52B0B3.40900@cfl.rr.com> <20110209153714.558133d7@lxorguk.ukuu.org.uk> <4D52ECB6.4010408@cfl.rr.com> <20110209214118.GA7196@atj.dyndns.org> <4D5332D2.5090701@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53068 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501Ab1BJBqh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2011 20:46:37 -0500
Received: by iyj8 with SMTP id 8so803776iyj.19
        for <linux-ide@vger.kernel.org>; Wed, 09 Feb 2011 17:46:36 -0800 (PST)
In-Reply-To: <4D5332D2.5090701@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Tejun Heo <tj@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 02/09/2011 06:35 PM, Phillip Susi wrote:
> On 02/09/2011 04:41 PM, Tejun Heo wrote:
>> So, no, the situation has always been quite muddy with HPA and if you
>> ask me it is an inherently stupid feature bound to cause problems.
>
> What problems? Other than those caused by unlocking it in the first
> place, and then upgrading?
>
>> The setting is not even bound to the hard drive. You move a hard
>> drive to a different machine, the size changes, hooray! Oh right,
>
> Unless the other machine decides to change it, then it is bound to the
> drive. It is possible that both machines will change it, but since most
> don't bother using the HPA, it tends to be preserved when moving from a
> machine that uses it to one that does not.
>
>> I think ide had it right all along. We should just have unlocked
>> things by default when HPA unlock feature was added. A lot of BIOSen
>
> Why?
>
>> To sum up, no, not unlocking HPA by default was not a conscious
>> decision and neither was some distros defaulting to unlocking it.
>> Those decisions are all made by inertia, so please stop bringing them
>> up. They don't mean much.
>
> Then why did you write a patch that seems to be a reasonable compromise
> between the two and will allow distros to stop diverging from upstream
> in this way, and are now arguing against that patch?

I'm inclined to agree. Unlocking HPA by default is opening up a 
potential can of worms and seems likely to cause regressions. This thread:

http://fossplanet.com/f10/host-protected-area-unconditional-disable-87925/

points out: "once HPA has been turned off a power cycle is needed to 
turn it back on. This can severely confuse another operating system when 
it finds the disk has changed size. In rare cases it can cause RAID 
cards to drop RAID sets on the floor thinking they are corrupt. All bad."

I don't see a case where unlocking HPA benefits us except in the case of 
upgrading from an older distro using IDE where HPA was being unlocked, 
or in the (vanishingly unlikely these days) case where the HPA is used 
to hide the drive's full capacity from the BIOS. The former case would 
be handled by the existing logic and proposed patch. The latter case can 
be handled with a module option. I don't see the benefit of playing with 
fire and shutting off HPA all the time.
