From: Grant Grundler <grundler@google.com>
Subject: Re: Ubuntu 9.04 (2.6.28-14) and eSATA Port Multiplier (PMP) Not
	working
Date: Mon, 17 Aug 2009 19:39:46 -0700
Message-ID: <da824cf30908171939o7110322bn993dc5d3217a4cfa@mail.gmail.com>
References: <e3fccfde0908101354y4e98a985nc119d8941e8b1665@mail.gmail.com>
	 <4A8242C5.3060605@gmail.com>
	 <e3fccfde0908121536wbacde3bt447c3b8e769f184d@mail.gmail.com>
	 <da824cf30908171425i3ec9237bi1370e71d5096c174@mail.gmail.com>
	 <e3fccfde0908171530w43f78711lea85ffa1ea26d2ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:35462 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbZHRCjs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Aug 2009 22:39:48 -0400
Received: from wpaz17.hot.corp.google.com (wpaz17.hot.corp.google.com [172.24.198.81])
	by smtp-out.google.com with ESMTP id n7I2dnei015231
	for <linux-ide@vger.kernel.org>; Mon, 17 Aug 2009 19:39:49 -0700
Received: from rv-out-0708.google.com (rvfc5.prod.google.com [10.140.180.5])
	by wpaz17.hot.corp.google.com with ESMTP id n7I2dk5a018264
	for <linux-ide@vger.kernel.org>; Mon, 17 Aug 2009 19:39:47 -0700
Received: by rv-out-0708.google.com with SMTP id c5so873027rvf.38
        for <linux-ide@vger.kernel.org>; Mon, 17 Aug 2009 19:39:46 -0700 (PDT)
In-Reply-To: <e3fccfde0908171530w43f78711lea85ffa1ea26d2ea@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chris K <kayex@rogers.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Mon, Aug 17, 2009 at 3:30 PM, Chris K<kayex@rogers.com> wrote:
>...
>>>> > I have a Silicone Image 3132 chipset (PCI-E 2-port eSATA control=
ler
>>>> > card) and a Sans Digital TRM4-B 4x hard drive enclosure
>>
>> Which PMP is in the TRM4-B HDD enclosure?
>
> After opening it up, it looks to be a Silicone Image 3726 chip.

Ok ...just some questions to pull a bit more info. Still no idea what i=
s wrong.

Can you confirm the OS is seeing as a 3726?
Add a printk to dump SATA_PMP_GSCR_PROD_ID to the console
similar to how it's done in sata_pmp_revalidate_quick().  Or if dev->gs=
cr[]
is already valid, printk dev->gscr[SATA_PMP_GSCR_PROD_ID]. This
assumesyou know how to build/install a kernel from a source tree.
Tell me if that's a bad assumption. :)

ISTR some very early 3726 devices reported themselves as 4726 or
something like that.
This can affect which sata_pmp_quirks() are applied.

BTW, the full dmesg output attached to the original mail never made it
to linux-ide mailing list...can you attach or post it someplace public?

> There's a sticker on the circuit board with "BIOS 1.0114"

Should be good. 1.0114 firmware has one problem I can't talk about now
(NDAs, etc) and is unlikely to be related to this problem.



=2E.
>> My guess is the LEDs going on and off are caused by the PMP getting =
reset
>> and not the Host OS "scanning". Are all the LEDs going on or off at
>> the same time?
>> Can you describe the on/off sequence of the LEDs?
>>
>
> Sure. The Power and "HOST" LEDs both light up, followed by LED "1"
> which is orange very briefly, green, orange briefly, green stays lit,

How long between LED 1 and LED 2?
Is the sequence different if you power off the TRM4-B and power it
on again before rebooting the host machine?

If CONFIG_PRINTK_TIME=3Dy, the dmesg output should let me figure this o=
ut.

I'm expecting some sort of "spin up delay" to take effect but offhand
don't know the code path or if it will matter for this problem.

> LED "2" orange very briefly, green stays lit, LED "3" orange very
> briefly, green stays lit, LED "4" orange very briefly, green stays li=
t
> - at this point all LEDs are on.

Ok - this does sound like ports behind the PMPs are being scanned.

> Shortly after all LEDs turn off
> together and the process repeats itself about 5 times.

Can you add debug code to dump how many ports the PMP claims to have?
I'm wondering if a "ghost port" (magic "port" which doesn't have a SATA=
 link but
some magic registers instead) is discovered/reported.

> After it
> finishes it keeps Power, HOST and "1" lit up and then I receive the
> error messages.

I suspect the PMP probe code sets up the link before exiting the error
handling loop. This would leave the link 1 (port 0 on PMP) on.

thanks,
grant

>
>> I'm hoping the would tell us more about where in the discovery proce=
ss
>> it's failing.
>> I don't even have a good guess what the problem might be.
>>
>> hth,
>> grant
>>
>
> Haha, I know the feeling. Ran out of ideas a long time ago :-). =C2=A0=
Let
> me know if there's anything else you'd like me to try or any further
> info you require.
>
> Thanks.
>
> Chris.
>
