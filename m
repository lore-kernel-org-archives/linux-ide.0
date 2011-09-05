From: Eric Miao <eric.miao@linaro.org>
Subject: Re: [PATCH V7 1/5] AHCI Add the AHCI SATA feature on the MX53 platforms
Date: Mon, 5 Sep 2011 11:06:56 -0700
Message-ID: <CAMPhdO95Raw+U5z-mcOzD+xb7r5Zp2nciwSizdpYWB-j-aq=4g@mail.gmail.com>
References: <1314698171-7937-1-git-send-email-richard.zhu@linaro.org>
 <CAODfWeEm8bkySXxb1qopbH1VMu-V+33k5x+0+qjABzesT0amOA@mail.gmail.com>
 <CAJNCFV+XFGEba1J2dXDa4YVwqduAPV5y=5JYEXAZ0uv+S60vvw@mail.gmail.com>
 <CAODfWeEueF45_yvPV5Zxbva6K2gEfKZbY2qoqySYFPZWnSgLsg@mail.gmail.com> <CAJNCFVLP7gA_7vBjwVNkQaSg8LZ4hROLdNCx8SBVah=F1ptrhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:45060 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833Ab1IESHR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Sep 2011 14:07:17 -0400
Received: by vxi9 with SMTP id 9so4020726vxi.19
        for <linux-ide@vger.kernel.org>; Mon, 05 Sep 2011 11:07:16 -0700 (PDT)
In-Reply-To: <CAJNCFVLP7gA_7vBjwVNkQaSg8LZ4hROLdNCx8SBVah=F1ptrhQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hector Oron <hector.oron@gmail.com>, Richard Zhu <richard.zhu@linaro.org>
Cc: eric@eukrea.com, Wolfram Sang <w.sang@pengutronix.de>, linux-ide@vger.kernel.org, kernel@pengutronix.de, avorontsov@ru.mvista.com, jgarzik@pobox.com, linux-arm-kernel@lists.infradead.org

Hi Hector,

I don't have this issue either. Could you verify it's caused by somethi=
ng else?
You may try a different SSD.

- eric

On Wed, Aug 31, 2011 at 8:09 PM, Richard Zhu <richard.zhu@linaro.org> w=
rote:
> Hi Hector:
> What's happen before "> [ =C2=A0 =C2=A07.073106] EXT4-fs (sda2): re-m=
ounted.
> Opts: errors=3Dremount-ro"?
> I re-based the patches to Sascha's imx-features branch, my sata devic=
e can work.
> Test sw environment: =C2=A0Sascha's imx-features branch,
> Test hw environment: iMX53 loco board, 32G sandisk ssd, tftp download
> the kernel image,
> =C2=A0and the nfs type rootfs is mounted.
>
> loop: module loaded
> ahci: SSS flag set, parallel bus scan disabled
> ahci imx53-ahci.0: AHCI 0001.0100 32 slots 1 ports 3 Gbps 0x1 impl pl=
atform mode
> ahci imx53-ahci.0: flags: ncq sntf stag pm led clo only pmp pio slum =
part ccc
> scsi0 : ahci_platform
> ata1: SATA max UDMA/133 mmio [mem 0x10000000-0x10000fff] port 0x100 i=
rq 28
> FEC Ethernet Driver
> fec_enet_mii_bus: probed
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> Initializing USB Mass Storage driver...
> usbcore: registered new interface driver usb-storage
> USB Mass Storage support registered.
> mousedev: PS/2 mouse device common for all mice
> input: mma8450 as /devices/virtual/input/input0
> i2c /dev entries driver
> imx2-wdt imx2-wdt.0: IMX2+ Watchdog Timer enabled. timeout=3D60s (now=
ayout=3D0)
> sdhci: Secure Digital Host Controller Interface driver
> sdhci: Copyright(c) Pierre Ossman
> sdhci-pltfm: SDHCI platform and OF driver helper
> mmc0: no vmmc regulator found
> mmc0: SDHCI controller on sdhci-esdhc-imx53.0 [sdhci-esdhc-imx53.0] u=
sing DMA
> mmc1: no vmmc regulator found
> mmc1: SDHCI controller on sdhci-esdhc-imx53.2 [sdhci-esdhc-imx53.2] u=
sing DMA
> usbcore: registered new interface driver usbhid
> usbhid: USB HID core driver
> TCP cubic registered
> NET: Registered protocol family 17
> Registering the dns_resolver key type
> VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev=
 2
> input: gpio-keys as /devices/platform/gpio-keys/input/input1
> drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
> eth0: Freescale FEC PHY driver [SMSC LAN8710/LAN8720]
> (mii_bus:phy_addr=3D1:00, irq=3D-1)
> mmc0: host does not support reading read-only switch. assuming write-=
enable.
> mmc0: new high speed SDHC card at address 0001
> mmcblk0: mmc0:0001 00000 3.79 GiB
> =C2=A0mmcblk0: p1 p2 p3
> ata1: softreset failed (device not ready)
> ata1: applying PMP SRST workaround and retrying
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: ATA-8: SanDisk SSD P4 32GB, SSD 8.00, max UDMA/133
> ata1.00: 62533296 sectors, multi 1: LBA48
> ata1.00: configured for UDMA/133
> scsi 0:0:0:0: Direct-Access =C2=A0 =C2=A0 ATA =C2=A0 =C2=A0 =C2=A0San=
Disk SSD P4 3 SSD =C2=A0PQ: 0 ANSI: 5
> sd 0:0:0:0: [sda] 62533296 512-byte logical blocks: (32.0 GB/29.8 GiB=
)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
> =C2=A0sda: sda1 sda2
> sd 0:0:0:0: [sda] Attached SCSI disk
> PHY: 1:00 - Link is Up - 100/Full
> Sending DHCP requests ., OK
>
> Best Regards
> Richard Zhu
>
> On 31 August 2011 20:57, Hector Oron <hector.oron@gmail.com> wrote:
>> Hello,
>>
>> 2011/8/31 Richard Zhu <richard.zhu@linaro.org>:
>>> Hi Hector:
>>> Thanks for your help to tests these patches.
>>
>> Note I rebased this patches against 'imx-features' branch on Sascha'=
s tree.
>> I am noticing some obscure (to me) messages from kernel:
>>
>> [ =C2=A0 =C2=A06.874694] Adding 9767516k swap on /dev/sda3. =C2=A0Pr=
iority:-1
>> extents:1 across:9767516k
>> [ =C2=A0 =C2=A07.073106] EXT4-fs (sda2): re-mounted. Opts: errors=3D=
remount-ro
>> [ =C2=A0 =C2=A07.708399] ata1.00: exception Emask 0x12 SAct 0x3 SErr=
 0x1280500
>> action 0x6 frozen
>> [ =C2=A0 =C2=A07.716219] ata1.00: irq_stat 0x08000000, interface fat=
al error
>> [ =C2=A0 =C2=A07.722216] ata1: SError: { UnrecovData Proto 10B8B Bad=
CRC TrStaTrns }
>> [ =C2=A0 =C2=A07.728780] ata1.00: failed command: READ FPDMA QUEUED
>> [ =C2=A0 =C2=A07.733995] ata1.00: cmd 60/00:00:f2:11:32/01:00:00:00:=
00/40 tag 0
>> ncq 131072 in
>> [ =C2=A0 =C2=A07.734002] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res 40/00=
:04:f2:11:32/00:00:00:00:00/40 Emask
>> 0x12 (ATA bus error)
>> [ =C2=A0 =C2=A07.749468] ata1.00: status: { DRDY }
>> [ =C2=A0 =C2=A07.753176] ata1.00: failed command: READ FPDMA QUEUED
>> [ =C2=A0 =C2=A07.758356] ata1.00: cmd 60/18:08:c2:14:32/00:00:00:00:=
00/40 tag 1
>> ncq 12288 in
>> [ =C2=A0 =C2=A07.758363] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res 40/00=
:04:f2:11:32/00:00:00:00:00/40 Emask
>> 0x12 (ATA bus error)
>> [ =C2=A0 =C2=A07.773739] ata1.00: status: { DRDY }
>> [ =C2=A0 =C2=A07.777448] ata1: hard resetting link
>> [ =C2=A0 =C2=A08.750427] ata1: softreset failed (device not ready)
>> [ =C2=A0 =C2=A08.755551] ata1: applying PMP SRST workaround and retr=
ying
>> [ =C2=A0 =C2=A08.960435] ata1: SATA link up 1.5 Gbps (SStatus 113 SC=
ontrol 300)
>> [ =C2=A0 =C2=A08.981938] ata1.00: configured for UDMA/133
>> [ =C2=A0 =C2=A08.986535] ata1: EH complete
>> [ =C2=A0 12.147912] eth0: Freescale FEC PHY driver [Generic PHY]
>> (mii_bus:phy_addr=3D1:00, irq=3D-1)
>> [ =C2=A0 12.521870] ata1.00: exception Emask 0x12 SAct 0xf SErr 0x80=
0500
>> action 0x6 frozen
>> [ =C2=A0 12.529518] ata1.00: irq_stat 0x08000000, interface fatal er=
ror
>> [ =C2=A0 12.535546] ata1: SError: { UnrecovData Proto LinkSeq }
>> [ =C2=A0 12.540851] ata1.00: failed command: READ FPDMA QUEUED
>> [ =C2=A0 12.546039] ata1.00: cmd 60/00:00:a2:19:2c/01:00:00:00:00/40=
 tag 0
>> ncq 131072 in
>> [ =C2=A0 12.546046] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res 40/00:14:7=
a:aa:2c/00:00:00:00:00/40 Emask
>> 0x12 (ATA bus error)
>> [ =C2=A0 12.561519] ata1.00: status: { DRDY }
>> [ =C2=A0 12.565209] ata1.00: failed command: READ FPDMA QUEUED
>> [ =C2=A0 12.570419] ata1.00: cmd 60/00:08:1a:e9:2c/01:00:00:00:00/40=
 tag 1
>> ncq 131072 in
>> [ =C2=A0 12.570426] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res 40/00:14:7=
a:aa:2c/00:00:00:00:00/40 Emask
>> 0x12 (ATA bus error)
>> [ =C2=A0 12.585890] ata1.00: status: { DRDY }
>> [ =C2=A0 12.589578] ata1.00: failed command: READ FPDMA QUEUED
>> [ =C2=A0 12.594776] ata1.00: cmd 60/00:10:7a:aa:2c/01:00:00:00:00/40=
 tag 2
>> ncq 131072 in
>> [ =C2=A0 12.594783] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res 40/00:14:7=
a:aa:2c/00:00:00:00:00/40 Emask
>> 0x12 (ATA bus error)
>> [ =C2=A0 12.610240] ata1.00: status: { DRDY }
>> [ =C2=A0 12.613945] ata1.00: failed command: READ FPDMA QUEUED
>> [ =C2=A0 12.619118] ata1.00: cmd 60/e0:18:1a:10:2c/00:00:00:00:00/40=
 tag 3
>> ncq 114688 in
>> [ =C2=A0 12.619125] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res 40/00:14:7=
a:aa:2c/00:00:00:00:00/40 Emask
>> 0x12 (ATA bus error)
>> [ =C2=A0 12.634583] ata1.00: status: { DRDY }
>> [ =C2=A0 12.638292] ata1: hard resetting link
>> [ =C2=A0 13.790424] ata1: softreset failed (device not ready)
>> [ =C2=A0 13.795543] ata1: applying PMP SRST workaround and retrying
>> [ =C2=A0 14.000437] ata1: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =C2=A0 14.021749] ata1.00: configured for UDMA/133
>> [ =C2=A0 14.026836] ata1: EH complete
>> [ =C2=A0 14.140774] PHY: 1:00 - Link is Up - 100/Full
>>
>>
>> Best regards,
>> --
>> =C2=A0H=C3=A9ctor Or=C3=B3n =C2=A0-.. . -... .. .- -. =C2=A0 -.. . .=
=2E.- . .-.. --- .--. . .-.
>>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
