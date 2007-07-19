From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata [ata_piix] still no resume from S3 ?
Date: Thu, 19 Jul 2007 18:26:34 +0900
Message-ID: <469F2E4A.1020502@gmail.com>
References: <20070712162450.GA7132@0x82.com> <469744DB.5070600@gmail.com> <20070714210117.GA20723@0x82.com> <469DD216.5040305@gmail.com> <20070719092053.GA21254@0x82.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:34375 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760665AbXGSJ0n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jul 2007 05:26:43 -0400
Received: by wa-out-1112.google.com with SMTP id v27so554227wah
        for <linux-ide@vger.kernel.org>; Thu, 19 Jul 2007 02:26:42 -0700 (PDT)
In-Reply-To: <20070719092053.GA21254@0x82.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?R=FAben_Fonseca?= <krani1@0x82.com>
Cc: Linux Kernel Mailling List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

R=FAben Fonseca wrote:
> On Wed, 18 Jul 2007, Tejun Heo wrote:
>=20
>>> irq 23: nobody cared (try booting with the "irqpool" option)
>>>  __report_bad_irq
>>>  note_interrupt
>>>  handle_IRQ_event
>>>  handle_fasteoi_irq
>>>  do_IRQ
>>>  do_IRQ
>>>  irq_exit
>>>  smp_acpi_timer
>>>  common_interrupt
>>>  acpi_pm_read
>>>  getnstimeofday
>>>  ktime_get_ts
>>>  ktime_egt
>>>  tick_nohz_restart_sched_tick
>>>  cpu_idle
>>>  start_kernel
>>>  unkown_bootoption
>>>  =3D=3D=3D=3D=3D
>>> handlers:
>>>  (ata_interrupt [libata])
>>>  (tifm_7xx1_isr [tifm_7xx1])
>>> Disabling IRQ #23
>>> (...)
>>> ATA: abnormal status 0x7F on port 0x000118cf
>>>
>>> And hard drive never cames up.. have to hard reboot the machine..
>>> Does it help?
>> Hmmm... That's 'nobody cared' during resume.  Please post the result=
 of
>> 'lspci -nnvvv'.
>=20
> 09:04.2 Mass storage controller [0180]: Texas Instruments 5-in-1 Mult=
imedia Card Reader (SD/MMC/MS/MS PRO/xD) [104c:803b]
> 	Subsystem: Sony Corporation Unknown device [104d:81e6]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <=
TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 57 (1750ns min, 1000ns max), Cache Line Size: 64 bytes
> 	Interrupt: pin C routed to IRQ 23
> 	Region 0: Memory at dc004000 (32-bit, non-prefetchable) [size=3D4K]
> 	Capabilities: [44] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+=
,D3cold-)
> 		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

Does the problem still occur if you disable the card reader?

--=20
tejun
