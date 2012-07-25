From: "Rus V. Brushkoff" <brushkoff@gmail.com>
Subject: Re: AMD SP5100 SATA low perfomance
Date: Wed, 25 Jul 2012 09:47:16 +0300
Message-ID: <CAKu2wpTFZNY4nwi47gRPbzaHUFPRfJEZa+GTgO4L=vJ-y+9gCA@mail.gmail.com>
References: <CAKu2wpS-9T+jeab4HoBozuxa-7LPVCL3+3JZok-QkTHs6CNksA@mail.gmail.com>
 <20120724204454.GC5167@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:61829 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab2GYGr6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Jul 2012 02:47:58 -0400
Received: by weyx8 with SMTP id x8so270443wey.19
        for <linux-ide@vger.kernel.org>; Tue, 24 Jul 2012 23:47:57 -0700 (PDT)
In-Reply-To: <20120724204454.GC5167@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <borislav.petkov@amd.com>
Cc: linux-ide@vger.kernel.org

 I will do the tests with another drive (from WD) today. But I've
fogot to say that I have another S8005 m/b with SP5100 that working
perfectly with these particular Hitachi drives (please see boot log
for it in dmesg-good at the same URL). So the problem can be in init
procedure for AMD south bridge or SATA controller. The differences
between m/b is very little - working has onboard audio, not working
hasn't. The diff in boot log is present too in file diff.txt

>>  I'm observing the problem with AMD SP5100 SATA controller. The
>> problem appears as very low (2-3MB/s) write perfomance. Reading drops
>> too, but not such dramatically (from 100Mb/s on other hardware to
>> 50-60Mb/s on SP5100). This problem is checked on several kernels
>> (2.6.x, 3.2.x, 3.4.x) including latest 3.5 and with all possible SATA
>> BIOS settings. The hardware is Tyan S8005 m/b (latest BIOS v1.03), AMD
>> X6 1045T, 8GB ECC memory and Hitachi HTS725050A7E630 drive.  Moreover
>> - I've checked 2 different identical boxes - it is 100% reproducable
>> on both.
>
> Have you tried doing the same test on the same mobo but with another
> drive, possibly by another manufacturer? Do you see the same write
> slowdown with the second drive too?
>
> Thanks.
>
> --
> Regards/Gruss,
>     Boris.



-- 
Rus
