From: Mark Nelson <mdnelson8@gmail.com>
Subject: Re: [PATCH] ahci: Enable SB600 64bit DMA on MSI K9A2 Platinum
Date: Wed, 28 Oct 2009 22:49:32 +1100
Message-ID: <65a6ef750910280449k5597d3abkc0995080954e5760@mail.gmail.com>
References: <65a6ef750910252203s58af446fv268c857191e698d3@mail.gmail.com>
	 <4AE5A330.3080506@kernel.org>
	 <65a6ef750910261605q45a08791h53cc2afd5d006bb3@mail.gmail.com>
	 <4AE7382F.20302@kernel.org>
	 <65a6ef750910271551i47858982xd1138e4a70a1b076@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f208.google.com ([209.85.219.208]:52155 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705AbZJ1Lt3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Oct 2009 07:49:29 -0400
Received: by ewy4 with SMTP id 4so639508ewy.37
        for <linux-ide@vger.kernel.org>; Wed, 28 Oct 2009 04:49:32 -0700 (PDT)
In-Reply-To: <65a6ef750910271551i47858982xd1138e4a70a1b076@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, jeff@garzik.org

On Wed, Oct 28, 2009 at 9:51 AM, Mark Nelson <mdnelson8@gmail.com> wrot=
e:
> Adding back linux-ide and Jeff (accidentally dropped them off on my f=
irst reply)
>
> On Wed, Oct 28, 2009 at 5:13 AM, Tejun Heo <tj@kernel.org> wrote:
>> Hello, Mark.
>>
>> Mark Nelson wrote:
>>>>From reading this bug report:
>>> http://bugzilla.kernel.org/show_bug.cgi?id=3D14275
>>> it sounds like when the SB600 can't do 64bit DMA the machine can fa=
il to boot.
>>>
>>> I've been using the system with a patch that removes the AHCI_HFLAG=
_32BIT_ONLY
>>> from board_ahci_sb600 for a few months now, but the system only has=
 4GB of RAM,
>>> with some of it hoisted over the 32bit mark:
>>>
>>> Memory: 4048052k/4980736k available (2010k kernel code, 145176k
>>> reserved, 922k data, 228k init)
>>>
>>> This probably isn't a rigorous enough test though... What is the be=
st way to
>>> verify it (and that way I can check more BIOS versions)?
>>
>> The surest way would be to put one time printk which prints out the
>> physical dma address if it's above 4G in the issue path. =A0Somethin=
g
>> like the following (completely untested).
>>
>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> index b1a2577..08b987d 100644
>> --- a/drivers/ata/ahci.c
>> +++ b/drivers/ata/ahci.c
>> @@ -2019,6 +2019,11 @@ static unsigned int ahci_fill_sg(struct ata_q=
ueued_cmd *qc, void *cmd_tbl)
>> =A0 =A0 =A0 =A0for_each_sg(qc->sg, sg, qc->n_elem, si) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_addr_t addr =3D sg_dma_address(sg=
);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 sg_len =3D sg_dma_len(sg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 static int cnt;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (addr > 0xffffffffULL && !(cnt++ % =
500))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("ahci: dma'ing =
to address 0x%llx\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsign=
ed long long)addr);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ahci_sg[si].addr =3D cpu_to_le32(addr=
 & 0xffffffff);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ahci_sg[si].addr_hi =3D cpu_to_le32((=
addr >> 16) >> 16);
>>
>
> That looks good. I'll have a play with it and see what I get.
>

Things look promising so far with lots of DMAs above 4GB (snippets from=
 syslog):

ahci 0000:00:12.0: version 3.0
ahci 0000:00:12.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
ahci 0000:00:12.0: MSI K9A2 Platinum: enabling 64bit DMA
ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl
SATA mode
ahci 0000:00:12.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum
part ccc
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 irq_stat 0x00400000, PHY RDY changed irq 22
ata2: SATA max UDMA/133 abar m1024@0xfbcff800 port 0xfbcff980 irq 22
ata3: SATA max UDMA/133 abar m1024@0xfbcff800 port 0xfbcffa00 irq 22
ata4: SATA max UDMA/133 abar m1024@0xfbcff800 port 0xfbcffa80 irq 22
pata_atiixp 0000:00:14.1: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pata_atiixp 0000:00:14.1: setting latency timer to 64
scsi4 : pata_atiixp
scsi5 : pata_atiixp
ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00 irq 14
ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xff08 irq 15
ata5.00: ATAPI: PIONEER DVD-RW  DVR-111D, 1.29, max UDMA/66
ata5.01: ATAPI: HL-DT-ST GCE-8520B, 1.02, max UDMA/33
ata5.00: configured for UDMA/66
ata5.01: configured for UDMA/33
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link down (SStatus 0 SControl 300)
ata2: SATA link down (SStatus 0 SControl 300)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ahci: dma'ing to address 0x12ee49ed8
ata1.00: ATA-7: ST3320620AS, 3.AAD, max UDMA/133
ata1.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0
ANSI: 5
sd 0:0:0:0: [sda] 625142448 512-byte logical blocks: (320 GB/298 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda:
scsi 4:0:0:0: CD-ROM            PIONEER  DVD-RW  DVR-111D 1.29 PQ: 0
ANSI: 5
sr0: scsi3-mmc drive: 62x/62x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 4:0:0:0: Attached scsi CD-ROM sr0
scsi 4:0:1:0: CD-ROM            HL-DT-ST CD-RW GCE-8520B  1.02 PQ: 0
ANSI: 5
sr1: scsi3-mmc drive: 40x/52x writer cd/rw xa/form2 cdda tray
sr 4:0:1:0: Attached scsi CD-ROM sr1
 sda1 sda2 sda3 sda4 < sda5 sda6 >
sd 0:0:0:0: [sda] Attached SCSI disk
EXT4-fs (sda5): mounted filesystem with ordered data mode
VFS: Mounted root (ext4 filesystem) readonly on device 8:5.
=46reeing unused kernel memory: 392k freed
ahci: dma'ing to address 0x12e9a8000
ahci: dma'ing to address 0x12e57a000
ahci: dma'ing to address 0x12d455000
sd 0:0:0:0: Attached scsi generic sg0 type 0
sr 4:0:0:0: Attached scsi generic sg1 type 5
sr 4:0:1:0: Attached scsi generic sg2 type 5
ahci: dma'ing to address 0x12e13f000
ahci: dma'ing to address 0x12dd65000
ahci: dma'ing to address 0x12e594000
ahci: dma'ing to address 0x12e29a000
ahci: dma'ing to address 0x12df02000
ahci: dma'ing to address 0x12cf0d200
Adding 4939948k swap on /dev/sda6.  Priority:-1 extents:1
across:4939948k
ahci: dma'ing to address 0x12d774000
ahci: dma'ing to address 0x12c40c000
ahci: dma'ing to address 0x12c01a000
ahci: dma'ing to address 0x12c3ac000
ahci: dma'ing to address 0x12beca000
ahci: dma'ing to address 0x12b25a000
ahci: dma'ing to address 0x1294b5000
ahci: dma'ing to address 0x12905d000
ahci: dma'ing to address 0x12934a000
ahci: dma'ing to address 0x1287df000
ahci: dma'ing to address 0x1289c2000
ahci: dma'ing to address 0x1264f0000
ahci: dma'ing to address 0x1268a7000
ahci: dma'ing to address 0x1262ab000
ahci: dma'ing to address 0x12501b000
ahci: dma'ing to address 0x124162000
ahci: dma'ing to address 0x1261a1000
ahci: dma'ing to address 0x12362c000
ahci: dma'ing to address 0x122b1a000
ahci: dma'ing to address 0x121887000
ahci: dma'ing to address 0x12101c000
ahci: dma'ing to address 0x120b4b000
ahci: dma'ing to address 0x11f56b000
ahci: dma'ing to address 0x11ef71000
ahci: dma'ing to address 0x120314000
ahci: dma'ing to address 0x1274e9000
ahci: dma'ing to address 0x11e129000
ahci: dma'ing to address 0x11d065000
ahci: dma'ing to address 0x11cefe000
ahci: dma'ing to address 0x11c607000
ahci: dma'ing to address 0x11c384000
ahci: dma'ing to address 0x1194bb000
ahci: dma'ing to address 0x11881e000
ahci: dma'ing to address 0x118669000
ahci: dma'ing to address 0x1178e7000
ahci: dma'ing to address 0x116c0c000
ahci: dma'ing to address 0x116b1b000
ahci: dma'ing to address 0x1167fe000
ahci: dma'ing to address 0x11550f000
ahci: dma'ing to address 0x114cd3000
ahci: dma'ing to address 0x1147c9000
ahci: dma'ing to address 0x12464a000
ahci: dma'ing to address 0x11cf76000
ahci: dma'ing to address 0x111970000
ahci: dma'ing to address 0x110bbf000

This was running with BIOS version 1.8. I'll try to test more BIOS
revisions to work out exactly which ones work with 64bit DMA.

Thanks!
Mark
