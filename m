From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH 4/4 v2] Add documentation for hard disk shockprotection interface
Date: Sat, 20 Sep 2008 00:05:08 +0200
Message-ID: <87ej3f7pwr.fsf@denkblock.local>
References: <87d4j2n3dn.fsf@denkblock.local>
	<20080917163145.9870.8575.stgit@denkblock.local>
	<1221724782.3261.13.camel@raz> <87iqssmpl0.fsf@denkblock.local>
	<1221854586.7473.16.camel@raz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:41752 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbYITFyy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Sep 2008 01:54:54 -0400
In-Reply-To: <1221854586.7473.16.camel@raz> (raz ben yehuda's message of "Fri,
	19 Sep 2008 22:03:06 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: raz ben yehuda <razb@bitband.com>
Cc: linux-ide@vger.kernel.org

raz ben yehuda <razb@bitband.com> wrote:
> On Fri, 2008-09-19 at 11:50 +0200, Elias Oltmanns wrote:
>> "Raz Ben-Yehuda" <razb@bitband.com> wrote:
>> > Elias
>> > looks very interesting.
>> > 1. How will it impact VM , swappers , raids ?  
>> 
>> What exactly do you want to know? As long as the disk is parked, you can
>> do no I/O on it, i.e. no swapping is possible. Since I don't know
>> anything about the implementation of raids and don't have a raid setup
>> here, I can't really tell how a raid device will behave exactly when one
>> of its disks has been parked. Generally, all I/O will be delayed until
>> the disk is unparked again.
>> > 2. you said it has no value for servers ? did you try ?
>> 
>> Again, I'm not quite sure what you want to know. Obviously, desktops or
>> servers for that matter can have disks installed that support the unload
>> feature. On these devices you can use the interface as described in my
>> document. All I'm saying is that the interface has been designed with
>> laptops in mind because I don't see in which situation immediate head
>> unloading would be required or even desirable in a classical server
>> environment.
> I will rephrase. does head parking increase reliability ( MTBF ... MTTF ) of a disk ? 
> My servers hardly generate IOs at night times, does head parking at nights extend 
> the life of a disk ? or is it the opposite ? does it matter ?

Disk head parking is meant as a short term emergency resort. In general,
it does *not* extend the lifetime of a disk. In fact, emergency head
unloads are considered to be costly and smart even counts those events
as an aging factor. It really is just a means to prevent even worse
damage due to heavy shocks, nothing for regular maintenance.

Hope that helps,

Elias
