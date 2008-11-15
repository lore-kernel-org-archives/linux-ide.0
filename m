From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: sata_mv, io stucks
Date: Sat, 15 Nov 2008 18:52:24 -0500 (EST)
Message-ID: <alpine.DEB.1.10.0811151848150.27937@p34.internal.lan>
References: <48F88449.1000704@ngs.ru> <49003B9C.1010303@ngs.ru> <4900A12F.3030307@rtr.ca> <491EE84B.1010600@gmail.com> <491F4096.9090701@rtr.ca> <491F5E42.8010906@gmail.com> <alpine.DEB.1.10.0811151843520.27937@p34.internal.lan>
 <491F5F87.8060200@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lucidpixels.com ([75.144.35.66]:43685 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346AbYKOXwZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Nov 2008 18:52:25 -0500
In-Reply-To: <491F5F87.8060200@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harri Olin <harri.olin@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org



On Sun, 16 Nov 2008, Harri Olin wrote:

> Justin Piszcz wrote:
>> 
>> 
>> On Sun, 16 Nov 2008, Harri Olin wrote:
>> 
>>> Mark Lord wrote:
>>>> Harri Olin wrote:
>>>>> Mark Lord wrote:
>>>>>>>> Two marvell controllers, 16 disks, software raid10, IO stucks on 
>>>>>>>> different disks, kernel 2.6.26.5.
>>>>>>>> With default ubuntu's 8.04 2.6.24 kernel the problem can not be 
>>>>>>>> repeated
>> 
>> What type of disks are you using?
>> 
>> Justin.
> I have seen this happening on on 3 different computers using WD5000ABYS, 
> WD5000YS and WD7500AYYS hard disks. All have same Supermicro controller. 
> Stalls happen only on controller ports 0-3, never on ports 4-7. Moving cables 
> around doesn't help.

I have been compiling my own list of reports on this problem:

Bug 462425 -  Kernel 2.6.26.3-29.fc9.x86_64 drive goes offline
https://bugzilla.redhat.com/show_bug.cgi?id=462425

hardy / ibex - raid5 - ata#: hard resetting link  [edit]
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/263160/

exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
http://groups.google.com/group/linux.kernel/browse_thread/thread/8f3c7ea69a900e51?q="exception+Emask+0x0+SAct"

Harri,

That is interesting that it never happens on port 4-7.  I have two machines,
each with Sil 3132 cards, sata_mv and Intel ICH8 and the same problem happens
across all (12) Velociraptors, I have RMA'd 8 disks so far.  It also happens on
my Raptor 150s in a different box, but MUCH less.  I am currently testing
a patch from Alan Cox and will report if/when the problem recurs:

Subject: [PATCH] libata: Drain data on errors

From: Alan Cox <alan@redhat.com>

If the device is signalling that there is data to drain after an error we
should read the bytes out and throw them away. Without this some devices
and controllers get wedged and don't recover.

Based on earlier work by Mark Lord

Signed-off-by: Alan Cox <alan@redhat.com>
---

  drivers/ata/libata-sff.c  |   44 +++++++++++++++++++++++++++++++++++++++++++-
  drivers/ata/pata_pcmcia.c |   34 +++++++++++++++++++++++++++++++++-
  include/linux/libata.h    |    3 +++
  3 files changed, 79 insertions(+), 2 deletions(-)

Justin.

