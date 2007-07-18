From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata [ata_piix] still no resume from S3 ?
Date: Wed, 18 Jul 2007 17:40:54 +0900
Message-ID: <469DD216.5040305@gmail.com>
References: <20070712162450.GA7132@0x82.com> <469744DB.5070600@gmail.com> <20070714210117.GA20723@0x82.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:47155 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbXGRIlA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jul 2007 04:41:00 -0400
Received: by py-out-1112.google.com with SMTP id d32so226377pye
        for <linux-ide@vger.kernel.org>; Wed, 18 Jul 2007 01:41:00 -0700 (PDT)
In-Reply-To: <20070714210117.GA20723@0x82.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?R=FAben_Fonseca?= <krani1@0x82.com>
Cc: Linux Kernel Mailling List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

[cc'ing linux-ide]

R=FAben Fonseca wrote:
> On Fri, 13 Jul 2007, Tejun Heo wrote:
>=20
>> R=FAben Fonseca wrote:
>>> Hi to all!
>>>
>>> I'm on Debian Sid with kernel 2.6.21 and I still can't resume my la=
ptop
>>> (Sony Vaio SZ2) from S3. Searched on the archive and it seems that =
SATA=20
>>> drives are getting problems when used via the "new" libata. When th=
e
>>> laptop tries to resume, it can't access the hard drive anymore (the=
 LED
>>> never blinks), the filesystem is mounted read-only and of course, t=
he
>>> system hangs. I still can see a "Lost interrupt" apearing on my LCD=
 when
>>> it is resuming. Sometimes it is IRQ 22, other times it is IRQ 23.
>>>
>>> Is this still a know problem? Does 2.6.22 solve this already? If yo=
u
>>> need more information about my environment, please ask :)
>> Actually, 'lost interrupt' is from the "old" IDE driver.  Care to gi=
ve a
>> shot at the new one?
>=20
> Sorry, it was my mistake. Here's more info about the problem.
> I had to copy "by hand" the trace, so I remove the hexadecimal parts
> (if you need them, please ask i Will try to copy them too). For now
> I just want to know if you can diagnose this problem, or need more in=
fo.
> So here's the interesting (I think) part of the log after resume:
>=20
> irq 23: nobody cared (try booting with the "irqpool" option)
>  __report_bad_irq
>  note_interrupt
>  handle_IRQ_event
>  handle_fasteoi_irq
>  do_IRQ
>  do_IRQ
>  irq_exit
>  smp_acpi_timer
>  common_interrupt
>  acpi_pm_read
>  getnstimeofday
>  ktime_get_ts
>  ktime_egt
>  tick_nohz_restart_sched_tick
>  cpu_idle
>  start_kernel
>  unkown_bootoption
>  =3D=3D=3D=3D=3D
> handlers:
>  (ata_interrupt [libata])
>  (tifm_7xx1_isr [tifm_7xx1])
> Disabling IRQ #23
> (...)
> ATA: abnormal status 0x7F on port 0x000118cf
>=20
> And hard drive never cames up.. have to hard reboot the machine..
> Does it help?

Hmmm... That's 'nobody cared' during resume.  Please post the result of
'lspci -nnvvv'.

--=20
tejun
