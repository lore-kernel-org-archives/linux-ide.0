From: Richard Kang <turquesa@malgn.com>
Subject: Re: qc timeout on a marvell 88F6282 board
Date: Wed, 06 Jul 2011 15:43:27 +0900
Message-ID: <4E14040F.9030503@malgn.com>
References: <4E0AEAB1.4090106@malgn.com>	<CAMAG_ef0y=Jg=8eQSWj_e8kwGAtFwJXsvPATiL1fkq57kVzubA@mail.gmail.com>	<4E12CAD1.3030302@malgn.com> <CAMAG_efStJsEeZrdf-eSq89aHrji3t5+RYO+arrUYiAQpn7LgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [125.7.223.35] ([125.7.223.35]:58149 "EHLO mail.malgn.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752038Ab1GFGna (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Jul 2011 02:43:30 -0400
In-Reply-To: <CAMAG_efStJsEeZrdf-eSq89aHrji3t5+RYO+arrUYiAQpn7LgQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: linux-ide@vger.kernel.org, =?UTF-8?B?6rCV7YOc7ISx?= <kangts@malgn.com>

2011-07-05 =EC=98=A4=ED=9B=84 7:11, saeed bishara =EC=93=B4 =EA=B8=80:
> On Tue, Jul 5, 2011 at 11:26 AM, Richard Kang<turquesa@malgn.com>  wr=
ote:
>>> 2011/6/29 Richard Kang<turquesa@malgn.com>:
>>>> Hello.
>>>>
>>>> I have a sil3132 pci-e card and a DB-88F6282-A-BP(Marvell developm=
ent
>>>> board based on Arm9).
>>>> I compiled sata_sil24 driver as a module with a cross-compiler.
>>>>
>>>> But, when loading the driver, qc timeout error was occurred during
>>>> ata_read_dev_id.
>>>> What is wrong, IRQ or DMA ?
>>> looks to me this is DMA issue, can you force pio mode? you can do t=
hat
>>> by adding "libata.dma=3D0" to the kernel command line.
>>> saeed
>>>
>>>> I have 2.6.31.8
>> Dear saeed,
>>
>> I excuted libata.dma=3D0 through "$modprobe libata dma=3D0"
>> Then I excuted "$modprobe sata_sil24"
>>
>> But, result is same as before.
>> I think sata_sil24 supports only dma not pio, right?
> I don't think so.
> can you check if interrupts working fine?
> you can test that by loading the driver without any connected disk,
> then check if the controller raises any interrupt from
> /proc/interrupts when plugging a disk,
> saeed
>
Dear saeed,

As your instructions, I checked interrupt.
At first, I load a sata_sil24 driver without a disk. (I added the log.)

-----------------------------------------------------------------------=
---------
sil24_init_one: @@@ ENTER
(arch/arm/mm/ioremap.c) __arm_ioremap: phys_addr=3De8084000
(arch/arm/mm/ioremap.c) __arm_ioremap_pfn: addr=3De0a22000
(arch/arm/mm/ioremap.c) __arm_ioremap: phys_addr=3De8080000
(arch/arm/mm/ioremap.c) __arm_ioremap_pfn: addr=3De0a28000
ata_host_alloc: ### ENTER: max_ports=3D2
ata_port_alloc: ENTER
(libata-core.c) ata_link_init
ata_dev_init: (libata-core.c) ENTER
ata_dev_init: (libata-core.c) LEAVE
ata_dev_init: (libata-core.c) ENTER
ata_dev_init: (libata-core.c) LEAVE
ata_port_alloc: LEAVE
ata_port_alloc: ENTER
(libata-core.c) ata_link_init
ata_dev_init: (libata-core.c) ENTER
ata_dev_init: (libata-core.c) LEAVE
ata_dev_init: (libata-core.c) ENTER
ata_dev_init: (libata-core.c) LEAVE
ata_port_alloc: LEAVE
ata_host_alloc: ### LEAVE
sil24_init_one: DMA_MASK_64 rc=3D0
sil24_init_controller: =3D=3D=3D ENTER : sil24_init_controller
sil24_init_controller: host_base=3De0a22000 HOST_CTRL(0x40)=3D81000000
sil24_init_controller: =3D=3D=3D LEAVE: HOST_CTRL=3D1000003
sil24_init_one: @@@ LEAVE
sil24_port_start: ENTER ap=3Dd1668000 ata4294967295
sil24_port_start: kernel va=3Dffc08000 cb_dma=3D11800000
sil24_port_start: LEAVE
__ata_port_freeze: ENTER: ap=3Dd1668000
__ata_port_freeze: LEAVE: ata4294967295 port frozen
sil24_port_start: ENTER ap=3Dd164c000 ata4294967295
sil24_port_start: kernel va=3Dffc27000 cb_dma=3D117a0000
sil24_port_start: LEAVE
__ata_port_freeze: ENTER: ap=3Dd164c000
__ata_port_freeze: LEAVE: ata4294967295 port frozen
sil24_interrupt: ***** ENTER: sil24_interrupt
sil24_interrupt: host_base=3De0a22000 HOST_IRQ_STAT=3D0
sil24_interrupt: ***** LEAVE
(libata-core.c) ata_host_register *ENTER*
scsi2 : sata_sil24
scsi3 : sata_sil24
ata1: SATA max UDMA/100 host m128@0xe8084000 port 0xe8080000 irq 10
ata2: SATA max UDMA/100 host m128@0xe8084000 port 0xe8082000 irq 10
(libata-core.c) ata_host_register *LEAVE*
ata_port_schedule_eh: port EH scheduled
ata_scsi_error: ENTER
(libata-eh.c) ata_scsi_error
ata_port_flush_task: ENTER
sil24_error_handler: ENTER
sil24_init_port: +++ ENTER port_base=3De0a28000
sil24_init_port: +++ LEAVE
ata_eh_link_autopsy: ENTER
ata_eh_recover: ENTER
ata_dev_init: (libata-core.c) ENTER
ata_dev_init: (libata-core.c) LEAVE
__ata_port_freeze: ENTER: ap=3Dd1668000
__ata_port_freeze: LEAVE: ata1 port frozen
sil24_thaw: ENTER
sil24_thaw: LEAVE: irq_enabled=3D8d3
ata_eh_thaw_port: ata1 port thawed
ata_std_postreset: ENTER
ata1: SATA link down (SStatus 0 SControl 0)
ata_std_postreset: EXIT
ata_eh_revalidate_and_attach: ENTER
ata_eh_recover: EXIT, rc=3D0
sil24_error_handler: LEAVE
ata_scsi_error: EXIT
ata_port_schedule_eh: port EH scheduled
ata_scsi_error: ENTER
(libata-eh.c) ata_scsi_error
ata_port_flush_task: ENTER
sil24_error_handler: ENTER
sil24_init_port: +++ ENTER port_base=3De0a2a000
sil24_init_port: +++ LEAVE
ata_eh_link_autopsy: ENTER
ata_eh_recover: ENTER
ata_dev_init: (libata-core.c) ENTER
ata_dev_init: (libata-core.c) LEAVE
__ata_port_freeze: ENTER: ap=3Dd164c000
__ata_port_freeze: LEAVE: ata2 port frozen
sil24_thaw: ENTER
sil24_thaw: LEAVE: irq_enabled=3D8d3
ata_eh_thaw_port: ata2 port thawed
ata_std_postreset: ENTER
ata2: SATA link down (SStatus 0 SControl 0)
ata_std_postreset: EXIT
ata_eh_revalidate_and_attach: ENTER
ata_eh_recover: EXIT, rc=3D0
sil24_error_handler: LEAVE
ata_scsi_error: EXIT
-----------------------------------------------------------------------=
---------

It seems no problem.
Then I plug a disk. Followings are debug msg of sil24_interrupt and=20
contents of /proc/interrupts.
An interrupt is occurred and no error.

-----------------------------------------------------------------------=
---------
sil24_interrupt: ***** ENTER: sil24_interrupt
sil24_interrupt: host_base=3De0a22000 HOST_IRQ_STAT=3D2
(sata_sil24.c) sil24_host_intr
(sata_sil24.c) sil24_host_intr -> sil24_error_intr
ata_port_schedule_eh: port EH scheduled
__ata_port_freeze: ENTER: ap=3Dd164c000
__ata_port_freeze: LEAVE: ata2 port frozen
sil24_interrupt: ***** LEAVE
-----------------------------------------------------------------------=
---------
sh-3.2# cat /proc/interrupts
            CPU0
   1:      20689           -  kw_tick
  10:          1           -  sata_sil24
  11:       2901           -  mv_ethernet
  19:          0           -  ehci_hcd:usb1
  21:          0           -  mvSata
  22:          0           -  cesa
  28:       2145           -  mvsdio
  29:          0           -  mv64xxx_i2c
  33:        242           -  serial
Err:          0
-----------------------------------------------------------------------=
---------

I can't find reason of not working. Please advise to me.

Thank you.
