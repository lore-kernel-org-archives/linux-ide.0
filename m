From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
Subject: Re: libata interface fatal error
Date: Mon, 18 Jun 2007 21:54:33 +0300 (EEST)
Message-ID: <43261.192.168.9.10.1182192873.squirrel@ncircle.nullnet.fi>
References: <200706180705.l5I75U6r000348@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:54088 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764029AbXFRSyn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 14:54:43 -0400
In-Reply-To: <200706180705.l5I75U6r000348@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: htejun@gmail.com, florian@effenberger.org, jeff@garzik.org, linux-ide@vger.kernel.org, mikpe@it.uu.se


> On Mon, 18 Jun 2007 15:28:44 +0900, Tejun Heo wrote:
>> Yeah, it seems promise has some problem with 3G link.  Cc'ing Mikael
>> Pettersson and quoting whole body for him.  Mikael, does this look
>> familiar?
>>
>> Tomi Orava wrote:
>> > Hi Tejun,
>> >
>> > I've been trying to find a solution for a long time for quite a
>> similar
>> > libata errror messages as shown in this thread. Perhaps you might get
>> have
>> > some ideas what the actual originator might be:
>> >
>> > With the latest 2.6.22-rc4-git4 kernel I still get the following error
>> > messages
>> > with high I/O load:

<snip>

>> > and the problems relate only to Seagate 7200.10 SATA-disks, never with
>> the
>> > older 7200.7 SATA-disks alll connected to Promise Sata
>> 300TX4-controller.
> ...
>> > PS. These problems are not special to this single machine as a friend
>> at work
>> >       has the same Promise Sata300TX4 card with exactly the same
>> Seagate
>> > 7200.10
>> >       SATA-disks on an intel-based P4 machine with similar problems
>> under
>> > I/O-load.
>
> Yes, this is familiar. Several people have reported problems with
> Seagate's 7200.10 disks in 3Gbps operation on sata_promise.
> Unfortunately the error reports don't really give a clue as to what
> the root cause is.
>
> I used to be able to forcibly trigger similar errors with their
> 7200.9 disks, but I can't seem to do that any more.

Hmm, are you really sure that this is 3Gbps mode related ?
I'm wondering about that as the problem is there no matter if the
1.5Gbps jumper is set on the 7200.10 disks or not. Also I retested
your older sata_promise 1.5Gbps speed limit patch and it did not
fix the problem. This is really strange!

I've now connected the problematic two 7200.10 disks into Via VT6420
controller and the problem has been fixed for me (for now). It would be great
to figure out what is the actual problem here though ...

Regards,
Tomi Orava

-- 
Tomi.Orava@ncircle.nullnet.fi

