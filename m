From: Dimitar Boyn <dimitarboyn@cyclone-trading.com>
Subject: Re: AHCI driver does not discover PCIe Marvell based SSD device
Date: Sat, 28 Sep 2013 15:57:37 -0700
Message-ID: <CAH2BsKUWF-n6RYJJP35-6ojvpivXQE89DcjtkOzyga6DwO5kmg@mail.gmail.com>
References: <CAH2BsKX7_qOE33ZZ27TgXpK74zQh6XUuFYgHjtsd5nURpwJ15w@mail.gmail.com>
	<CAH2BsKWNo1X=W2917xfGWt4K64HuhKk9=-2jRxACBF7VavNOkA@mail.gmail.com>
	<CA+res+QeFo_jOMOaf5WAcw_GO8CAdjr6vjZHXRGGzWRfhYRG6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:62534 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626Ab3I1W5i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Sep 2013 18:57:38 -0400
Received: by mail-vc0-f169.google.com with SMTP id ib11so2906610vcb.0
        for <linux-ide@vger.kernel.org>; Sat, 28 Sep 2013 15:57:37 -0700 (PDT)
In-Reply-To: <CA+res+QeFo_jOMOaf5WAcw_GO8CAdjr6vjZHXRGGzWRfhYRG6A@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jack Wang <jack.wang.usish@gmail.com>
Cc: linux-ide@vger.kernel.org

Here is the output after installation of  Xen Server 6.2 - it seems to
me there is no proper bind from the ahci driver:

# lspci -vv -s 0a:00
0a:00.0 SATA controller: Marvell Technology Group Ltd. Device 9183
(rev 14) (prog-if 01 [AHCI 1.0])
        Subsystem: Marvell Technology Group Ltd. Device 9183
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 1263
        Region 0: I/O ports at 2028 [size=3D8]
        Region 1: I/O ports at 2034 [size=3D4]
        Region 2: I/O ports at 2020 [size=3D8]
        Region 3: I/O ports at 2030 [size=3D4]
        Region 4: I/O ports at 2000 [size=3D32]
        Region 5: Memory at b9b00000 (32-bit, non-prefetchable) [size=3D=
512]
        Expansion ROM at ba200000 [disabled] [size=3D128K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 P=
ME-
        Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
                Address: fee06000  Data: 4032
        Capabilities: [70] Express (v2) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s
<1us, L1 <8us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 256 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+
AuxPwr- TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x2, ASPM L0s L1,
Latency L0 <512ns, L1 <64us
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- =
CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s, Width x2, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB
        Capabilities: [e0] SATA HBA v0.0 BAR4 Offset=3D00000004
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonF=
atalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonF=
atalErr+
                AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap=
- ChkEn-
        Kernel driver in use: ahci
        Kernel modules: ahci

However:
# lsmod | grep ahci
Module                  Size  Used by
ahci                   32926    0
libata                153762  1 ahci

And from dmesg:
[   35.492941] ahci 0000:0a:00.0: PCI INT A -> GSI 30 (level, low) -> I=
RQ 30
[   35.492951] i801_smbus 0000:00:1f.3: PCI INT B -> GSI 18 (level,
low) -> IRQ 18
[   35.492997] ahci 0000:0a:00.0: get owner: 7ff0
[   35.493016] ahci 0000:0a:00.0: irq 1263 (287) for MSI/MSI-X
[   35.513899] ahci 0000:0a:00.0: AHCI 0001.0000 32 slots 1 ports 6
Gbps 0x1 impl SATA mode
[   35.513903] ahci 0000:0a:00.0: flags: 64bit ncq sntf led pio slum pa=
rt
[   35.513909] ahci 0000:0a:00.0: setting latency timer to 64
[   35.514249] scsi7 : ahci
[   35.514286] ata7: SATA max UDMA/133 abar m512@0xb9b00000 port
0xb9b00100 irq 1263[   35.865058] ata7: SATA link up 6.0 Gbps (SStatus
133 SControl 300)
[   35.866952] ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed,
err_mask=3D0x80)
[   41.213883] ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   41.215777] ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed,
err_mask=3D0x80)
[   41.215782] ata7: limiting SATA link speed to 3.0 Gbps
[   46.563878] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   46.565767] ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed,
err_mask=3D0x80)
[   51.913876] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 320)

It seems initialization fails - same succeeds in RHEL 6.3

Thanks!
Dimitar

On Sat, Sep 28, 2013 at 5:57 AM, Jack Wang <jack.wang.usish@gmail.com> =
wrote:
> Hi=EF=BC=8C
>
> have you checked the device is proper bind to ahci driver on Xen Serv=
er 6.2?
>
> lspci -vv  -s 0a:00?
>
> Jack
>
>
> 2013/9/28 Dimitar Boyn <dimitarboyn@cyclone-trading.com>
>>
>> Hi, Jeff! (and Team)
>>
>> We still work with early engineering releases of M.2 SSD at this poi=
nt
>> as PCIe compatible M.2 will not be available commercially for at lea=
st
>> a few weeks.
>> Current implementations use AHCI controllers by Marvell.
>> We are able to natively install RHEL 6.3 on it as boot device where =
it
>> is discovered as the device:
>>
>> 0a:00.0 SATA controller: Marvell Technology Group Ltd. Device 9183 (=
rev
>> 14)
>>
>> You can see that in BIOS the PCIe device is correctly discovered too=
:
>> <Missing picture>
>>
>> My question is related to other Linux related platforms which do not
>> identify the device as SSD SATA at boot time - and in particular
>> Oracle vServer, XenServer 6.2.
>>
>> I have gathered some information included bellow and noticed that
>> drivers included in the distributions were dependent on other module=
s
>> before.
>>
>> Could you please explain the changes in the module included with RHE=
L
>> 6.3 and advise how/what to modify in the other distributions to enab=
le
>> correct recognition at install time?
>>
>>
>> --------------------------------------------------------------------=
-------------------
>>
>> RHEL 6.3
>>
>> #modinfo ahci
>>
>> filename:
>> /lib/modules/2.6.32-279.el6.x86_64/kernel/drivers/ata/ahci.ko
>>
>> version:        3.0
>>
>> license:        GPL
>>
>> description:    AHCI SATA low-level driver
>>
>> author:         Jeff Garzik
>>
>> srcversion:     C45EE190F3F2730DF6E95A0
>>
>> depends:
>>
>> vermagic:     2.6.32-279.el6.x86_64 SMP mod_unload modversions
>>
>> parm:           skip_host_reset:skip global host reset (0=3Ddon't sk=
ip,
>> 1=3Dskip) (int)
>>
>> parm:           ignore_sss:Ignore staggered spinup flag (0=3Ddon't
>> ignore, 1=3Dignore) (int)
>>
>> parm:           ahci_em_messages:AHCI Enclosure Management Message
>> control (0 =3D off, 1 =3D on) (int)
>>
>> parm:           marvell_enable:Marvell SATA via AHCI (1 =3D enabled)=
 (int)
>>
>> #yum install smartmontools
>>
>> #uname -u
>>
>> 2.6.32-279.el6.x86_64 #1 SMP Wed Jun 13 18:24:36 EDT 2012 x86_64
>> x86_64 x86_64 GNU/Linux
>>
>> # lsmod | grep ahci
>>
>> Module              Size  Used by
>>
>> ahci                   40871  8
>>
>> #cat /sys/module/ahci/parameters/ahci_em_messages  1
>>
>> #cat /sys/module/ahci/parameters/ignore_sss 0
>>
>> #cat /sys/module/ahci/parameters/marvell_enable
>>
>> 0
>>
>> #cat /sys/module/ahci/parameters/skip_host_reset
>>
>> 0
>>
>> from /var/log/messg
>>
>> =E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6
>>
>> kernel: ahci 0000:0a:00.0: PCI INT A -> GSI 30 (level, low) -> IRQ 3=
0
>>
>> kernel: ahci 0000:0a:00.0: AHCI 0001.0000 32 slots 1 ports 6 Gbps 0x=
1
>> impl SATA mode
>>
>> kernel: ahci 0000:0a:00.0: flags: 64bit ncq sntf led pio slum part
>>
>> kernel: scsi7 : ahci
>>
>> kernel: ata7: SATA max UDMA/133 abar m512@0xb9b00000 port 0xb9b00100=
 irq
>> 65
>>
>> kernel: ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>
>> kernel: ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>>
>> kernel: ata7.00: ATA-8: LITEONIT LGT-128B1P, VG7RDTB, max UDMA/133
>>
>> kernel: ata7.00: 250069680 sectors, multi 1: LBA48 NCQ (depth 31/32)=
, AA
>>
>> kernel: ata7.00: configured for UDMA/133
>> --------------------------------------
>> however:
>>
>> Xen Server 6.2
>>
>> #modinfo ahci
>>
>> filename:
>> /lib/modules/2.6.32.43-0.4.1.xs1.8.0.835.170778xen/kernel/drivers/at=
a/ahci.ko
>>
>> version: 3.0
>>
>> description: AHCI SATA low-level driver
>>
>> author: Jeff Garzik
>>
>> srcversion: 2A18A052E06680917E65277
>>
>> depends: libata
>>
>> vermagic: 2.6.32.43-0.4.1.xs1.8.0.835.170778xen SMP mod_unload
>> modversions Xen 686
>>
>> parm: skip_host_reset: skip global host reset (0=3Ddon=E2=80=99t ski=
p, 1=3Dskip) (int)
>>
>> parm: ignore_sss: Ignore staggered spinup flag (0=3Ddon=E2=80=99t ig=
nore, 1=3Dignore)
>> (int)
>>
>> parm: ahci_em_messages: Set AHCI Enclosure Management Message type
>> (0=3Ddisabled, 1=3DLED) (int)
>>
>> parm: marvell_enable: Marvell SATA via AHCI (1=3Denabled) (int)
>>
>>
>> Oracle vServer (v37306-01.iso)
>>
>> #uname -u
>>
>> 2.6.39-300.29.1.el5uek #1 SMP THu Feb 14 03:32:54 PST 2013 x86_64
>> GNU/Linux
>>
>>
>> #lsmod | grep ahci
>>
>> ahci 22884 0
>>
>> libahci 24254 1 ahci
>>
>>
>> #lspci
>>
>> 0a:00.0 SATA Controller: Marvell Technology Group LTd. Device 9183 (=
rev
>> 14)
>>
>>
>> #lspci -s 0a:00 -nn
>>
>> a:00.0 SATA Controller [0106]: Marvell Technology Group LTd. Device
>> 9183 [1b4b:9183] (rev 14)
>>
>>
>>
>> Many Thanks!
>> Dimitar Boyn
>>
>> --
>> -- LiveLoveDo
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-ide"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>



--=20
Dimitar Boyn
CEO

Cyclone Trading Company

Email:
dimitarboyn@cyclone-trading.com
IM: dimitarboyn (Skype)
Office 2 Mobile:
(408) 430 5577

http://www.linkedin.com/in/dimitarboyn
-- LiveLoveDo
