From: =?UTF-8?B?0JTQsNC90LjQu9CwINCW0YPQutC+0YbQutC40Lk=?=
	<optimusgd@gmail.com>
Subject: Re: [Bugme-new] [Bug 13001] New: PCI-DMA: Out of IOMMU space
Date: Tue, 7 Apr 2009 16:08:55 +0500
Message-ID: <db2b43030904070408n5c82a6b2i400322f61982b28c@mail.gmail.com>
References: <20090407104905Q.fujita.tomonori@lab.ntt.co.jp>
	 <db2b43030904062205q283f64fal395e61f985a8108b@mail.gmail.com>
	 <20090407173841V.fujita.tomonori@lab.ntt.co.jp>
	 <20090407174351C.fujita.tomonori@lab.ntt.co.jp>
	 <db2b43030904070152w4314f6cif1514a583459ec27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:59932 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbZDGLI5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Apr 2009 07:08:57 -0400
Received: by fg-out-1718.google.com with SMTP id 16so364822fgg.17
        for <linux-ide@vger.kernel.org>; Tue, 07 Apr 2009 04:08:55 -0700 (PDT)
In-Reply-To: <db2b43030904070152w4314f6cif1514a583459ec27@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: alan@lxorguk.ukuu.org.uk, akpm@linux-foundation.org, linux-ide@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, x86@kernel.org

Ok, what's done.
I build kernel with CONFIG_IOMMU_LEAK and CONFIG_IOMMU_DEBUG,
forcedeth, all usb and sata stuff as modules, reboot with default
apperture, 64mb, rmmod ehci_usb, forcedeth. From sata_nv hdd /dev/sdb1
i can read 80gb data without problems, dmesg flooded with "dma_map_sg
overflow" messages. When i try write data to /dev/sdb1 computer hung
completely after one or two seconds. No oopses, clear logs, just hung
and i hardreset it.


2009/4/7 =D0=94=D0=B0=D0=BD=D0=B8=D0=BB=D0=B0 =D0=96=D1=83=D0=BA=D0=BE=D1=
=86=D0=BA=D0=B8=D0=B9 <optimusgd@gmail.com>:
> My bad, just a typo, i use 2.6.29.1 of course. My boot device 3ware
> raid, so i try isolate bug now as you say.
>
> 2009/4/7 FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>:
>> On Tue, 7 Apr 2009 17:38:30 +0900
>> FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> wrote:
>>
>>> > I can't turn on CONFIG_IOMMU_LEAK and CONFIG_IOMMU_DEBUG because
>>> > 2.6.26.1 not have such options in .config. Maybe git kernel have =
this
>>> > options?
>>>
>>> 2.6.26.1 has these options. Probably you don't enable
>>> DEBUG_KERNEL. But the feature is not much useful, as I said.
>>
>> Wait, you use 2.6.29, right?
>>
>
>
>
> --
> =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC =D0=94=D0=
=B0=D0=BD=D0=B8=D0=BB=D0=B0 =D0=96=D1=83=D0=BA=D0=BE=D1=86=D0=BA=D0=B8=D0=
=B9, =D1=81=D0=B8=D1=81=D1=82=D0=B5=D0=BC=D0=BD=D1=8B=D0=B9 =D0=B0=D0=B4=
=D0=BC=D0=B8=D0=BD=D0=B8=D1=81=D1=82=D1=80=D0=B0=D1=82=D0=BE=D1=80 =D0=97=
=D0=90=D0=9E "=D0=A0=D0=BE=D1=81=D0=BD=D0=B5=D1=84=D1=82=D0=B5=D0=B3=D0=
=B0=D0=B7=D0=BC=D0=B0=D1=88"
>
