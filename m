Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D631C54EAA
	for <linux-ide@archiver.kernel.org>; Thu, 26 Jan 2023 00:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbjAZAep (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 25 Jan 2023 19:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbjAZAen (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 25 Jan 2023 19:34:43 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92574A237
        for <linux-ide@vger.kernel.org>; Wed, 25 Jan 2023 16:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674693279; x=1706229279;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jxfERFeqtdgiPpAG4bYeRswMlDlXJsIsv7KmhntT3Ws=;
  b=VBelME1XOT/DO3Aw5bpvd4qO9iHSvg599s+nz5IkfQUTDM+oQDWyijpK
   nHSVV8LNoFFWCmm4BAxjDEGJABJN1Ix9YQWDqzDTDzj91zNtopIl1TT0M
   Xbwk96F2bqKdzAg31UKyU76zNtUFmZ785xD/GffIlwxOgdDV4vxCTRaDO
   XMNHfZI4wHonnOaRZfYYDWh+xG/mDNK/vzXQoHjVPq2A/JoocupmcjHL2
   S3MlYXWqVP5njZN4l+lM6/CIxcDb+N8Azd3eooFUZClvDoW9zP8cqKbkk
   lO+Guka8GB7nLAGkaxM1xxTPK1ZXQeRhIAaMGG7wlbDfTtMNulFR0zzdo
   w==;
X-IronPort-AV: E=Sophos;i="5.97,246,1669046400"; 
   d="scan'208";a="220094469"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2023 08:34:38 +0800
IronPort-SDR: uJeiC4a2FJRvfIGGZvcPxu7vNFOC4aQUMCLey7V7cKOabYW9pclzBvS7oOp3odkTkxfwSceg2a
 UbIelRnx3kpOmjWq47rT0rXm1MMzasOhw5xy3DI7VnewQS6iXPD8PJt4XzaM/+FuqV5PLewybc
 Oucb/Pgpupzi8/L+vExi8OTU08F2cRvI4XEDgoiGz7NCufQzlTmWfV7QpH+B+d1GAPY9mizJzx
 ivAJvQR36jrpM0GFsp8WI6uvBQuvJAhR1PmsdrmQvaI+Tclp5FTrp7fyMGCPW/4hca7GpaSJce
 y6E=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2023 15:52:10 -0800
IronPort-SDR: HeM+WRQgc+i9SVIltXUlRNazfNqMcN7VDHS2CdHOgOr2dCmrBrzDcH1Ki1a0PpoaViYFFYmh7I
 LyTTohWjNH0y5FNEbR5B9eDoOloprKxTLFw+bQuqMsU5wd++Npx4fW3yDbRf6REgjS3nYDnKxV
 VovekEvIfcR2F/cb4hdeZFdh2PCiA6y+LCp/cQtNWGyXG4H6Hhl0BZaLoTnt32ITSuOA/FgD1N
 svPyR6Wobih0HwDvqjRrSYVRx6g1I31DvORyXsgUormm2ehkAz9SbczSOKPfUckbCrvFgANIle
 m2A=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2023 16:34:38 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P2MCy5KT2z1RvTp
        for <linux-ide@vger.kernel.org>; Wed, 25 Jan 2023 16:34:38 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674693278; x=1677285279; bh=jxfERFeqtdgiPpAG4bYeRswMlDlXJsIsv7K
        mhntT3Ws=; b=Ht7xph5jNvAMa+E3W50BFT3frD4MfxLgbWfR/cY/f8qQoCmv7Ni
        iMq5Y6k5e3cEwT76urx9fUrAWcuqYYb7SkMv0pdC0qlUYJOkRRpNvAKxAI1Q7lqt
        GzFnClv7Ql+5LGkcdpsUK5r4KOvrM+Q7Gr/+0U2jYJphkrscR47YwjImTnIx3ha8
        DxdFfpoVTOlsMmVnjEh7l4G8rWIIueolwdXWu9dAQZPE9fqpvO7XIZH+3KDDmXax
        DA5BJaijcYYoRtYVh0p1KmDo0v2IyqP3YvOlCpbUd44rdb/QU5W2dInEETjfmS6u
        slGRUEOA/uy5t9bSOhXcjJR83j2/F3JqSKg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QMiDzC-llIfs for <linux-ide@vger.kernel.org>;
        Wed, 25 Jan 2023 16:34:38 -0800 (PST)
Received: from [10.89.81.12] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.81.12])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P2MCx3lS6z1RvLy;
        Wed, 25 Jan 2023 16:34:37 -0800 (PST)
Message-ID: <930a0685-c741-110e-40c2-660754301e5a@opensource.wdc.com>
Date:   Thu, 26 Jan 2023 09:34:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: Marvel 88SE6121 fails with SATA-2/3 HDDs
Content-Language: en-US
To:     Hajo Noerenberg <hajo-linux-ide@noerenberg.de>,
        linux-ide@vger.kernel.org
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
References: <db6b48b7-d69a-564b-24f0-75fbd6a9e543@noerenberg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <db6b48b7-d69a-564b-24f0-75fbd6a9e543@noerenberg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2023/01/25 22:23, Hajo Noerenberg wrote:
>=20
> Bug report for Seagate Blackarmor NAS440 with Marvel 88SE6121 controlle=
r (AHCI kernel module): Very old SATA-1 HDDs (mostly laptop HDDs in my te=
sts) work flawlessly, SATA-2/3 consistently fail. Limiting SATA speed (li=
bata.force=3D1.5G ...) does not help.
>=20
> Interestingly, SATA-2/3 HDDs do work with U-Boot and 'ancient' 3.x kern=
els. There was a suspicion that it was the PCI subsystem (the change in k=
ernel 3.16 from kirkwood/pci.c to mvebu-pci). Pali Roh=C3=A1r did a great=
 job to investigate this problem very persistently, but in the end we did=
 not find a solution.
>=20
> Without knowing anything about this area, there was the assumption that=
 the problem must be at one of the lower levels close to the hardware.
>=20
> During some older tests with kernel 5.x I tried to re-integrate a modif=
ication from the Seagate vendor 2.6 kernel annotated there with "set 6121=
 Transmitter Pre-Emphasis to 4", but this did not change anything  (but i=
t may be that I didn't do it right).
>=20
> You can find all the details and a lot of logs in Bug https://bugzilla.=
kernel.org/show_bug.cgi?id=3D216094
>=20
> Please find [1] U-Boot and [2] Kernel (vanilla 6.2.0-rc5) logs attached=
, with:
> 88SE6121-port0 is a SATA-2 ST3500418AS (works with u-boot, fails with l=
inux kernel >3.16)
> 88SE6121-port1 is a SATA-1 ST3250310NS (always works)
> 88SE6121-port2 is (unused / not wired) PATA
> (during my tests I tried other SATA-1/2/3 drives to rule out a problem =
with a specific drive or vendor)
>=20
> I've been trying to resurrect my NAS440 for over 10 years with all the =
components (https://github.com/hn/seagate-blackarmor-nas), so I have the =
hardware available and am happy to persevere to try things or otherwise h=
elp.
>=20
> Hajo
>=20
>=20
> [1] U-Boot Log
>=20
> nas440> version
> U-Boot 2022.04 (Apr 11 2022 - 15:58:53 +0200)
> NAS 440
> nas440> pci enum
> pcie0.0: Link up
> nas440> scsi reset
>=20
> Reset SCSI
> scanning bus for devices...
> Target spinup took 0 ms.
> Target spinup took 0 ms.
> SATA link 2 timeout.
> AHCI 0001.0000 32 slots 3 ports 3 Gbps 0x7 impl SATA mode
> flags: 64bit ncq stag led pmp slum part
>   Device 0: (0:0) Vendor: ATA Prod.: ST3500418AS Rev: CC38
>             Type: Hard Disk
>             Capacity: 476940.0 MB =3D 465.7 GB (976773168 x 512)
>   Device 1: (1:0) Vendor: ATA Prod.: ST3250310NS Rev: SN04
>             Type: Hard Disk
>             Capacity: 238475.1 MB =3D 232.8 GB (488397168 x 512)
> nas440> scsi part 0
>=20
> Partition Map for SCSI device 0  --   Partition Type: DOS
>=20
> Part    Start Sector    Num Sectors     UUID            Type
>   1     2048            209715200       cba79dc0-01     83
>   2     209717248       767055920       cba79dc0-02     eb
> nas440> ext2ls scsi 0:1
> <DIR>       4096 .
> <DIR>       4096 ..
> <DIR>      16384 lost+found
>        568888832 foo
>=20
>=20
> [2] U-Boot Log
>=20
> root@nas440:~# uname -a
> Linux nas440 6.2.0-rc5 #1 Tue Jan 24 23:41:07 CET 2023 armv5tel GNU/Lin=
ux
> root@nas440:~# modprobe pci-mvebu
>=20
> [  208.588347] mvebu-pcie mbus@f1000000:pcie@82000000: host bridge /mbu=
s@f1000000/pcie@82000000 ranges:
> [  208.597651] mvebu-pcie mbus@f1000000:pcie@82000000:      MEM 0x00f10=
40000..0x00f1041fff -> 0x0000040000
> [  208.611351] mvebu-pcie mbus@f1000000:pcie@82000000:      MEM 0xfffff=
fffffffffff..0x00fffffffe -> 0x0100000000
> [  208.621380] mvebu-pcie mbus@f1000000:pcie@82000000:       IO 0xfffff=
fffffffffff..0x00fffffffe -> 0x0100000000
> [  208.641381] mvebu-pcie mbus@f1000000:pcie@82000000: pcie0.0: legacy =
INTx interrupts cannot be masked individually, /mbus@f1000000/pcie@820000=
00/pcie@1,0 does not contain intx interrupt
> [  208.667286] mvebu-pcie mbus@f1000000:pcie@82000000: PCI host bridge =
to bus 0000:00
> [  208.684189] pci_bus 0000:00: root bus resource [bus 00-ff]
> [  208.689802] pci_bus 0000:00: root bus resource [mem 0xf1040000-0xf10=
41fff] (bus address [0x00040000-0x00041fff])
> [  208.705363] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xeff=
fffff]
> [  208.712352] pci_bus 0000:00: root bus resource [io  0x1000-0xeffff]
> [  208.723392] pci 0000:00:01.0: [11ab:6281] type 01 class 0x060400
> [  208.739782] PCI: bus0: Fast back to back transfers disabled
> [  208.745470] pci 0000:00:01.0: bridge configuration invalid ([bus 00-=
00]), reconfiguring
> [  208.766397] pci 0000:01:00.0: [11ab:6121] type 00 class 0x01018f
> [  208.772921] pci 0000:01:00.0: reg 0x10: [io  0xc0000000-0xc0000007]
> [  208.779272] pci 0000:01:00.0: reg 0x14: [io  0xc0000008-0xc000000b]
> [  208.785607] pci 0000:01:00.0: reg 0x18: [io  0xc0000010-0xc0000017]
> [  208.791937] pci 0000:01:00.0: reg 0x1c: [io  0xc0000018-0xc000001b]
> [  208.798267] pci 0000:01:00.0: reg 0x20: [io  0xc0000020-0xc000002f]
> [  208.804598] pci 0000:01:00.0: reg 0x24: [mem 0x90000000-0x900003ff]
> [  208.818936] pci 0000:01:00.0: supports D1
> [  208.823276] pci 0000:01:00.0: PME# supported from D0 D1 D3hot
> [  208.840601] PCI: bus1: Fast back to back transfers disabled
> [  208.846297] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to=
 01
> [  208.879294] pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-0xe00f=
ffff]
> [  208.886183] pci 0000:00:01.0: BAR 7: assigned [io  0x10000-0x10fff]
> [  208.901547] pci 0000:01:00.0: BAR 5: assigned [mem 0xe0000000-0xe000=
03ff]
> [  208.908459] pci 0000:01:00.0: BAR 4: assigned [io  0x10000-0x1000f]
> [  208.914896] pci 0000:01:00.0: BAR 0: assigned [io  0x10010-0x10017]
> [  208.921238] pci 0000:01:00.0: BAR 2: assigned [io  0x10018-0x1001f]
> [  208.927576] pci 0000:01:00.0: BAR 1: assigned [io  0x10020-0x10023]
> [  208.933905] pci 0000:01:00.0: BAR 3: assigned [io  0x10024-0x10027]
> [  208.940240] pci 0000:00:01.0: PCI bridge to [bus 01]
> [  208.945257] pci 0000:00:01.0:   bridge window [io  0x10000-0x10fff]
> [  208.951596] pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xe00f=
ffff]
> [  208.992175] pcieport 0000:00:01.0: enabling device (0140 -> 0143)
> [  209.007014] ahci 0000:01:00.0: Disabling your PATA port. Use the boo=
t option 'ahci.marvell_enable=3D0' to avoid this.

See drivers/ata/ahci.c:

	/* The AHCI driver can only drive the SATA ports, the PATA driver
           can drive them all so if both drivers are selected make sure
           AHCI stays out of the way */

Can you try the pata driver instead: pata_marvell (CONFIG_PATA_MARVELL).

> [  209.017595] ahci 0000:01:00.0: controller can't do NCQ, turning off =
CAP_NCQ
> [  209.024616] ahci 0000:01:00.0: controller can't do PMP, turning off =
CAP_PMP
> [  209.031635] ahci 0000:01:00.0: masking port_map 0x7 -> 0x3
> [  209.067304] ahci 0000:01:00.0: SSS flag set, parallel bus scan disab=
led
> [  209.074078] ahci 0000:01:00.0: AHCI 0001.0000 32 slots 3 ports 3 Gbp=
s 0x3 impl IDE mode
> [  209.082187] ahci 0000:01:00.0: flags: 64bit stag led slum part
> [  209.107629] scsi host3: ahci
> [  209.117716] scsi host4: ahci
> [  209.131433] scsi host5: ahci
> [  209.134706] ata3: SATA max UDMA/133 abar m1024@0xe0000000 port 0xe00=
00100 irq 39
> [  209.142214] ata4: SATA max UDMA/133 abar m1024@0xe0000000 port 0xe00=
00180 irq 39
> [  209.149676] ata5: DUMMY
> [  209.469562] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  214.631228] ata3.00: qc timeout after 5000 msecs (cmd 0xec)
> [  214.636919] ata3.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
> [  214.957579] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  225.127261] ata3.00: qc timeout after 10000 msecs (cmd 0xec)
> [  225.133030] ata3.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
> [  225.139184] ata3: limiting SATA link speed to 1.5 Gbps
> [  225.457616] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [  257.127404] ata3.00: qc timeout after 30000 msecs (cmd 0xec)
> [  257.133181] ata3.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
> [  257.453758] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [  257.773761] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [  257.781254] ata4.00: ATA-6: ST3250310NS, SN04, max UDMA/133
> [  257.786916] ata4.00: 488397168 sectors, multi 0: LBA48 NCQ (depth 0/=
32)
> [  257.796826] ata4.00: configured for UDMA/133
> [  257.801537] scsi 4:0:0:0: Direct-Access     ATA      ST3250310NS    =
  SN04 PQ: 0 ANSI: 5

Is this a SATA-1 drive (max 1.5gbps) ? port 3 does not work, but port 4 d=
oes...
Can you try swapping the drives connected to see if you end up with ata3 =
working
but not ata4 ?

> [  257.820228] sd 4:0:0:0: [sdd] 488397168 512-byte logical blocks: (25=
0 GB/233 GiB)
> [  257.828149] sd 4:0:0:0: Attached scsi generic sg3 type 0
> [  257.843562] sd 4:0:0:0: [sdd] Write Protect is off
> [  257.859628] sd 4:0:0:0: [sdd] Write cache: enabled, read cache: enab=
led, doesn't support DPO or FUA
> [  257.879625] sd 4:0:0:0: [sdd] Preferred minimum I/O size 512 bytes
> [  257.918058]  sdd: sdd1 sdd2
> [  257.920294] sd 4:0:0:0: [sdd] Attached SCSI disk
>=20

--=20
Damien Le Moal
Western Digital Research

