Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A23C352A1
	for <linux-ide@archiver.kernel.org>; Sun,  4 Dec 2022 01:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiLDBl3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 3 Dec 2022 20:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLDBl2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 3 Dec 2022 20:41:28 -0500
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711161A815
        for <linux-ide@vger.kernel.org>; Sat,  3 Dec 2022 17:41:24 -0800 (PST)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=plP/4/+5QJfTsXa2tIoKlC5Spsj0/WR+90VLlUl19/I=;
        b=T75Xm6p99KUzjwn8+cR/2Z7fucJ2btdSqfmM41BYj2QCr0p1D7rRbBnryUKtninNPyMJ2osXUeQzP7ClkA+E/r4zF5OUJYLpIoGm/wE4JfbMAPWtZyjOM6irbw6g/HhxEmt8W5TZc3+uxS8XVRjkkZiPAOwokyUedYXchG1+qIuRRRzFAd9J15O/evl6F4Z/SAt5rydHCDFUheMe5rOvTRLx4eEEFv2OjOEaD3ciAIHC4+ogF/hhtr26yS
        d0G3yS8Zsx8kex/dRaqx2wV+zdSH5YKEL0nmWj7s6row/TmazNc+DS5KHRQh+SA8Pxqycf+wFDJ8YPzUMHiNRKfMp5Dw==
Received: from webmail.dynu.com (webmail.dynu.com [162.216.242.204])
        by mx1.wiredblade.com with ESMTPA
        ; Sun, 4 Dec 2022 01:41:20 +0000
MIME-Version: 1.0
Date:   Sun, 04 Dec 2022 01:41:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.16.0
From:   marius@psihoexpert.ro
Message-ID: <889ee9c9e77106b17ceac456e327d480@psihoexpert.ro>
Subject: Re: Bug report for ahci-mvebu driver
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>,
        "=?utf-8?B?UGFsaSBSb2jDoXI=?=" <pali@kernel.org>
Cc:     linux-ide@vger.kernel.org
In-Reply-To: <5b5d7816-5e43-88e8-1337-769cce825f78@opensource.wdc.com>
References: <5b5d7816-5e43-88e8-1337-769cce825f78@opensource.wdc.com>
 <125bd8a6-7a1c-cd08-b5ee-da5a24f79f21@opensource.wdc.com>
 <dc9f74bd-91d7-cda1-8182-11d400e6bc3f@opensource.wdc.com>
 <a1b3b74b-1548-44d9-7d72-8eb428fa1788@opensource.wdc.com>
 <0ba8ebf7-6e6c-e63d-32c4-44d97898be1d@opensource.wdc.com>
 <126ce7f2-3de2-9e75-7920-09d78c224d76@opensource.wdc.com>
 <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
 <3c94c10243fa1cd2b0128db846298a11@psihoexpert.ro>
 <13f7138c46c4c486a29322baa4cc414b@psihoexpert.ro>
 <40f4ae2000164863253c67d405e4f875@psihoexpert.ro>
 <29aff79be06b7dacb97c13cbff07fabb@psihoexpert.ro>
 <97af1ef9ed605800e6ad43b7b3518800@psihoexpert.ro>
 <aa61bc53-34e2-4f19-962f-888e9daabbb4@opensource.wdc.com>
 <C9DCFF5E79814EAB9E9BE94B81A1CD7F@graph>
X-Originating-IP: 84.232.129.15
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

November 24, 2022 4:40 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc=
.com> wrote:

> So the hardware is failing to detect the device presence. No clue why.
> Only an ATA bus trace could tell us more here (do you have an ATA bus
> analyzer around ?).

No. :-)

> So options are:
> 1) Involve the router vendor and/or SoC vendor to see if they can help.
> 2) Use UDB connection between your router & drive box ? (if you can)
>=20
>=20Another thing is: Did you try earlier kernel versions ? Any earlier k=
ernel
> working ? (I forgot if that is the case). If yes, then we should be abl=
e
> to figure out the change that broke the driver (which may be something
> changed in the SoC support rather than the mvebu driver itself).
> gi-bisect will likely not be of any help given that you are not getting=
 a
> crash. So you will need to try out different kernel versions, starting
> with LTS kernels, and refine (use Linus tags, including RCs, to find th=
e
> last working kernel). That may take some time, but will likely narrow d=
own
> the search for fixing this (if that is possible given the hardware setu=
p
> you have).

Sorry for the late reply, but I really really hate bisecting, especially =
manually, and especially if the test must be run on another machine.
You are correct. It initially worked, but it was broken by this commit:


commit 2dc0b46b5ea30f169b0b272253ea846a5a281731
Author: David Milburn <dmilburn@redhat.com>
Date:   Tue Nov 14 16:17:25 2017 -0600

    libata: sata_down_spd_limit should return if driver has not recorded =
sstatus speed
=20=20=20=20
=20   During hotplug, it is possible for 6Gbps link speed to be limited a=
ll
    the way down to 1.5 Gbps which may lead to a slower link speed when
    drive is re-connected.
=20=20=20=20
=20   This behavior has been seen on a Intel Lewisburg SATA controller
    (8086:a1d2) with HGST HUH728080ALE600 drive where SATA link speed was
    limited to 1.5 Gbps and when re-connected the link came up 3.0 Gbps.
=20=20=20=20
=20   This patch was retested on above configuration and showed the
    hotplugged link to come back online at max speed (6Gbps). I did not
    see the downgrade when testing on Intel C600/X79, but retested patche=
d
    linux-4.14-rc5 kernel and didn't see any side effects from this
    change. Also, successfully retested hotplug on port multiplier 3Gbps
    link.
=20=20=20=20
=20   tj: Minor comment updates.
=20=20=20=20
=20   Signed-off-by: David Milburn <dmilburn@redhat.com>
    Signed-off-by: Tejun Heo <tj@kernel.org>

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2a882929de4a..8193b38a1cae 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3082,13 +3082,19 @@ int sata_down_spd_limit(struct ata_link *link, u3=
2 spd_limit)
 	bit =3D fls(mask) - 1;
 	mask &=3D ~(1 << bit);
=20
-=09/* Mask off all speeds higher than or equal to the current
-	 * one.  Force 1.5Gbps if current SPD is not available.
+	/*
+	 * Mask off all speeds higher than or equal to the current one.  At
+	 * this point, if current SPD is not available and we previously
+	 * recorded the link speed from SStatus, the driver has already
+	 * masked off the highest bit so mask should already be 1 or 0.
+	 * Otherwise, we should not force 1.5Gbps on a link where we have
+	 * not previously recorded speed from SStatus.  Just return in this
+	 * case.
 	 */
 	if (spd > 1)
 		mask &=3D (1 << (spd - 1)) - 1;
 	else
-		mask &=3D 1;
+		return -EINVAL;
=20
=20	/* were we already at the bottom? */
 	if (!mask)



Just to be sure, I checked out the most recent kernel git master and reve=
rted the bad commit. This is the resulting boot log:

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 6.1.0-rc3M95D-test-00300-g245bef8f3ba1 (mari=
us95@GRAPHIM) (arm-openwrt-linux-gcc (OpenWrt GCC 12.2.0 r21374+10-366bcf=
fa0e) 12.2.0, GNU ld (GNU Binutils) 2.39) #40 SMP Sun Dec  4 02:40:32 EET=
 2022
[    0.000000] CPU: ARMv7 Processor [414fc091] revision 1 (ARMv7), cr=3D1=
0c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing ins=
truction cache
[    0.000000] OF: fdt: Machine model: Linksys WRT1900ACv2
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x000000001fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000001fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000001ff=
fffff]
[    0.000000] percpu: Embedded 8 pages/cpu s9424 r0 d23344 u32768
[    0.000000] pcpu-alloc: s9424 r0 d23344 u32768 alloc=3D8*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1=20
[=20   0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1=
30048
[    0.000000] Kernel command line: console=3DttyS0,115200 nfcConfig=3D4b=
itecc mtdparts=3Darmada-nand:2048K(uboot)ro,256K(u_env),256K(s_env),1m@9m=
(devinfo),40m@10m(kernel),34m@16m(rootfs),40m@50m(alt_kernel),34m@56m(alt=
_rootfs),80m@10m(ubifs),-@90m(syscfg) root=3D/dev/sda rootdelay=3D100  dy=
ndbg=3D"file *ata* +plmft"=20
[=20   0.000000] Unknown kernel command line parameters "nfcConfig=3D4bit=
ecc", will be passed to user space.
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 b=
ytes, linear)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 by=
tes, linear)
[    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:=
off
[    0.000000] Memory: 511212K/524288K available (4096K kernel code, 931K=
 rwdata, 984K rodata, 1024K init, 306K bss, 13076K reserved, 0K cma-reser=
ved)

...

[    3.055271] loop: module loaded
[    3.058618] device class 'scsi_disk': registering
[    3.063368] bus: 'scsi': add driver sd
[    3.067151] bus: 'pci': add driver ahci
[    3.071207] bus: 'platform': add driver ahci
[    3.075566] bus: 'platform': add driver ahci-mvebu
[    3.080419] bus: 'platform': __driver_probe_device: matched device f10=
a8000.sata with driver ahci-mvebu
[    3.089857] bus: 'platform': really_probe: probing driver ahci-mvebu w=
ith device f10a8000.sata
[    3.098512] ahci-mvebu f10a8000.sata: no pinctrl handle
[    3.103987] ahci-mvebu f10a8000.sata: Looking up ahci-supply from devi=
ce tree
[    3.111165] ahci-mvebu f10a8000.sata: Looking up ahci-supply property =
in node /soc/internal-regs/sata@a8000 failed
[    3.121569] ahci-mvebu f10a8000.sata: supply ahci not found, using dum=
my regulator
[    3.129209] device: 'regulator:regulator.0--platform:f10a8000.sata': d=
evice_add
[    3.136798] devices_kset: Moving f10a8000.sata to end of list
[    3.142575] ahci-mvebu f10a8000.sata: Linked as a consumer to regulato=
r.0
[    3.149396] ahci-mvebu f10a8000.sata: Looking up phy-supply from devic=
e tree
[    3.156476] ahci-mvebu f10a8000.sata: Looking up phy-supply property i=
n node /soc/internal-regs/sata@a8000 failed
[    3.166789] ahci-mvebu f10a8000.sata: supply phy not found, using dumm=
y regulator
[    3.174331] ahci-mvebu f10a8000.sata: Looking up target-supply from de=
vice tree
[    3.181676] ahci-mvebu f10a8000.sata: Looking up target-supply propert=
y in node /soc/internal-regs/sata@a8000 failed
[    3.192251] ahci-mvebu f10a8000.sata: supply target not found, using d=
ummy regulator
[    3.200468] [1] libahci:ahci_port_init:1274: ahci-mvebu f10a8000.sata:=
 PORT_SCR_ERR 0x0
[    3.208511] [1] libahci:ahci_port_init:1279: ahci-mvebu f10a8000.sata:=
 PORT_IRQ_STAT 0x0
[    3.216644] [1] libahci:ahci_port_init:1274: ahci-mvebu f10a8000.sata:=
 PORT_SCR_ERR 0x4040000
[    3.225210] [1] libahci:ahci_port_init:1279: ahci-mvebu f10a8000.sata:=
 PORT_IRQ_STAT 0x80000000
[    3.233953] [1] libahci:ahci_init_controller:1310: ahci-mvebu f10a8000=
.sata: HOST_CTL 0x80000000
[    3.242780] [1] libahci:ahci_init_controller:1313: ahci-mvebu f10a8000=
.sata: HOST_CTL 0x80000002
[    3.251606] ahci-mvebu f10a8000.sata: AHCI 0001.0000 32 slots 2 ports =
6 Gbps 0x3 impl platform mode
[    3.260696] ahci-mvebu f10a8000.sata: flags: 64bit ncq sntf led only p=
mp fbs pio slum part sxs=20
[=20   3.269731] device: 'ata1': device_add
[    3.273507] device: 'ata1': device_add
[    3.277303] device: 'link1': device_add
[    3.281168] device: 'link1': device_add
[    3.285248] device: 'dev1.0': device_add
[    3.289192] device: 'dev1.0': device_add
[    3.293516] device: 'ata2': device_add
[    3.297287] device: 'ata2': device_add
[    3.301084] device: 'link2': device_add
[    3.304939] device: 'link2': device_add
[    3.308813] device: 'dev2.0': device_add
[    3.312944] device: 'dev2.0': device_add
[    3.317558] device: 'scsi_tmf_0': device_add
[    3.321863] bus: 'workqueue': add device scsi_tmf_0
[    3.326786] scsi host0: ahci-mvebu
[    3.330596] device: 'host0': device_add
[    3.334455] bus: 'scsi': add device host0
[    3.338497] device: 'host0': device_add
[    3.342860] device: 'scsi_tmf_1': device_add
[    3.347345] bus: 'workqueue': add device scsi_tmf_1
[    3.352277] scsi host1: ahci-mvebu
[    3.355921] device: 'host1': device_add
[    3.359787] bus: 'scsi': add device host1
[    3.363829] device: 'host1': device_add
[    3.367732] ata1: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] p=
ort 0x100 irq 41
[    3.375688] ata2: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] p=
ort 0x180 irq 41
[    3.383647] driver: 'ahci-mvebu': driver_bound: bound to device 'f10a8=
000.sata'
[    3.391022] bus: 'platform': really_probe: bound device f10a8000.sata =
to driver ahci-mvebu
[    3.399362] bus: 'pci': add driver sata_mv
[    3.403500] bus: 'platform': add driver sata_mv
[    3.408306] device class 'mtd': registering
[    3.412540] device: 'mtd-0': device_add
[    3.416813] bus: 'platform': add driver orion_spi
[    3.421663] bus: 'pci': add driver ehci-pci
[    3.425883] bus: 'platform': add driver orion-ehci
[    3.430729] bus: 'platform': __driver_probe_device: matched device f10=
58000.usb with driver orion-ehci
[    3.440080] bus: 'platform': really_probe: probing driver orion-ehci w=
ith device f1058000.usb
[    3.448648] orion-ehci f1058000.usb: no pinctrl handle
[    3.453882] orion-ehci f1058000.usb: EHCI Host Controller
[    3.459322] orion-ehci f1058000.usb: new USB bus registered, assigned =
bus number 1
[    3.467166] orion-ehci f1058000.usb: irq 42, io mem 0xf1058000
[    3.499300] orion-ehci f1058000.usb: USB 2.0 started, EHCI 1.00
[    3.505557] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.01
[    3.513868] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    3.521125] usb usb1: Product: EHCI Host Controller
[    3.526023] usb usb1: Manufacturer: Linux 6.1.0-rc3M95D-test-00300-g24=
5bef8f3ba1 ehci_hcd
[    3.534238] usb usb1: SerialNumber: f1058000.usb
[    3.538878] device: 'usb1': device_add
[    3.542695] bus: 'usb': add device usb1
[    3.546660] bus: 'usb': __driver_probe_device: matched device usb1 wit=
h driver usb
[    3.554270] bus: 'usb': really_probe: probing driver usb with device u=
sb1
[    3.561120] device: '1-0:1.0': device_add
[    3.565165] bus: 'usb': add device 1-0:1.0
[    3.569479] bus: 'usb': __driver_probe_device: matched device 1-0:1.0 =
with driver hub
[    3.577345] bus: 'usb': really_probe: probing driver hub with device 1=
-0:1.0
[    3.584435] hub 1-0:1.0: USB hub found
[    3.588247] hub 1-0:1.0: 1 port detected
[    3.592216] device: 'usb1-port1': device_add
[    3.596519] usb usb1-port1: adding component (ops connector_ops)
[    3.602584] driver: 'hub': driver_bound: bound to device '1-0:1.0'
[    3.608811] bus: 'usb': really_probe: bound device 1-0:1.0 to driver h=
ub
[    3.615559] device: 'ep_81': device_add
[    3.619439] driver: 'usb': driver_bound: bound to device 'usb1'
[    3.625567] bus: 'usb': really_probe: bound device usb1 to driver usb
[    3.632054] device: 'ep_00': device_add
[    3.636104] driver: 'orion-ehci': driver_bound: bound to device 'f1058=
000.usb'
[    3.643559] bus: 'platform': really_probe: bound device f1058000.usb t=
o driver orion-ehci
[    3.651819] bus: 'pci': add driver xhci_hcd
[    3.656043] bus: 'platform': add driver xhci-hcd
[    3.660808] bus: 'platform': __driver_probe_device: matched device f10=
f8000.usb3 with driver xhci-hcd
[    3.670071] bus: 'platform': really_probe: probing driver xhci-hcd wit=
h device f10f8000.usb3
[    3.678746] xhci-hcd f10f8000.usb3: no pinctrl handle
[    3.684093] xhci-hcd f10f8000.usb3: Driver xhci-hcd requests probe def=
erral
[    3.691129] platform f10f8000.usb3: Added to deferred list
[    3.696672] bus: 'usb': add driver usb-storage
[    3.701168] usbcore: registered new interface driver usb-storage
[    3.707442] bus: 'usb-serial': registered
[    3.711483] bus: 'usb': add driver ftdi_sio
[    3.715425] ata1: SATA link down (SStatus 0 SControl 300)
[    3.715697] usbcore: registered new interface driver ftdi_sio
[    3.726874] bus: 'usb-serial': add driver ftdi_sio
[    3.731703] usbserial: USB Serial support registered for FTDI USB Seri=
al Device
[    3.739065] i2c_dev: i2c /dev entries driver
[    3.743361] device class 'i2c-dev': registering
[    3.747926] bus: 'platform': add driver mv64xxx_i2c
[    3.752849] bus: 'platform': __driver_probe_device: matched device f10=
11000.i2c with driver mv64xxx_i2c
[    3.762287] bus: 'platform': really_probe: probing driver mv64xxx_i2c =
with device f1011000.i2c
[    3.770961] mv64xxx_i2c f1011000.i2c: no init pinctrl state
[    3.776905] device: 'i2c-0': device_add
[    3.781128] bus: 'i2c': add device i2c-0
[    3.785075] device: 'i2c-0': device_add
[    3.789074] device: '0-004c': device_add
[    3.793032] bus: 'i2c': add device 0-004c
[    3.797087] device: '0-0068': device_add
[    3.801041] bus: 'i2c': add device 0-0068
[    3.805097] driver: 'mv64xxx_i2c': driver_bound: bound to device 'f101=
1000.i2c'
[    3.812467] bus: 'platform': really_probe: bound device f1011000.i2c t=
o driver mv64xxx_i2c
[    3.820845] bus: 'i2c': add driver tmp421
[    3.824877] bus: 'i2c': __driver_probe_device: matched device 0-004c w=
ith driver tmp421
[    3.832920] bus: 'i2c': really_probe: probing driver tmp421 with devic=
e 0-004c
[    3.840396] tmp421 0-004c: no pinctrl handle
[    3.846056] device: 'hwmon0': device_add
[    3.850199] driver: 'tmp421': driver_bound: bound to device '0-004c'
[    3.856787] bus: 'i2c': really_probe: bound device 0-004c to driver tm=
p421
[    3.863720] bus: 'platform': add driver armada_thermal
[    3.868965] bus: 'platform': __driver_probe_device: matched device f10=
e4078.thermal with driver armada_thermal
[    3.879014] bus: 'platform': really_probe: probing driver armada_therm=
al with device f10e4078.thermal
[    3.888282] armada_thermal f10e4078.thermal: no pinctrl handle
[    3.895404] device: 'thermal_zone0': device_add
[    3.900216] device: 'hwmon1': device_add
[    3.904181] driver: 'armada_thermal': driver_bound: bound to device 'f=
10e4078.thermal'
[    3.912159] bus: 'platform': really_probe: bound device f10e4078.therm=
al to driver armada_thermal
[    3.921110] bus: 'platform': add driver orion_wdt
[    3.925877] bus: 'platform': __driver_probe_device: matched device f10=
20300.watchdog with driver orion_wdt
[    3.935577] bus: 'platform': really_probe: probing driver orion_wdt wi=
th device f1020300.watchdog
[    3.944495] orion_wdt f1020300.watchdog: no pinctrl handle
[    3.950854] device: 'watchdog': device_add
[    3.955027] device: 'watchdog0': device_add
[    3.959484] orion_wdt: Initial timeout 171 sec
[    3.963948] driver: 'orion_wdt': driver_bound: bound to device 'f10203=
00.watchdog'
[    3.971576] bus: 'platform': really_probe: bound device f1020300.watch=
dog to driver orion_wdt
[    3.980207] bus: 'platform': add driver leds-gpio
[    3.984958] bus: 'platform': __driver_probe_device: matched device gpi=
o-leds with driver leds-gpio
[    3.993961] bus: 'platform': really_probe: probing driver leds-gpio wi=
th device gpio-leds
[    4.002245] leds-gpio gpio-leds: no init pinctrl state
[    4.007449] device: 'cobra:white:power': device_add
[    4.012954] device: 'cobra:white:sata': device_add
[    4.017792] driver: 'leds-gpio': driver_bound: bound to device 'gpio-l=
eds'
[    4.024709] leds-gpio gpio-leds: Dropping the link to f1018140.gpio
[    4.031007] device: 'platform:f1018140.gpio--platform:gpio-leds': devi=
ce_unregister
[    4.038937] bus: 'platform': really_probe: bound device gpio-leds to d=
river leds-gpio
[    4.046841] bus: 'i2c': add driver leds-pca963x
[    4.051405] bus: 'i2c': __driver_probe_device: matched device 0-0068 w=
ith driver leds-pca963x
[    4.059971] bus: 'i2c': really_probe: probing driver leds-pca963x with=
 device 0-0068
[    4.067752] leds-pca963x 0-0068: no pinctrl handle
[    4.074897] device: 'pca963x:cobra:amber:wan': device_add
[    4.080370] device: 'pca963x:cobra:white:wan': device_add
[    4.085821] device: 'pca963x:cobra:white:wlan_2g': device_add
[    4.091629] device: 'pca963x:cobra:white:wlan_5g': device_add
[    4.097425] device: 'pca963x:cobra:white:usb2': device_add
[    4.103366] device: 'pca963x:cobra:white:usb3_1': device_add
[    4.109080] device: 'pca963x:cobra:white:usb3_2': device_add
[    4.115146] device: 'pca963x:cobra:white:wps': device_add
[    4.120608] device: 'pca963x:cobra:amber:wps': device_add
[    4.126049] driver: 'leds-pca963x': driver_bound: bound to device '0-0=
068'
[    4.132987] bus: 'i2c': really_probe: bound device 0-0068 to driver le=
ds-pca963x
[    4.140468] ledtrig-cpu: registered to indicate activity on CPUs
[    4.146505] bus: 'platform': add driver marvell-cesa
[    4.151589] bus: 'platform': __driver_probe_device: matched device f10=
90000.crypto with driver marvell-cesa
[    4.161377] bus: 'platform': really_probe: probing driver marvell-cesa=
 with device f1090000.crypto
[    4.170383] marvell-cesa f1090000.crypto: no pinctrl handle
[    4.176869] marvell-cesa f1090000.crypto: CESA device successfully reg=
istered
[    4.184048] driver: 'marvell-cesa': driver_bound: bound to device 'f10=
90000.crypto'
[    4.191769] bus: 'platform': really_probe: bound device f1090000.crypt=
o to driver marvell-cesa
[    4.200469] device class 'extcon': registering
[    4.204959] bus: 'platform': add driver mvebu-devbus
[    4.210037] Registering SWP/SWPB emulation handler
[    4.218889] devices_kset: Moving usb3_1-vbus to end of list
[    4.224505] devices_kset: Moving usb3_1-phy to end of list
[    4.230029] platform usb3_1-vbus: Retrying from deferred list
[    4.235806] bus: 'platform': __driver_probe_device: matched device usb=
3_1-vbus with driver reg-fixed-voltage
[    4.245681] bus: 'platform': really_probe: probing driver reg-fixed-vo=
ltage with device usb3_1-vbus
[    4.254793] reg-fixed-voltage usb3_1-vbus: no init pinctrl state
[    4.261321] usb3_1-vbus: 5000 mV, disabled
[    4.265438] device: 'regulator.1': device_add
[    4.269889] reg-fixed-voltage usb3_1-vbus: usb3_1-vbus supplying 50000=
00uV
[    4.276795] driver: 'reg-fixed-voltage': driver_bound: bound to device=
 'usb3_1-vbus'
[    4.284605] bus: 'platform': really_probe: bound device usb3_1-vbus to=
 driver reg-fixed-voltage
[    4.293349] devices_kset: Moving usb3_1-phy to end of list
[    4.298859] platform usb3_1-phy: Retrying from deferred list
[    4.304549] bus: 'platform': __driver_probe_device: matched device usb=
3_1-phy with driver usb_phy_generic
[    4.314160] bus: 'platform': really_probe: probing driver usb_phy_gene=
ric with device usb3_1-phy
[    4.322993] usb_phy_generic usb3_1-phy: no pinctrl handle
[    4.328453] usb_phy_generic usb3_1-phy: Looking up vcc-supply from dev=
ice tree
[    4.335738] device: 'regulator:regulator.1--platform:usb3_1-phy': devi=
ce_add
[    4.343100] devices_kset: Moving usb3_1-phy to end of list
[    4.348611] usb_phy_generic usb3_1-phy: Linked as a consumer to regula=
tor.1
[    4.355607] usb_phy_generic usb3_1-phy: Looking up vbus-supply from de=
vice tree
[    4.362951] usb_phy_generic usb3_1-phy: Looking up vbus-supply propert=
y in node /usb3_1-phy failed
[    4.371955] usb_phy_generic usb3_1-phy: dummy supplies not allowed for=
 exclusive requests
[    4.380174] driver: 'usb_phy_generic': driver_bound: bound to device '=
usb3_1-phy'
[    4.387711] bus: 'platform': really_probe: bound device usb3_1-phy to =
driver usb_phy_generic
[    4.396190] devices_kset: Moving f10f8000.usb3 to end of list
[    4.401964] platform f10f8000.usb3: Retrying from deferred list
[    4.407949] bus: 'platform': __driver_probe_device: matched device f10=
f8000.usb3 with driver xhci-hcd
[    4.417211] bus: 'platform': really_probe: probing driver xhci-hcd wit=
h device f10f8000.usb3
[    4.425693] xhci-hcd f10f8000.usb3: no pinctrl handle
[    4.431084] xhci-hcd f10f8000.usb3: xHCI Host Controller
[    4.436429] xhci-hcd f10f8000.usb3: new USB bus registered, assigned b=
us number 2
[    4.444012] xhci-hcd f10f8000.usb3: hcc params 0x0a000990 hci version =
0x100 quirks 0x0000000000010010
[    4.453725] xhci-hcd f10f8000.usb3: irq 43, io mem 0xf10f8000
[    4.459624] xhci-hcd f10f8000.usb3: xHCI Host Controller
[    4.465011] xhci-hcd f10f8000.usb3: new USB bus registered, assigned b=
us number 3
[    4.472578] xhci-hcd f10f8000.usb3: Host supports USB 3.0 SuperSpeed
[    4.479190] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.01
[    4.487499] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    4.494756] usb usb2: Product: xHCI Host Controller
[    4.499659] usb usb2: Manufacturer: Linux 6.1.0-rc3M95D-test-00300-g24=
5bef8f3ba1 xhci-hcd
[    4.507870] usb usb2: SerialNumber: f10f8000.usb3
[    4.512601] device: 'usb2': device_add
[    4.516427] bus: 'usb': add device usb2
[    4.520385] bus: 'usb': __driver_probe_device: matched device usb2 wit=
h driver usb
[    4.527989] bus: 'usb': really_probe: probing driver usb with device u=
sb2
[    4.534842] device: '2-0:1.0': device_add
[    4.538885] bus: 'usb': add device 2-0:1.0
[    4.543034] bus: 'usb': __driver_probe_device: matched device 2-0:1.0 =
with driver hub
[    4.550902] bus: 'usb': really_probe: probing driver hub with device 2=
-0:1.0
[    4.557986] hub 2-0:1.0: USB hub found
[    4.561788] hub 2-0:1.0: 1 port detected
[    4.565980] device: 'usb2-port1': device_add
[    4.570472] usb usb2-port1: adding component (ops connector_ops)
[    4.576738] driver: 'hub': driver_bound: bound to device '2-0:1.0'
[    4.582979] bus: 'usb': really_probe: bound device 2-0:1.0 to driver h=
ub
[    4.589912] device: 'ep_81': device_add
[    4.593780] driver: 'usb': driver_bound: bound to device 'usb2'
[    4.599757] bus: 'usb': really_probe: bound device usb2 to driver usb
[    4.606228] device: 'ep_00': device_add
[    4.610353] usb usb3: We don't know the algorithms for LPM for this ho=
st, disabling LPM.
[    4.620069] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.01
[    4.628372] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    4.635630] usb usb3: Product: xHCI Host Controller
[    4.640530] usb usb3: Manufacturer: Linux 6.1.0-rc3M95D-test-00300-g24=
5bef8f3ba1 xhci-hcd
[    4.648741] usb usb3: SerialNumber: f10f8000.usb3
[    4.653472] device: 'usb3': device_add
[    4.657275] bus: 'usb': add device usb3
[    4.661585] bus: 'usb': __driver_probe_device: matched device usb3 wit=
h driver usb
[    4.669189] bus: 'usb': really_probe: probing driver usb with device u=
sb3
[    4.676037] device: '3-0:1.0': device_add
[    4.680086] bus: 'usb': add device 3-0:1.0
[    4.684224] bus: 'usb': __driver_probe_device: matched device 3-0:1.0 =
with driver hub
[    4.692091] bus: 'usb': really_probe: probing driver hub with device 3=
-0:1.0
[    4.699175] hub 3-0:1.0: USB hub found
[    4.702975] hub 3-0:1.0: 1 port detected
[    4.707546] device: 'usb3-port1': device_add
[    4.711856] usb usb3-port1: adding component (ops connector_ops)
[    4.717913] driver: 'hub': driver_bound: bound to device '3-0:1.0'
[    4.724148] bus: 'usb': really_probe: bound device 3-0:1.0 to driver h=
ub
[    4.730886] device: 'ep_81': device_add
[    4.734751] driver: 'usb': driver_bound: bound to device 'usb3'
[    4.740722] bus: 'usb': really_probe: bound device usb3 to driver usb
[    4.747194] device: 'ep_00': device_add
[    4.751261] driver: 'xhci-hcd': driver_bound: bound to device 'f10f800=
0.usb3'
[    4.758643] bus: 'platform': really_probe: bound device f10f8000.usb3 =
to driver xhci-hcd
[    4.766962] Waiting=20100 sec before mounting root device...
[    4.969572] ata2: SATA link down (SStatus 100 SControl 300)
[    5.399296] usb 2-1: new high-speed USB device number 2 using xhci-hcd
[    5.586274] usb 2-1: New USB device found, idVendor=3D058f, idProduct=
=3D6387, bcdDevice=3D 1.00
[    5.594500] usb 2-1: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D3
[    5.601671] usb 2-1: Product: Mass Storage
[    5.605784] usb 2-1: Manufacturer: Generic
[    5.609900] usb 2-1: SerialNumber: 016E07B1
[    5.614108] device: '2-1': device_add
[    5.618273] bus: 'usb': add device 2-1
[    5.622116] bus: 'usb': __driver_probe_device: matched device 2-1 with=
 driver usb
[    5.629641] bus: 'usb': really_probe: probing driver usb with device 2=
-1
[    5.636377] usb 2-1: no default pinctrl state
[    5.641299] device: '2-1:1.0': device_add
[    5.645346] bus: 'usb': add device 2-1:1.0
[    5.649507] bus: 'usb': __driver_probe_device: matched device 2-1:1.0 =
with driver usb-storage
[    5.658070] bus: 'usb': really_probe: probing driver usb-storage with =
device 2-1:1.0
[    5.665855] usb-storage 2-1:1.0: no default pinctrl state
[    5.671292] usb-storage 2-1:1.0: USB Mass Storage device detected
[    5.677490] device: 'scsi_tmf_2': device_add
[    5.682044] bus: 'workqueue': add device scsi_tmf_2
[    5.687237] scsi host2: usb-storage 2-1:1.0
[    5.691482] device: 'host2': device_add
[    5.695341] bus: 'scsi': add device host2
[    5.699389] device: 'host2': device_add
[    5.703287] driver: 'usb-storage': driver_bound: bound to device '2-1:=
1.0'
[    5.710215] bus: 'usb': really_probe: bound device 2-1:1.0 to driver u=
sb-storage
[    5.717648] device: 'ep_01': device_add
[    5.721520] device: 'ep_82': device_add
[    5.725384] driver: 'usb': driver_bound: bound to device '2-1'
[    5.731260] bus: 'usb': really_probe: bound device 2-1 to driver usb
[    5.737863] device: 'ep_00': device_add
[    6.730894] scsi 2:0:0:0: Direct-Access     Generic  Flash Disk       =
8.07 PQ: 0 ANSI: 4
[    6.739024] device: 'target2:0:0': device_add
[    6.743413] bus: 'scsi': add device target2:0:0
[    6.747983] device: '2:0:0:0': device_add
[    6.752312] bus: 'scsi': add device 2:0:0:0
[    6.756534] scsi 2:0:0:0: scheduling asynchronous probe
[    6.761791] device: '2:0:0:0': device_add
[    6.761795] bus: 'scsi': __driver_probe_device: matched device 2:0:0:0=
 with driver sd
[    6.773688] bus: 'scsi': really_probe: probing driver sd with device 2=
:0:0:0
[    6.780782] sd 2:0:0:0: no default pinctrl state
[    6.785454] device: '2:0:0:0': device_add
[    6.790609] sd 2:0:0:0: [sda] 122880000 512-byte logical blocks: (62.9=
 GB/58.6 GiB)
[    6.798937] sd 2:0:0:0: [sda] Write Protect is off
[    6.803760] sd 2:0:0:0: [sda] Mode Sense: 23 00 00 00
[    6.809478] sd 2:0:0:0: [sda] Write cache: disabled, read cache: enabl=
ed, doesn't support DPO or FUA
[    6.818654] device: 'sda': device_add
[    6.823310] device: '8:0': device_add
[    6.830649] sd 2:0:0:0: [sda] Attached SCSI removable disk
[    6.836162] driver: 'sd': driver_bound: bound to device '2:0:0:0'
[    6.842309] bus: 'scsi': really_probe: bound device 2:0:0:0 to driver =
sd
[    6.849041] sd 2:0:0:0: async probe completed
[    7.689299] ata2: SATA link down (SStatus 0 SControl 300)
[    7.843539] ata2: limiting SATA link speed to 1.5 Gbps
[    8.619299] [96] libata:ata_port_classify:344: ata2: found ata device =
by sig
[    8.789296] [96] libata:ata_port_classify:344: ata2: found pmp device =
by sig
[    8.796376] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    8.802674] ata2.15: Port Multiplier 1.2, 0x197b:0x0325 r193, 8 ports,=
 feat 0xf/0x1f
[    8.810483] device: 'link2.0': device_add
[    8.814520] device: 'link2.0': device_add
[    8.818578] device: 'dev2.0.0': device_add
[    8.822705] device: 'dev2.0.0': device_add
[    8.827423] device: 'link2.1': device_add
[    8.831466] device: 'link2.1': device_add
[    8.835522] device: 'dev2.1.0': device_add
[    8.839882] device: 'dev2.1.0': device_add
[    8.844037] device: 'link2.2': device_add
[    8.848068] device: 'link2.2': device_add
[    8.852557] device: 'dev2.2.0': device_add
[    8.856677] device: 'dev2.2.0': device_add
[    8.861248] device: 'link2.3': device_add
[    8.865280] device: 'link2.3': device_add
[    8.869353] device: 'dev2.3.0': device_add
[    8.873470] device: 'dev2.3.0': device_add
[    8.877614] device: 'link2.4': device_add
[    8.881650] device: 'link2.4': device_add
[    8.885701] device: 'dev2.4.0': device_add
[    8.889823] device: 'dev2.4.0': device_add
[    8.894400] device: 'link2.5': device_add
[    8.898433] device: 'link2.5': device_add
[    8.902704] device: 'dev2.5.0': device_add
[    8.906823] device: 'dev2.5.0': device_add
[    8.911212] device: 'link2.6': device_add
[    8.915244] device: 'link2.6': device_add
[    8.919302] device: 'dev2.6.0': device_add
[    8.923842] device: 'dev2.6.0': device_add
[    8.927990] device: 'link2.7': device_add
[    8.932028] device: 'link2.7': device_add
[    8.936298] device: 'dev2.7.0': device_add
[    8.940423] device: 'dev2.7.0': device_add
[    8.944787] device: 'link2.8': device_add
[    8.948820] device: 'link2.8': device_add
[    8.953094] device: 'dev2.8.0': device_add
[    8.957214] device: 'dev2.8.0': device_add
[    8.961378] device: 'link2.9': device_add
[    8.965410] device: 'link2.9': device_add
[    8.969470] device: 'dev2.9.0': device_add
[    8.973588] device: 'dev2.9.0': device_add
[    8.978186] device: 'link2.10': device_add
[    8.982312] device: 'link2.10': device_add
[    8.986673] device: 'dev2.10.0': device_add
[    8.990885] device: 'dev2.10.0': device_add
[    8.995546] device: 'link2.11': device_add
[    8.999672] device: 'link2.11': device_add
[    9.003812] device: 'dev2.11.0': device_add
[    9.008018] device: 'dev2.11.0': device_add
[    9.012255] device: 'link2.12': device_add
[    9.016374] device: 'link2.12': device_add
[    9.020965] device: 'dev2.12.0': device_add
[    9.025173] device: 'dev2.12.0': device_add
[    9.029862] device: 'link2.13': device_add
[    9.033983] device: 'link2.13': device_add
[    9.038123] device: 'dev2.13.0': device_add
[    9.042335] device: 'dev2.13.0': device_add
[    9.046588] device: 'link2.14': device_add
[    9.050714] device: 'link2.14': device_add
[    9.054853] device: 'dev2.14.0': device_add
[    9.059059] device: 'dev2.14.0': device_add
[    9.063526] ahci-mvebu f10a8000.sata: FBS is enabled
[    9.068637] ata2.00: hard resetting link
[    9.400820] ata2.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    9.407302] ata2.01: hard resetting link
[    9.740815] ata2.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    9.747296] ata2.02: hard resetting link
[   10.080816] ata2.02: SATA link down (SStatus 0 SControl 300)
[   10.086521] ata2.03: hard resetting link
[   10.420814] ata2.03: SATA link down (SStatus 0 SControl 300)
[   10.426519] ata2.04: hard resetting link
[   10.760813] ata2.04: SATA link down (SStatus 0 SControl 300)
[   10.766517] ata2.05: hard resetting link
[   11.100814] ata2.05: SATA link down (SStatus 0 SControl 300)
[   11.106519] ata2.06: hard resetting link
[   11.440812] ata2.06: SATA link down (SStatus 0 SControl 300)
[   11.446518] ata2.07: hard resetting link
[   11.780813] ata2.07: SATA link down (SStatus 0 SControl 300)
[   11.786591] [96] libata:ata_dev_configure:2596: ata2.00: ata_dev_confi=
gure: cfg 49:2f00 82:41e9 83:7400 84:4000 85:0069 86:3400 87:4000 88:007f
[   11.799524] [96] libata:ata_dump_id:1363: ata2.00: 49=3D=3D0x2f00  53=
=3D=3D0x0007  63=3D=3D0x0007  64=3D=3D0x0003  75=3D=3D0x0000
[   11.799524] 80=3D=3D0x007c  81=3D=3D0x001b  82=3D=3D0x41e9  83=3D=3D0x=
7400  84=3D=3D0x4000
[   11.799524] 88=3D=3D0x007f  93=3D=3D0x0000
[   11.819432] ata2.00: ATA-6: WDC WD50ARC-5040-VOL#01, 0100 AX, max UDMA=
/133
[   11.826336] ata2.00: 976773168 sectors, multi 0: LBA48=20
[=20  11.831596] [96] libata:ata_dev_set_xfermode:4299: ata2.00: set feat=
ures - xfer mode
[   11.839465] [96] libata:ata_dev_configure:2596: ata2.00: ata_dev_confi=
gure: cfg 49:2f00 82:41e9 83:7400 84:4000 85:0069 86:3400 87:4000 88:407f
[   11.852396] [96] libata:ata_dump_id:1363: ata2.00: 49=3D=3D0x2f00  53=
=3D=3D0x0007  63=3D=3D0x0007  64=3D=3D0x0003  75=3D=3D0x0000
[   11.852396] 80=3D=3D0x007c  81=3D=3D0x001b  82=3D=3D0x41e9  83=3D=3D0x=
7400  84=3D=3D0x4000
[   11.852396] 88=3D=3D0x407f  93=3D=3D0x0000
[   11.872306] [96] libata:ata_dev_set_mode:3338: ata2.00: xfer_shift=3D1=
2, xfer_mode=3D0x46
[   11.880173] ata2.00: configured for UDMA/133
[   11.884518] [96] libata:ata_dev_configure:2596: ata2.01: ata_dev_confi=
gure: cfg 49:2f00 82:41e9 83:7400 84:4000 85:0069 86:3400 87:4000 88:007f
[   11.897449] [96] libata:ata_dump_id:1363: ata2.01: 49=3D=3D0x2f00  53=
=3D=3D0x0007  63=3D=3D0x0007  64=3D=3D0x0003  75=3D=3D0x0000
[   11.897449] 80=3D=3D0x007c  81=3D=3D0x001b  82=3D=3D0x41e9  83=3D=3D0x=
7400  84=3D=3D0x4000
[   11.897449] 88=3D=3D0x007f  93=3D=3D0x0000
[   11.917355] ata2.01: ATA-6: Areca   Archive, 0100 AX, max UDMA/133
[   11.923565] ata2.01: 23437498368 sectors, multi 0: LBA48=20
[=20  11.928991] [96] libata:ata_dev_set_xfermode:4299: ata2.01: set feat=
ures - xfer mode
[   11.936851] [96] libata:ata_dev_configure:2596: ata2.01: ata_dev_confi=
gure: cfg 49:2f00 82:41e9 83:7400 84:4000 85:0069 86:3400 87:4000 88:407f
[   11.949782] [96] libata:ata_dump_id:1363: ata2.01: 49=3D=3D0x2f00  53=
=3D=3D0x0007  63=3D=3D0x0007  64=3D=3D0x0003  75=3D=3D0x0000
[   11.949782] 80=3D=3D0x007c  81=3D=3D0x001b  82=3D=3D0x41e9  83=3D=3D0x=
7400  84=3D=3D0x4000
[   11.949782] 88=3D=3D0x407f  93=3D=3D0x0000
[   11.969692] [96] libata:ata_dev_set_mode:3338: ata2.01: xfer_shift=3D1=
2, xfer_mode=3D0x46
[   11.977556] ata2.01: configured for UDMA/133
[   11.981877] ata2: EH complete
[   11.985024] scsi 1:0:0:0: Direct-Access     ATA      WDC WD50ARC-5040 =
n/a  PQ: 0 ANSI: 5
[   11.993327] device: 'target1:0:0': device_add
[   11.997711] bus: 'scsi': add device target1:0:0
[   12.002289] device: '1:0:0:0': device_add
[   12.006369] bus: 'scsi': add device 1:0:0:0
[   12.010592] scsi 1:0:0:0: scheduling asynchronous probe
[   12.015842] device: '1:0:0:0': device_add
[   12.015846] bus: 'scsi': __driver_probe_device: matched device 1:0:0:0=
 with driver sd
[   12.020039] scsi 1:1:0:0: Direct-Access     ATA      Areca   Archive  =
n/a  PQ: 0 ANSI: 5
[   12.027736] bus: 'scsi': really_probe: probing driver sd with device 1=
:0:0:0
[   12.036033] device: 'target1:1:0': device_add
[   12.042944] sd 1:0:0:0: no default pinctrl state
[   12.047319] bus: 'scsi': add device target1:1:0
[   12.051975] device: '1:0:0:0': device_add
[   12.056516] device: '1:1:0:0': device_add
[   12.060618] sd 1:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 =
GB/466 GiB)
[   12.064932] bus: 'scsi': add device 1:1:0:0
[   12.072106] sd 1:0:0:0: [sdb] Write Protect is off
[   12.076287] scsi 1:1:0:0: scheduling asynchronous probe
[   12.081085] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   12.086326] device: '1:1:0:0': device_add
[   12.091431] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enable=
d, doesn't support DPO or FUA
[   12.095525] bus: 'scsi': __driver_probe_device: matched device 1:1:0:0=
 with driver sd
[   12.105302] sd 1:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
[   12.112379] bus: 'scsi': really_probe: probing driver sd with device 1=
:1:0:0
[   12.112388] sd 1:1:0:0: no default pinctrl state
[   12.112418] device: '1:1:0:0': device_add
[   12.118596] device: 'sdb': device_add
[   12.126530] sd 1:1:0:0: [sdc] 23437498368 512-byte logical blocks: (12=
.0 TB/10.9 TiB)
[   12.131363] device: '8:16': device_add
[   12.134448] sd 1:1:0:0: [sdc] Write Protect is off
[   12.154472] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[   12.159582] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enable=
d, doesn't support DPO or FUA
[   12.168703] sd 1:1:0:0: [sdc] Preferred minimum I/O size 512 bytes
[   12.174920] device: 'sdc': device_add
[   12.179893] device: '8:32': device_add
[   12.202580] sd 1:1:0:0: [sdc] Attached SCSI removable disk
[   12.208094] driver: 'sd': driver_bound: bound to device '1:1:0:0'
[   12.214237] bus: 'scsi': really_probe: bound device 1:1:0:0 to driver =
sd
[   12.220976] sd 1:1:0:0: async probe completed
[   12.609536] sd 1:0:0:0: [sdb] Attached SCSI removable disk
[   12.615047] driver: 'sd': driver_bound: bound to device '1:0:0:0'
[   12.621511] bus: 'scsi': really_probe: bound device 1:0:0:0 to driver =
sd
[   12.628246] sd 1:0:0:0: async probe completed
[  105.450861] EXT4-fs (sda): mounting ext2 file system using the ext4 su=
bsystem
[  105.462924] EXT4-fs (sda): mounted filesystem without journal. Quota m=
ode: disabled.
[  105.470739] VFS: Mounted root (ext2 filesystem) readonly on device 8:0=
.
[  105.481028] devtmpfs: mounted
[  105.484548] Freeing unused kernel image (initmem) memory: 1024K
[  105.529387] Run /sbin/init as init process
[  105.533500]   with arguments:
[  105.536479]     /sbin/init
[  105.539195]   with environment:
[  105.542353]     HOME=3D/
[  105.544720]     TERM=3Dlinux
[  105.547436]     nfcConfig=3D4bitecc
init started: BusyBox v1.35.0 (2022-11-30 11:34:58 UTC)
Please press Enter to activate this console.=20
BusyBox=20v1.35.0 (2022-11-30 11:34:58 UTC) built-in shell (ash)
Enter 'help' for a list of built-in commands.
/ # lsblk
NAME MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda    8:0    1  58.6G  0 disk /
sdb    8:16   1 465.8G  0 disk=20
sdc=20   8:32   1  10.9T  0 disk=20
/=20# blkid
/dev/sdc: LABEL=3D"RTArchive" UUID=3D"dbcea8a0-ed94-4c76-91d5-5a5b80face9=
6" TYPE=3D"btrfs"
/dev/sdb: LABEL=3D"RTWork" UUID=3D"c8979d5b-c532-42d0-9111-89a92c9c8620" =
TYPE=3D"btrfs"
/dev/sda: LABEL=3D"GRAPHRT" UUID=3D"9f9cd20d-80c4-4b42-a927-bf233e51a155"=
 TYPE=3D"ext2"
/ #

So, it works!
What next? Should I contact David Milburn <dmilburn@redhat.com> (the comm=
it author) and ask for a better fix?

@ Pali Rohar:
I could't find the errata you mentioned. If you have it, please take a lo=
ok at the commit above and see if it is affected in any. Thanks.

Marius Dinu

