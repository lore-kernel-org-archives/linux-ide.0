From: Grant Grundler <grundler@google.com>
Subject: Re: Ubuntu 9.04 (2.6.28-14) and eSATA Port Multiplier (PMP) Not
	working
Date: Mon, 17 Aug 2009 14:25:04 -0700
Message-ID: <da824cf30908171425i3ec9237bi1370e71d5096c174@mail.gmail.com>
References: <e3fccfde0908101354y4e98a985nc119d8941e8b1665@mail.gmail.com>
	 <4A8242C5.3060605@gmail.com>
	 <e3fccfde0908121536wbacde3bt447c3b8e769f184d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:1506 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754518AbZHQVZG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Aug 2009 17:25:06 -0400
Received: from zps76.corp.google.com (zps76.corp.google.com [172.25.146.76])
	by smtp-out.google.com with ESMTP id n7HLP7xp003459
	for <linux-ide@vger.kernel.org>; Mon, 17 Aug 2009 14:25:07 -0700
Received: from rv-out-0708.google.com (rvfc5.prod.google.com [10.140.180.5])
	by zps76.corp.google.com with ESMTP id n7HLOoxj030394
	for <linux-ide@vger.kernel.org>; Mon, 17 Aug 2009 14:25:05 -0700
Received: by rv-out-0708.google.com with SMTP id c5so804505rvf.42
        for <linux-ide@vger.kernel.org>; Mon, 17 Aug 2009 14:25:04 -0700 (PDT)
In-Reply-To: <e3fccfde0908121536wbacde3bt447c3b8e769f184d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chris K <kayex@rogers.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Wed, Aug 12, 2009 at 3:36 PM, Chris K<kayex@rogers.com> wrote:
> Thanks for the reply Tejun.
>
> I gave the 2.6.30-2 kernel a try and I received the same error message
> as quoted below - it just happened a bit later on in the boot process.
> (not at the "starting.." screen)
>
> Chris.
>
> On Wed, Aug 12, 2009 at 12:19 AM, Tejun Heo <htejun@gmail.com> wrote:
>>
>> Chris K wrote:
>> > Hello Tejun,
>> >
>> > I was hoping you'd have some feedback or suggestions relating to the
>> > eSata port multiplier errors I am receiving below.
>> >
>> > I have a Silicone Image 3132 chipset (PCI-E 2-port eSATA controller
>> > card) and a Sans Digital TRM4-B 4x hard drive enclosure

Which PMP is in the TRM4-B HDD enclosure?

I'm comfortable that the SI 3132 SATA (sata_sil24 driver) works with PMPs
in kernel version 2.6.28 though I haven't tried that version specifically.

>> > with 4x 1TB WD
>> > Caviar Green drives. I am having difficulty getting drives detected with
>> > eSATA and Port Multiplier (PMP) in Ubuntu 9.04 running the
>> > 2.6.28-14-server (or generic) kernel. I've also tried
>> > 2.6.28-11-server/generic and 2.6.31-5-generic with no luck .
>> >
>> > On a Windows machine everything works correctly. When I boot my Ubuntu
>> > machine (or plug in the eSATA cable), it scans the external drives
>> > repeatedly (LEDs go on an off a number of times) and eventually times
>> > out with the following messages:

My guess is the LEDs going on and off are caused by the PMP getting reset
and not the Host OS "scanning". Are all the LEDs going on or off at
the same time?
Can you describe the on/off sequence of the LEDs?

I'm hoping the would tell us more about where in the discovery process
it's failing.
I don't even have a good guess what the problem might be.

hth,
grant
