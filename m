From: Valerio Passini <valerio.passini@unicam.it>
Subject: Re: http://bugzilla.kernel.org/show_bug.cgi?id=11742
Date: Thu, 23 Oct 2008 00:20:15 +0200
Message-ID: <200810230020.15257.valerio.passini@unicam.it>
References: <20081020112039W.fujita.tomonori@lab.ntt.co.jp> <200810221645.22289.valerio.passini@unicam.it> <9ea470500810220857o153dd0fica23dc877fa895ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.unicam.it ([193.204.8.1]:46593 "HELO unicam.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760060AbYJVWUX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Oct 2008 18:20:23 -0400
In-Reply-To: <9ea470500810220857o153dd0fica23dc877fa895ce@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com, linux-ide@vger.kernel.org

Alle mercoled=EC 22 ottobre 2008, Boris Petkov ha scritto:
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index f16bb46..98051e4 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -1165,7 +1165,6 @@ static void cdrom_do_block_pc(ide_drive_t
> *drive, struct request *rq)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct request_queue =
*q =3D drive->queue;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0unsigned int alignmen=
t;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0unsigned long addr;
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0unsigned long stack_mas=
k =3D ~(THREAD_SIZE - 1);
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (rq->bio)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0addr =3D (unsigned long)bio_data(rq->bio);
> @@ -1181,12 +1180,15 @@ static void cdrom_do_block_pc(ide_drive_t
> *drive, struct request *rq)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * separate masks.
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0alignment =3D queue_d=
ma_alignment(q) | q->dma_pad_mask;
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (addr & alignment ||=
 rq->data_len & alignment)
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
info->dma =3D 0;
> -
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!((addr & stack_mas=
k) ^
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0((unsigned =
long)current->stack & stack_mask)))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (addr & alignment ||=
 rq->data_len & alignment
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
|| object_is_on_stack((void *)addr)) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
printk(KERN_ERR "Disabling dma for ATA_PC, "
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"queue_dma_alignment: 0=
x%x, q->dma_pad_mask: 0x%x,"
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"addr: 0x%lx, rq->data_=
len: 0x%x, on_stack: %d\n",
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0queue_dma_alignment(q),=
 q->dma_pad_mask, addr,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0rq->data_len, object_is=
_on_stack((void *)addr));
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0info->dma =3D 0;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> =A0=A0=A0=A0=A0=A0=A0=A0}
> =A0}

Hi Boris, first thank you for giving me that hint: kmail it's really my=
 email client and it's guilty for the behaviour of cut and pasted text.=
=2E.

I've just tried your patch above and it doesn't work and I have noticed=
 a lot of messages during boot (see below). The behavior of the patched=
 kernel it's almost the same of the plain 2.6.27 but with an important =
difference: before the device buffer starts to empty itself, it's the s=
oftware buffer to decrease for first, anyhow a lot of buffer underruns.=
=20
I have checked with hdparm the mode the driver is set, but it's ok: DMA=
=2E
$ hdparm /dev/hda

/dev/hda:
 IO_support    =3D  0 (default)
 unmaskirq     =3D  0 (off)
 using_dma     =3D  1 (on)
 keepsettings  =3D  0 (off)
 readonly      =3D  0 (off)
 readahead     =3D 256 (on)
 HDIO_GETGEO failed: Inappropriate ioctl for device

 dmesg
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.27.1bp (root@Abraracourcix) (gcc versi=
on 4.3.2 (Debian 4.3.2-1) ) #1 SMP PREEMPT Wed Oct 22 23:32:49 CEST 200=
8
[    0.000000] Command line: root=3D/dev/sda2 ro quiet vga=3D865
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserve=
d)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000bfed0000 (usable)
[    0.000000]  BIOS-e820: 00000000bfed0000 - 00000000bfee1000 (ACPI NV=
S)
[    0.000000]  BIOS-e820: 00000000bfee1000 - 00000000c0000000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserve=
d)
[    0.000000] last_pfn =3D 0xbfed0 max_arch_pfn =3D 0x3ffffffff
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x70106=
00070106
[    0.000000] total RAM coverred: 3071M
[    0.000000]  gran_size: 1M 	chunk_size: 1M 	num_reg: 8 	lose RAM: 7M
[    0.000000]  gran_size: 1M 	chunk_size: 2M 	num_reg: 8 	lose RAM: 7M
[    0.000000]  gran_size: 1M 	chunk_size: 4M 	num_reg: 8 	lose RAM: 7M
[    0.000000]  gran_size: 1M 	chunk_size: 8M 	num_reg: 8 	lose RAM: 7M
[    0.000000] *BAD* gran_size: 1M 	chunk_size: 16M 	num_reg: 8 	lose R=
AM: -1M
[    0.000000]  gran_size: 1M 	chunk_size: 32M 	num_reg: 8 	lose RAM: 0=
M
[    0.000000]  gran_size: 1M 	chunk_size: 64M 	num_reg: 7 	lose RAM: 0=
M
[    0.000000]  gran_size: 1M 	chunk_size: 128M 	num_reg: 6 	lose RAM: =
0M
[    0.000000]  gran_size: 1M 	chunk_size: 256M 	num_reg: 5 	lose RAM: =
0M
[    0.000000]  gran_size: 1M 	chunk_size: 512M 	num_reg: 4 	lose RAM: =
0M
[    0.000000]  gran_size: 1M 	chunk_size: 1024M 	num_reg: 3 	lose RAM:=
 0M
[    0.000000]  gran_size: 1M 	chunk_size: 2048M 	num_reg: 8 	lose RAM:=
 7M
[    0.000000]  gran_size: 1M 	chunk_size: 4096M 	num_reg: 3 	lose RAM:=
 0M
[    0.000000]  gran_size: 2M 	chunk_size: 2M 	num_reg: 8 	lose RAM: 7M
[    0.000000]  gran_size: 2M 	chunk_size: 4M 	num_reg: 8 	lose RAM: 7M
[    0.000000]  gran_size: 2M 	chunk_size: 8M 	num_reg: 8 	lose RAM: 7M
[    0.000000] *BAD* gran_size: 2M 	chunk_size: 16M 	num_reg: 8 	lose R=
AM: -1M
[    0.000000]  gran_size: 2M 	chunk_size: 32M 	num_reg: 8 	lose RAM: 1=
M
[    0.000000]  gran_size: 2M 	chunk_size: 64M 	num_reg: 7 	lose RAM: 1=
M
[    0.000000]  gran_size: 2M 	chunk_size: 128M 	num_reg: 6 	lose RAM: =
1M
[    0.000000]  gran_size: 2M 	chunk_size: 256M 	num_reg: 5 	lose RAM: =
1M
[    0.000000]  gran_size: 2M 	chunk_size: 512M 	num_reg: 4 	lose RAM: =
1M
[    0.000000]  gran_size: 2M 	chunk_size: 1024M 	num_reg: 3 	lose RAM:=
 1M
[    0.000000]  gran_size: 2M 	chunk_size: 2048M 	num_reg: 8 	lose RAM:=
 7M
[    0.000000]  gran_size: 2M 	chunk_size: 4096M 	num_reg: 3 	lose RAM:=
 1M
[    0.000000]  gran_size: 4M 	chunk_size: 4M 	num_reg: 8 	lose RAM: 7M
[    0.000000]  gran_size: 4M 	chunk_size: 8M 	num_reg: 8 	lose RAM: 7M
[    0.000000] *BAD* gran_size: 4M 	chunk_size: 16M 	num_reg: 8 	lose R=
AM: -1M
[    0.000000]  gran_size: 4M 	chunk_size: 32M 	num_reg: 8 	lose RAM: 3=
M
[    0.000000]  gran_size: 4M 	chunk_size: 64M 	num_reg: 7 	lose RAM: 3=
M
[    0.000000]  gran_size: 4M 	chunk_size: 128M 	num_reg: 6 	lose RAM: =
3M
[    0.000000]  gran_size: 4M 	chunk_size: 256M 	num_reg: 5 	lose RAM: =
3M
[    0.000000]  gran_size: 4M 	chunk_size: 512M 	num_reg: 4 	lose RAM: =
3M
[    0.000000]  gran_size: 4M 	chunk_size: 1024M 	num_reg: 3 	lose RAM:=
 3M
[    0.000000]  gran_size: 4M 	chunk_size: 2048M 	num_reg: 8 	lose RAM:=
 7M
[    0.000000]  gran_size: 4M 	chunk_size: 4096M 	num_reg: 3 	lose RAM:=
 3M
[    0.000000]  gran_size: 8M 	chunk_size: 8M 	num_reg: 8 	lose RAM: 7M
[    0.000000]  gran_size: 8M 	chunk_size: 16M 	num_reg: 8 	lose RAM: 7=
M
[    0.000000]  gran_size: 8M 	chunk_size: 32M 	num_reg: 8 	lose RAM: 7=
M
[    0.000000]  gran_size: 8M 	chunk_size: 64M 	num_reg: 7 	lose RAM: 7=
M
[    0.000000]  gran_size: 8M 	chunk_size: 128M 	num_reg: 6 	lose RAM: =
7M
[    0.000000]  gran_size: 8M 	chunk_size: 256M 	num_reg: 5 	lose RAM: =
7M
[    0.000000]  gran_size: 8M 	chunk_size: 512M 	num_reg: 4 	lose RAM: =
7M
[    0.000000]  gran_size: 8M 	chunk_size: 1024M 	num_reg: 3 	lose RAM:=
 7M
[    0.000000]  gran_size: 8M 	chunk_size: 2048M 	num_reg: 8 	lose RAM:=
 7M
[    0.000000]  gran_size: 8M 	chunk_size: 4096M 	num_reg: 3 	lose RAM:=
 7M
[    0.000000]  gran_size: 16M 	chunk_size: 16M 	num_reg: 7 	lose RAM: =
15M
[    0.000000]  gran_size: 16M 	chunk_size: 32M 	num_reg: 7 	lose RAM: =
15M
[    0.000000]  gran_size: 16M 	chunk_size: 64M 	num_reg: 7 	lose RAM: =
15M
[    0.000000]  gran_size: 16M 	chunk_size: 128M 	num_reg: 6 	lose RAM:=
 15M
[    0.000000]  gran_size: 16M 	chunk_size: 256M 	num_reg: 5 	lose RAM:=
 15M
[    0.000000]  gran_size: 16M 	chunk_size: 512M 	num_reg: 4 	lose RAM:=
 15M
[    0.000000]  gran_size: 16M 	chunk_size: 1024M 	num_reg: 3 	lose RAM=
: 15M
[    0.000000]  gran_size: 16M 	chunk_size: 2048M 	num_reg: 7 	lose RAM=
: 15M
[    0.000000]  gran_size: 16M 	chunk_size: 4096M 	num_reg: 3 	lose RAM=
: 15M
[    0.000000]  gran_size: 32M 	chunk_size: 32M 	num_reg: 6 	lose RAM: =
31M
[    0.000000]  gran_size: 32M 	chunk_size: 64M 	num_reg: 6 	lose RAM: =
31M
[    0.000000]  gran_size: 32M 	chunk_size: 128M 	num_reg: 6 	lose RAM:=
 31M
[    0.000000]  gran_size: 32M 	chunk_size: 256M 	num_reg: 5 	lose RAM:=
 31M
[    0.000000]  gran_size: 32M 	chunk_size: 512M 	num_reg: 4 	lose RAM:=
 31M
[    0.000000]  gran_size: 32M 	chunk_size: 1024M 	num_reg: 3 	lose RAM=
: 31M
[    0.000000]  gran_size: 32M 	chunk_size: 2048M 	num_reg: 6 	lose RAM=
: 31M
[    0.000000]  gran_size: 32M 	chunk_size: 4096M 	num_reg: 3 	lose RAM=
: 31M
[    0.000000]  gran_size: 64M 	chunk_size: 64M 	num_reg: 5 	lose RAM: =
63M
[    0.000000]  gran_size: 64M 	chunk_size: 128M 	num_reg: 5 	lose RAM:=
 63M
[    0.000000]  gran_size: 64M 	chunk_size: 256M 	num_reg: 5 	lose RAM:=
 63M
[    0.000000]  gran_size: 64M 	chunk_size: 512M 	num_reg: 4 	lose RAM:=
 63M
[    0.000000]  gran_size: 64M 	chunk_size: 1024M 	num_reg: 3 	lose RAM=
: 63M
[    0.000000]  gran_size: 64M 	chunk_size: 2048M 	num_reg: 5 	lose RAM=
: 63M
[    0.000000]  gran_size: 64M 	chunk_size: 4096M 	num_reg: 3 	lose RAM=
: 63M
[    0.000000]  gran_size: 128M 	chunk_size: 128M 	num_reg: 4 	lose RAM=
: 127M
[    0.000000]  gran_size: 128M 	chunk_size: 256M 	num_reg: 4 	lose RAM=
: 127M
[    0.000000]  gran_size: 128M 	chunk_size: 512M 	num_reg: 4 	lose RAM=
: 127M
[    0.000000]  gran_size: 128M 	chunk_size: 1024M 	num_reg: 3 	lose RA=
M: 127M
[    0.000000]  gran_size: 128M 	chunk_size: 2048M 	num_reg: 4 	lose RA=
M: 127M
[    0.000000]  gran_size: 128M 	chunk_size: 4096M 	num_reg: 3 	lose RA=
M: 127M
[    0.000000]  gran_size: 256M 	chunk_size: 256M 	num_reg: 3 	lose RAM=
: 255M
[    0.000000]  gran_size: 256M 	chunk_size: 512M 	num_reg: 3 	lose RAM=
: 255M
[    0.000000]  gran_size: 256M 	chunk_size: 1024M 	num_reg: 3 	lose RA=
M: 255M
[    0.000000]  gran_size: 256M 	chunk_size: 2048M 	num_reg: 3 	lose RA=
M: 255M
[    0.000000]  gran_size: 256M 	chunk_size: 4096M 	num_reg: 3 	lose RA=
M: 255M
[    0.000000]  gran_size: 512M 	chunk_size: 512M 	num_reg: 2 	lose RAM=
: 511M
[    0.000000]  gran_size: 512M 	chunk_size: 1024M 	num_reg: 2 	lose RA=
M: 511M
[    0.000000]  gran_size: 512M 	chunk_size: 2048M 	num_reg: 2 	lose RA=
M: 511M
[    0.000000]  gran_size: 512M 	chunk_size: 4096M 	num_reg: 3 	lose RA=
M: 511M
[    0.000000]  gran_size: 1024M 	chunk_size: 1024M 	num_reg: 1 	lose R=
AM: 1023M
[    0.000000]  gran_size: 1024M 	chunk_size: 2048M 	num_reg: 1 	lose R=
AM: 1023M
[    0.000000]  gran_size: 1024M 	chunk_size: 4096M 	num_reg: 1 	lose R=
AM: 1023M
[    0.000000]  gran_size: 2048M 	chunk_size: 2048M 	num_reg: 1 	lose R=
AM: 1023M
[    0.000000]  gran_size: 2048M 	chunk_size: 4096M 	num_reg: 1 	lose R=
AM: 1023M
[    0.000000] Found optimal setting for mtrr clean up
[    0.000000] gran_size: 1M 	chunk_size: 64M 	num_reg: 7 	lose RAM: 0M
[    0.000000] range0: 0000000000000000 - 00000000bc000000
[    0.000000] Setting variable MTRR 0, base: 0MB, range: 2048MB, type =
WB
[    0.000000] Setting variable MTRR 1, base: 2048MB, range: 512MB, typ=
e WB
[    0.000000] Setting variable MTRR 2, base: 2560MB, range: 256MB, typ=
e WB
[    0.000000] Setting variable MTRR 3, base: 2816MB, range: 128MB, typ=
e WB
[    0.000000] Setting variable MTRR 4, base: 2944MB, range: 64MB, type=
 WB
[    0.000000] range: 00000000bc000000 - 00000000c0000000
[    0.000000] Setting variable MTRR 5, base: 3008MB, range: 64MB, type=
 WB
[    0.000000] hole: 00000000bff00000 - 00000000c0000000
[    0.000000] Setting variable MTRR 6, base: 3071MB, range: 1MB, type =
UC
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x70106=
00070106
[    0.000000] After WB checking
[    0.000000] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[    0.000000] After UC checking
[    0.000000] MTRR MAP PFN: 0000000000000000 - 00000000000bff00
[    0.000000] After sorting
[    0.000000] MTRR MAP PFN: 0000000000000000 - 00000000000bff00
[    0.000000] init_memory_mapping
[    0.000000]  0000000000 - 00bfe00000 page 2M
[    0.000000]  00bfe00000 - 00bfed0000 page 4k
[    0.000000] kernel direct mapping tables up to bfed0000 @ 8000-d000
[    0.000000] last_map_addr: bfed0000 end: bfed0000
[    0.000000] RAMDISK: 37ac4000 - 37fef698
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP 000F7AE0, 0024 (r2 PTLTD )
[    0.000000] ACPI: XSDT BFED3907, 007C (r1 ACRSYS ACRPRDCT  6040000  =
LTP        0)
[    0.000000] ACPI: FACP BFEDDC2A, 00F4 (r3 INTEL  CRESTLNE  6040000 A=
LAN        1)
[    0.000000] ACPI: DSDT BFED4DB5, 8E01 (r2 INTEL  CRESTLNE  6040000 M=
SFT  3000001)
[    0.000000] ACPI: FACS BFEE0FC0, 0040
[    0.000000] ACPI: APIC BFEDDD1E, 0068 (r1 INTEL  CRESTLNE  6040000 L=
OHR       5A)
[    0.000000] ACPI: HPET BFEDDD86, 0038 (r1 INTEL  CRESTLNE  6040000 L=
OHR       5A)
[    0.000000] ACPI: MCFG BFEDDDBE, 003C (r1 INTEL  CRESTLNE  6040000 L=
OHR       5A)
[    0.000000] ACPI: APIC BFEDDDFA, 0068 (r1 PTLTD  	 APIC    6040000  =
LTP        0)
[    0.000000] ACPI: BOOT BFEDDE62, 0028 (r1 PTLTD  $SBFTBL$  6040000  =
LTP        1)
[    0.000000] ACPI: SLIC BFEDDE8A, 0176 (r1 ACRSYS ACRPRDCT  6040000 a=
cer        0)
[    0.000000] ACPI: SSDT BFED4AD8, 02DD (r1 SataRe SataAhci     1000 I=
NTL 20050624)
[    0.000000] ACPI: SSDT BFED3F3F, 025F (r1  PmRef  Cpu0Tst     3000 I=
NTL 20050624)
[    0.000000] ACPI: SSDT BFED3E99, 00A6 (r1  PmRef  Cpu1Tst     3000 I=
NTL 20050624)
[    0.000000] ACPI: SSDT BFED3983, 0516 (r1  PmRef    CpuPm     3000 I=
NTL 20050624)
[    0.000000] ACPI: BIOS bug: multiple APIC/MADT found, using 0
[    0.000000] ACPI: If "acpi_apic_instance=3D2" works better, notify l=
inux-acpi@vger.kernel.org
[    0.000000] ACPI: DMI detected: Acer
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-00000000bfed0000
[    0.000000] Bootmem setup node 0 0000000000000000-00000000bfed0000
[    0.000000]   NODE_DATA [000000000000b000 - 0000000000019fff]
[    0.000000]   bootmap [000000000001a000 -  0000000000031fdf] pages 1=
8
[    0.000000] (6 early reservations) =3D=3D> bootmem [0000000000 - 00b=
fed0000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page =3D=3D> =
[0000000000 - 0000001000]
[    0.000000]   #1 [0000006000 - 0000008000]       TRAMPOLINE =3D=3D> =
[0000006000 - 0000008000]
[    0.000000]   #2 [0000200000 - 0000859b58]    TEXT DATA BSS =3D=3D> =
[0000200000 - 0000859b58]
[    0.000000]   #3 [0037ac4000 - 0037fef698]          RAMDISK =3D=3D> =
[0037ac4000 - 0037fef698]
[    0.000000]   #4 [000009f800 - 0000100000]    BIOS reserved =3D=3D> =
[000009f800 - 0000100000]
[    0.000000]   #5 [0000008000 - 000000b000]          PGTABLE =3D=3D> =
[0000008000 - 000000b000]
[    0.000000] found SMP MP-table at [ffff8800000f7b10] 000f7b10
[    0.000000]  [ffffe20000000000-ffffe200029fffff] PMD -> [ffff8800012=
00000-ffff880003bfffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00100000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x000bfed0
[    0.000000] On node 0 totalpages: 786031
[    0.000000]   DMA zone: 2214 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 771340 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 0, address 0xfec00000, GSI=
 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high lev=
el)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 0000000=
0000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 0000000=
0000ce000
[    0.000000] PM: Registered nosave memory: 00000000000ce000 - 0000000=
0000d0000
[    0.000000] PM: Registered nosave memory: 00000000000d0000 - 0000000=
0000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000=
000100000
[    0.000000] Allocating PCI resources starting at c2000000 (gap: c000=
0000:20000000)
[    0.000000] PERCPU: Allocating 45152 bytes of per cpu data
[    0.000000] NR_CPUS: 2, nr_cpu_ids: 2, nr_node_ids 1
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  =
Total pages: 773554
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: root=3D/dev/sda2 ro quiet vga=3D865
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Extended CMOS year: 2000
[    0.000000] TSC: PIT calibration confirmed by PMTIMER.
[    0.000000] TSC: using PIT calibration value
[    0.000000] Detected 1833.439 MHz processor.
[    0.000999] Console: colour dummy device 80x25
[    0.000999] console [tty0] enabled
[    0.000999] Checking aperture...
[    0.000999] No AGP bridge found
[    0.000999] Memory: 3088960k/3144512k available (2998k kernel code, =
55164k reserved, 1230k data, 428k init)
[    0.000999] CPA: page pool initialized 1 of 1 pages preallocated
[    0.000999] SLUB: Genslabs=3D13, HWalign=3D64, Order=3D0-3, MinObjec=
ts=3D0, CPUs=3D2, Nodes=3D1
[    0.000999] hpet clockevent registered
[    0.000999] Calibrating delay loop (skipped), value calculated using=
 timer frequency.. 3666.87 BogoMIPS (lpj=3D1833439)
[    0.000999] Security Framework initialized
[    0.000999] SELinux:  Disabled at boot.
[    0.000999] Dentry cache hash table entries: 524288 (order: 10, 4194=
304 bytes)
[    0.003539] Inode-cache hash table entries: 262144 (order: 9, 209715=
2 bytes)
[    0.005090] Mount-cache hash table entries: 256
[    0.005298] Initializing cgroup subsys ns
[    0.005303] Initializing cgroup subsys cpuacct
[    0.005305] Initializing cgroup subsys devices
[    0.005329] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.005332] CPU: L2 cache: 2048K
[    0.005335] CPU 0/0 -> Node 0
[    0.005337] CPU: Physical Processor ID: 0
[    0.005338] CPU: Processor Core ID: 0
[    0.005345] CPU0: Thermal monitoring handled by SMI
[    0.005347] using mwait in idle threads.
[    0.006406] ACPI: Core revision 20080609
[    0.019436] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin=
2=3D-1
[    0.029966] CPU0: Intel(R) Core(TM)2 Duo CPU     T5550  @ 1.83GHz st=
epping 0d
[    0.029969] Using local APIC timer interrupts.
[    0.029997] APIC timer calibration result 10417268
[    0.029998] Detected 10.417 MHz APIC timer.
[    0.030111] Booting processor 1/1 ip 6000
[    0.000999] Initializing CPU#1
[    0.000999] Calibrating delay using timer specific routine.. 3783.58=
 BogoMIPS (lpj=3D1891791)
[    0.000999] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.000999] CPU: L2 cache: 2048K
[    0.000999] CPU 1/1 -> Node 0
[    0.000999] CPU: Physical Processor ID: 0
[    0.000999] CPU: Processor Core ID: 1
[    0.000999] CPU1: Thermal monitoring handled by SMI
[    0.000999] x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x70106=
00070106
[    0.102324] CPU1: Intel(R) Core(TM)2 Duo CPU     T5550  @ 1.83GHz st=
epping 0d
[    0.102353] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.103001] Brought up 2 CPUs
[    0.103003] Total of 2 processors activated (7450.46 BogoMIPS).
[    0.103085] net_namespace: 856 bytes
[    0.103085] Booting paravirtualized kernel on bare hardware
[    0.103183] NET: Registered protocol family 16
[    0.104035] No dock devices found.
[    0.104045] ACPI: bus type pci registered
[    0.104045] PCI: MCFG configuration 0: base e0000000 segment 0 buses=
 0 - 255
[    0.104045] PCI: MCFG area at e0000000 reserved in E820
[    0.111720] PCI: Using MMCONFIG at e0000000 - efffffff
[    0.111722] PCI: Using configuration type 1 for base access
[    0.113431] ACPI: EC: Look up EC in DSDT
[    0.117682] ACPI: BIOS _OSI(Linux) query ignored via DMI
[    0.118648] ACPI: Interpreter enabled
[    0.118650] ACPI: (supports S0 S3 S4 S5)
[    0.118996] ACPI: Using IOAPIC for interrupt routing
[    0.119089] ACPI: EC: non-query interrupt received, switching to int=
errupt mode
[    0.620930] ACPI: EC: missing confirmations, switch off interrupt mo=
de.
[    0.694038] ACPI: EC: GPE =3D 0x18, I/O: command/status =3D 0x66, da=
ta =3D 0x62
[    0.694041] ACPI: EC: driver started in poll mode
[    0.694060] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.694060] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.694060] pci 0000:00:01.0: PME# disabled
[    0.694095] PCI: 0000:00:1a.0 reg 20 io port: [1800, 181f]
[    0.694161] PCI: 0000:00:1a.1 reg 20 io port: [1820, 183f]
[    0.694234] PCI: 0000:00:1a.7 reg 10 32bit mmio: [f3504800, f3504bff=
]
[    0.694292] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.694298] pci 0000:00:1a.7: PME# disabled
[    0.694970] PCI: 0000:00:1b.0 reg 10 64bit mmio: [f3500000, f3503fff=
]
[    0.695025] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.695030] pci 0000:00:1b.0: PME# disabled
[    0.695103] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.695108] pci 0000:00:1c.0: PME# disabled
[    0.695183] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.695188] pci 0000:00:1c.3: PME# disabled
[    0.695263] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.695268] pci 0000:00:1c.5: PME# disabled
[    0.695317] PCI: 0000:00:1d.0 reg 20 io port: [1840, 185f]
[    0.695385] PCI: 0000:00:1d.1 reg 20 io port: [1860, 187f]
[    0.695450] PCI: 0000:00:1d.2 reg 20 io port: [1880, 189f]
[    0.695522] PCI: 0000:00:1d.7 reg 10 32bit mmio: [f3504c00, f3504fff=
]
[    0.695580] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.695586] pci 0000:00:1d.7: PME# disabled
[    0.695751] pci 0000:00:1f.0: quirk: region 1000-107f claimed by ICH=
6 ACPI/GPIO/TCO
[    0.695755] pci 0000:00:1f.0: quirk: region 1180-11bf claimed by ICH=
6 GPIO
[    0.695785] PCI: 0000:00:1f.1 reg 10 io port: [0, 7]
[    0.695793] PCI: 0000:00:1f.1 reg 14 io port: [0, 3]
[    0.695801] PCI: 0000:00:1f.1 reg 18 io port: [0, 7]
[    0.695809] PCI: 0000:00:1f.1 reg 1c io port: [0, 3]
[    0.695817] PCI: 0000:00:1f.1 reg 20 io port: [18a0, 18af]
[    0.695892] PCI: 0000:00:1f.2 reg 10 io port: [18d8, 18df]
[    0.695900] PCI: 0000:00:1f.2 reg 14 io port: [18cc, 18cf]
[    0.695908] PCI: 0000:00:1f.2 reg 18 io port: [18d0, 18d7]
[    0.695916] PCI: 0000:00:1f.2 reg 1c io port: [18c8, 18cb]
[    0.695928] PCI: 0000:00:1f.2 reg 20 io port: [18e0, 18ff]
[    0.695936] PCI: 0000:00:1f.2 reg 24 32bit mmio: [f3504000, f35047ff=
]
[    0.695969] pci 0000:00:1f.2: PME# supported from D3hot
[    0.695974] pci 0000:00:1f.2: PME# disabled
[    0.695995] PCI: 0000:00:1f.3 reg 10 32bit mmio: [0, ff]
[    0.696022] PCI: 0000:00:1f.3 reg 20 io port: [1c00, 1c1f]
[    0.696099] PCI: 0000:01:00.0 reg 10 32bit mmio: [f2000000, f2ffffff=
]
[    0.696108] PCI: 0000:01:00.0 reg 14 32bit mmio: [d0000000, dfffffff=
]
[    0.696131] PCI: 0000:01:00.0 reg 1c 64bit mmio: [f0000000, f1ffffff=
]
[    0.696140] PCI: 0000:01:00.0 reg 24 io port: [2000, 207f]
[    0.696149] PCI: 0000:01:00.0 reg 30 32bit mmio: [0, 1ffff]
[    0.696228] PCI: bridge 0000:00:01.0 io port: [2000, 2fff]
[    0.696231] PCI: bridge 0000:00:01.0 32bit mmio: [f0000000, f2ffffff=
]
[    0.696235] PCI: bridge 0000:00:01.0 64bit mmio pref: [d0000000, dff=
fffff]
[    0.696298] PCI: bridge 0000:00:1c.0 io port: [0, fff]
[    0.696302] PCI: bridge 0000:00:1c.0 32bit mmio: [0, fffff]
[    0.696310] PCI: bridge 0000:00:1c.0 64bit mmio pref: [0, fffff]
[    0.696498] PCI: 0000:06:00.0 reg 10 32bit mmio: [0, fff]
[    0.696708] pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
[    0.696721] pci 0000:06:00.0: PME# disabled
[    0.696775] PCI: bridge 0000:00:1c.3 io port: [0, fff]
[    0.696780] PCI: bridge 0000:00:1c.3 32bit mmio: [0, fffff]
[    0.696788] PCI: bridge 0000:00:1c.3 64bit mmio pref: [0, fffff]
[    0.697014] PCI: 0000:08:00.0 reg 10 64bit mmio: [0, ffff]
[    0.697169] pci 0000:08:00.0: PME# supported from D3hot D3cold
[    0.697181] pci 0000:08:00.0: PME# disabled
[    0.697235] PCI: bridge 0000:00:1c.5 io port: [0, fff]
[    0.697239] PCI: bridge 0000:00:1c.5 32bit mmio: [0, fffff]
[    0.697247] PCI: bridge 0000:00:1c.5 64bit mmio pref: [0, fffff]
[    0.697310] PCI: 0000:0a:09.0 reg 10 32bit mmio: [f3200000, f32007ff=
]
[    0.697369] pci 0000:0a:09.0: supports D1
[    0.697370] pci 0000:0a:09.0: supports D2
[    0.697372] pci 0000:0a:09.0: PME# supported from D0 D1 D2 D3hot D3c=
old
[    0.697377] pci 0000:0a:09.0: PME# disabled
[    0.697415] PCI: 0000:0a:09.1 reg 10 32bit mmio: [f3200800, f32008ff=
]
[    0.697473] pci 0000:0a:09.1: supports D1
[    0.697475] pci 0000:0a:09.1: supports D2
[    0.697477] pci 0000:0a:09.1: PME# supported from D0 D1 D2 D3hot D3c=
old
[    0.697481] pci 0000:0a:09.1: PME# disabled
[    0.697520] PCI: 0000:0a:09.2 reg 10 32bit mmio: [f3200c00, f3200cff=
]
[    0.697578] pci 0000:0a:09.2: supports D1
[    0.697579] pci 0000:0a:09.2: supports D2
[    0.697581] pci 0000:0a:09.2: PME# supported from D0 D1 D2 D3hot D3c=
old
[    0.697586] pci 0000:0a:09.2: PME# disabled
[    0.697626] PCI: 0000:0a:09.3 reg 10 32bit mmio: [f3201000, f32010ff=
]
[    0.697684] pci 0000:0a:09.3: supports D1
[    0.697686] pci 0000:0a:09.3: supports D2
[    0.697687] pci 0000:0a:09.3: PME# supported from D0 D1 D2 D3hot D3c=
old
[    0.697692] pci 0000:0a:09.3: PME# disabled
[    0.697731] PCI: 0000:0a:09.4 reg 10 32bit mmio: [f3201400, f32014ff=
]
[    0.697788] pci 0000:0a:09.4: supports D1
[    0.697789] pci 0000:0a:09.4: supports D2
[    0.697791] pci 0000:0a:09.4: PME# supported from D0 D1 D2 D3hot D3c=
old
[    0.697796] pci 0000:0a:09.4: PME# disabled
[    0.697845] pci 0000:00:1e.0: transparent bridge
[    0.697853] PCI: bridge 0000:00:1e.0 32bit mmio: [f3200000, f32fffff=
]
[    0.697895] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.698348] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
[    0.698508] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    0.698661] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
[    0.698808] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP06._PRT]
[    0.698981] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
[    0.713029] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 *5 6 7 10 12=
 14 15)
[    0.713158] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 =
14 15) *10
[    0.713288] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 12=
 14 15)
[    0.713414] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 =
14 15) *10
[    0.714037] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 =
14 15) *0, disabled.
[    0.714163] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 *11 12=
 14 15)
[    0.714288] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 =
14 15) *11
[    0.714413] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 *7 11 12=
 14 15)
[    0.714485] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.714485] pnp: PnP ACPI init
[    0.714485] ACPI: bus type pnp registered
[    0.714485] pnp 00:00: parse allocated resources
[    0.715375] pnp 00:00:   add io  0xcf8-0xcff flags 0x1
[    0.715416] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a0=
3 (active)
[    0.715416] pnp 00:01: parse allocated resources
[    0.715416] pnp 00:01:   add mem 0xfed1c000-0xfed1ffff flags 0x1
[    0.715416] pnp 00:01:   add mem 0xfed14000-0xfed17fff flags 0x1
[    0.715416] pnp 00:01:   add mem 0xfed18000-0xfed18fff flags 0x1
[    0.715416] pnp 00:01:   add mem 0xfed19000-0xfed19fff flags 0x1
[    0.715416] pnp 00:01:   add mem 0xe0000000-0xefffffff flags 0x1
[    0.715416] pnp 00:01:   add mem 0xfed20000-0xfed3ffff flags 0x1
[    0.715416] pnp 00:01:   add mem 0xfed40000-0xfed44fff flags 0x1
[    0.715416] pnp 00:01:   add mem 0xfed45000-0xfed8ffff flags 0x1
[    0.715416] pnp 00:01: PNP0c02: calling quirk_system_pci_resources+0=
x0/0x200
[    0.715416] pnp 00:01: Plug and Play ACPI device, IDs PNP0c02 (activ=
e)
[    0.716263] pnp 00:02: parse allocated resources
[    0.716268] pnp 00:02:   add io  0x0-0x1f flags 0x1
[    0.716270] pnp 00:02:   add io  0x81-0x91 flags 0x1
[    0.716272] pnp 00:02:   add io  0x93-0x9f flags 0x1
[    0.716274] pnp 00:02:   add io  0xc0-0xdf flags 0x1
[    0.716276] pnp 00:02:   add dma 4 flags 0x1
[    0.716305] pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (activ=
e)
[    0.716305] pnp 00:03: parse allocated resources
[    0.716305] pnp 00:03:   add mem 0xff000000-0xffffffff flags 0x0
[    0.716305] pnp 00:03: Plug and Play ACPI device, IDs INT0800 (activ=
e)
[    0.716305] pnp 00:04: parse allocated resources
[    0.716305] pnp 00:04:   add mem 0xfed00000-0xfed003ff flags 0x0
[    0.716305] pnp 00:04: PNP0c01: calling quirk_system_pci_resources+0=
x0/0x200
[    0.716305] pnp 00:04: Plug and Play ACPI device, IDs PNP0103 PNP0c0=
1 (active)
[    0.716305] pnp 00:05: parse allocated resources
[    0.716305] pnp 00:05:   add io  0xf0-0xf0 flags 0x1
[    0.716305] pnp 00:05:   add irq 13 flags 0x1
[    0.716305] pnp 00:05: Plug and Play ACPI device, IDs PNP0c04 (activ=
e)
[    0.716305] pnp 00:06: parse allocated resources
[    0.716305] pnp 00:06:   add io  0x2e-0x2f flags 0x1
[    0.716305] pnp 00:06:   add io  0x4e-0x4f flags 0x1
[    0.716305] pnp 00:06:   add io  0x61-0x61 flags 0x1
[    0.716305] pnp 00:06:   add io  0x63-0x63 flags 0x1
[    0.716305] pnp 00:06:   add io  0x65-0x65 flags 0x1
[    0.716305] pnp 00:06:   add io  0x67-0x67 flags 0x1
[    0.716305] pnp 00:06:   add io  0x68-0x6f flags 0x1
[    0.716305] pnp 00:06:   add io  0x80-0x80 flags 0x1
[    0.716305] pnp 00:06:   add io  0x92-0x92 flags 0x1
[    0.716305] pnp 00:06:   add io  0xb2-0xb3 flags 0x1
[    0.716305] pnp 00:06:   add io  0x680-0x69f flags 0x1
[    0.716305] pnp 00:06:   add io  0x800-0x80f flags 0x1
[    0.716305] pnp 00:06:   add io  0x1000-0x107f flags 0x1
[    0.716305] pnp 00:06:   add io  0x1180-0x11bf flags 0x1
[    0.716305] pnp 00:06:   add io  0x1640-0x164f flags 0x1
[    0.716305] pnp 00:06:   add io  0xfe00-0xfe00 flags 0x1
[    0.716305] pnp 00:06: PNP0c02: calling quirk_system_pci_resources+0=
x0/0x200
[    0.716305] pnp 00:06: io resource (0x2e-0x2f) overlaps 0000:00:1c.0=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x4e-0x4f) overlaps 0000:00:1c.0=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x61-0x61) overlaps 0000:00:1c.0=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x63-0x63) overlaps 0000:00:1c.0=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x65-0x65) overlaps 0000:00:1c.0=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x67-0x67) overlaps 0000:00:1c.0=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x68-0x6f) overlaps 0000:00:1c.0=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x80-0x80) overlaps 0000:00:1c.0=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x92-0x92) overlaps 0000:00:1c.0=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0xb2-0xb3) overlaps 0000:00:1c.0=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x680-0x69f) overlaps 0000:00:1c=
=2E0 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x800-0x80f) overlaps 0000:00:1c=
=2E0 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x2e-0x2f) overlaps 0000:00:1c.3=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x4e-0x4f) overlaps 0000:00:1c.3=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x61-0x61) overlaps 0000:00:1c.3=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x63-0x63) overlaps 0000:00:1c.3=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x65-0x65) overlaps 0000:00:1c.3=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x67-0x67) overlaps 0000:00:1c.3=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x68-0x6f) overlaps 0000:00:1c.3=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x80-0x80) overlaps 0000:00:1c.3=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x92-0x92) overlaps 0000:00:1c.3=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0xb2-0xb3) overlaps 0000:00:1c.3=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x680-0x69f) overlaps 0000:00:1c=
=2E3 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x800-0x80f) overlaps 0000:00:1c=
=2E3 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x2e-0x2f) overlaps 0000:00:1c.5=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x4e-0x4f) overlaps 0000:00:1c.5=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x61-0x61) overlaps 0000:00:1c.5=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x63-0x63) overlaps 0000:00:1c.5=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x65-0x65) overlaps 0000:00:1c.5=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x67-0x67) overlaps 0000:00:1c.5=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x68-0x6f) overlaps 0000:00:1c.5=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x80-0x80) overlaps 0000:00:1c.5=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x92-0x92) overlaps 0000:00:1c.5=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0xb2-0xb3) overlaps 0000:00:1c.5=
 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x680-0x69f) overlaps 0000:00:1c=
=2E5 BAR 7 (0x0-0xfff), disabling
[    0.716305] pnp 00:06: io resource (0x800-0x80f) overlaps 0000:00:1c=
=2E5 BAR 7 (0x0-0xfff), disabling
[    0.716940] pnp 00:06: Plug and Play ACPI device, IDs PNP0c02 (activ=
e)
[    0.716946] pnp 00:07: parse allocated resources
[    0.716951] pnp 00:07:   add io  0x70-0x77 flags 0x1
[    0.716955] pnp 00:07:   add irq 8 flags 0x1
[    0.716987] pnp 00:07: Plug and Play ACPI device, IDs PNP0b00 (activ=
e)
[    0.717114] pnp 00:08: parse allocated resources
[    0.717291] pnp 00:08:   add io  0x600-0x607 flags 0x1
[    0.717293] pnp 00:08:   add io  0x620-0x63f flags 0x1
[    0.717298] pnp 00:08:   add irq 4 flags 0x1
[    0.717299] pnp 00:08: parse resource options
[    0.717368] pnp 00:08:   dependent set 0 (acceptable) io  min 0x600 =
max 0x600 align 1 size 8 flags 0x1
[    0.717371] pnp 00:08:   dependent set 0 (acceptable) io  min 0x620 =
max 0x620 align 1 size 32 flags 0x1
[    0.717376] pnp 00:08:   dependent set 0 (acceptable) irq 4 flags 0x=
1
[    0.717410] pnp 00:08: Plug and Play ACPI device, IDs WEC1020 (activ=
e)
[    0.717410] pnp 00:09: parse allocated resources
[    0.717410] pnp 00:09:   add io  0x60-0x60 flags 0x1
[    0.717410] pnp 00:09:   add io  0x64-0x64 flags 0x1
[    0.717410] pnp 00:09:   add irq 1 flags 0x1
[    0.717410] pnp 00:09: Plug and Play ACPI device, IDs PNP0303 (activ=
e)
[    0.717410] pnp 00:0a: parse allocated resources
[    0.717410] pnp 00:0a:   add irq 12 flags 0x1
[    0.717410] pnp 00:0a: Plug and Play ACPI device, IDs SYN1b03 SYN1b0=
0 SYN0002 PNP0f13 (active)
[    0.717410] pnp: PnP ACPI: found 11 devices
[    0.717410] ACPI: ACPI bus type pnp unregistered
[    0.717927] SCSI subsystem initialized
[    0.717944] libata version 3.00 loaded.
[    0.717944] usbcore: registered new interface driver usbfs
[    0.717944] usbcore: registered new interface driver hub
[    0.717944] usbcore: registered new device driver usb
[    0.717944] PCI: Using ACPI for IRQ routing
[    0.717944] pci 0000:00:1c.0: BAR 7: can't allocate resource
[    0.717944] pci 0000:00:1c.0: BAR 8: can't allocate resource
[    0.717944] pci 0000:00:1c.0: BAR 9: can't allocate resource
[    0.717944] pci 0000:00:1c.3: BAR 7: can't allocate resource
[    0.717946] pci 0000:00:1c.3: BAR 8: can't allocate resource
[    0.717949] pci 0000:00:1c.3: BAR 9: can't allocate resource
[    0.717952] pci 0000:00:1c.5: BAR 7: can't allocate resource
[    0.717955] pci 0000:00:1c.5: BAR 8: can't allocate resource
[    0.717958] pci 0000:00:1c.5: BAR 9: can't allocate resource
[    0.722957] PCI-GART: No AMD northbridge found.
[    0.722963] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.722968] hpet0: 3 64-bit timers, 14318180 Hz
[    0.723963] ACPI: RTC can wake from S4
[    0.724933] Switched to high resolution mode on CPU 0
[    0.725309] Switched to high resolution mode on CPU 1
[    0.727009] pnp: the driver 'system' has been registered
[    0.727018] system 00:01: iomem range 0xfed1c000-0xfed1ffff could no=
t be reserved
[    0.727021] system 00:01: iomem range 0xfed14000-0xfed17fff could no=
t be reserved
[    0.727024] system 00:01: iomem range 0xfed18000-0xfed18fff could no=
t be reserved
[    0.727026] system 00:01: iomem range 0xfed19000-0xfed19fff could no=
t be reserved
[    0.727029] system 00:01: iomem range 0xe0000000-0xefffffff could no=
t be reserved
[    0.727031] system 00:01: iomem range 0xfed20000-0xfed3ffff could no=
t be reserved
[    0.727034] system 00:01: iomem range 0xfed40000-0xfed44fff could no=
t be reserved
[    0.727037] system 00:01: iomem range 0xfed45000-0xfed8ffff could no=
t be reserved
[    0.727038] system 00:01: driver attached
[    0.727045] system 00:04: iomem range 0xfed00000-0xfed003ff could no=
t be reserved
[    0.727047] system 00:04: driver attached
[    0.727053] system 00:06: ioport range 0x1000-0x107f has been reserv=
ed
[    0.727056] system 00:06: ioport range 0x1180-0x11bf has been reserv=
ed
[    0.727058] system 00:06: ioport range 0x1640-0x164f has been reserv=
ed
[    0.727061] system 00:06: ioport range 0xfe00-0xfe00 has been reserv=
ed
[    0.727063] system 00:06: driver attached
[    0.732096] pci 0000:01:00.0: BAR 6: can't allocate mem resource [0x=
e0000000-0xdfffffff]
[    0.732102] pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
[    0.732104] pci 0000:00:01.0:   IO window: 0x2000-0x2fff
[    0.732108] pci 0000:00:01.0:   MEM window: 0xf0000000-0xf2ffffff
[    0.732112] pci 0000:00:01.0:   PREFETCH window: 0x000000d0000000-0x=
000000dfffffff
[    0.732116] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:02
[    0.732118] pci 0000:00:1c.0:   IO window: disabled
[    0.732124] pci 0000:00:1c.0:   MEM window: disabled
[    0.732129] pci 0000:00:1c.0:   PREFETCH window: disabled
[    0.732189] pci 0000:00:1c.3: PCI bridge, secondary bus 0000:06
[    0.732190] pci 0000:00:1c.3:   IO window: disabled
[    0.732197] pci 0000:00:1c.3:   MEM window: 0xc2000000-0xc20fffff
[    0.732202] pci 0000:00:1c.3:   PREFETCH window: disabled
[    0.732264] pci 0000:00:1c.5: PCI bridge, secondary bus 0000:08
[    0.732266] pci 0000:00:1c.5:   IO window: disabled
[    0.732272] pci 0000:00:1c.5:   MEM window: 0xc2100000-0xc21fffff
[    0.732277] pci 0000:00:1c.5:   PREFETCH window: disabled
[    0.732285] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:0a
[    0.732287] pci 0000:00:1e.0:   IO window: disabled
[    0.732293] pci 0000:00:1e.0:   MEM window: 0xf3200000-0xf32fffff
[    0.732298] pci 0000:00:1e.0:   PREFETCH window: disabled
[    0.732314] pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IR=
Q 16
[    0.732318] pci 0000:00:01.0: setting latency timer to 64
[    0.732328] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IR=
Q 17
[    0.732334] pci 0000:00:1c.0: setting latency timer to 64
[    0.732343] pci 0000:00:1c.3: enabling device (0000 -> 0002)
[    0.732347] pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IR=
Q 19
[    0.732354] pci 0000:00:1c.3: setting latency timer to 64
[    0.732362] pci 0000:00:1c.5: enabling device (0000 -> 0002)
[    0.732366] pci 0000:00:1c.5: PCI INT B -> GSI 16 (level, low) -> IR=
Q 16
[    0.732372] pci 0000:00:1c.5: setting latency timer to 64
[    0.732380] pci 0000:00:1e.0: setting latency timer to 64
[    0.732384] bus: 00 index 0 io port: [0, ffff]
[    0.732386] bus: 00 index 1 mmio: [0, ffffffffffffffff]
[    0.732388] bus: 01 index 0 io port: [2000, 2fff]
[    0.732390] bus: 01 index 1 mmio: [f0000000, f2ffffff]
[    0.732392] bus: 01 index 2 mmio: [d0000000, dfffffff]
[    0.732393] bus: 01 index 3 mmio: [0, 0]
[    0.732395] bus: 02 index 0 mmio: [0, fff]
[    0.732397] bus: 02 index 1 mmio: [0, fffff]
[    0.732398] bus: 02 index 2 mmio: [0, fffff]
[    0.732400] bus: 02 index 3 mmio: [0, 0]
[    0.732402] bus: 06 index 0 mmio: [0, fff]
[    0.732403] bus: 06 index 1 mmio: [c2000000, c20fffff]
[    0.732405] bus: 06 index 2 mmio: [0, fffff]
[    0.732407] bus: 06 index 3 mmio: [0, 0]
[    0.732408] bus: 08 index 0 mmio: [0, fff]
[    0.732410] bus: 08 index 1 mmio: [c2100000, c21fffff]
[    0.732412] bus: 08 index 2 mmio: [0, fffff]
[    0.732413] bus: 08 index 3 mmio: [0, 0]
[    0.732415] bus: 0a index 0 mmio: [0, 0]
[    0.732417] bus: 0a index 1 mmio: [f3200000, f32fffff]
[    0.732419] bus: 0a index 2 mmio: [0, 0]
[    0.732420] bus: 0a index 3 io port: [0, ffff]
[    0.732422] bus: 0a index 4 mmio: [0, ffffffffffffffff]
[    0.732433] NET: Registered protocol family 2
[    0.742153] IP route cache hash table entries: 131072 (order: 8, 104=
8576 bytes)
[    0.743561] TCP established hash table entries: 524288 (order: 11, 8=
388608 bytes)
[    0.749628] TCP bind hash table entries: 65536 (order: 8, 1048576 by=
tes)
[    0.750406] TCP: Hash tables configured (established 524288 bind 655=
36)
[    0.750409] TCP reno registered
[    0.753117] NET: Registered protocol family 1
[    0.753233] Unpacking initramfs... done
[    0.977730] Freeing initrd memory: 5293k freed
[    0.980542] Simple Boot Flag at 0x35 set to 0x1
[    0.981420] audit: initializing netlink socket (disabled)
[    0.981443] type=3D2000 audit(1224719765.981:1): initialized
[    0.981757] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.984365] msgmni has been set to 6043
[    0.984472] io scheduler noop registered
[    0.984474] io scheduler anticipatory registered
[    0.984476] io scheduler deadline registered
[    0.984582] io scheduler cfq registered (default)
[    0.984752] pci 0000:01:00.0: Boot video device
[    0.984869] pcieport-driver 0000:00:01.0: setting latency timer to 6=
4
[    0.984904] pcieport-driver 0000:00:01.0: found MSI capability
[    0.984937] pci_express 0000:00:01.0:pcie00: allocate port service
[    0.984975] pci_express 0000:00:01.0:pcie02: allocate port service
[    0.985013] pci_express 0000:00:01.0:pcie03: allocate port service
[    0.985098] pcieport-driver 0000:00:1c.0: setting latency timer to 6=
4
[    0.985147] pcieport-driver 0000:00:1c.0: found MSI capability
[    0.985196] pci_express 0000:00:1c.0:pcie00: allocate port service
[    0.985230] pci_express 0000:00:1c.0:pcie02: allocate port service
[    0.985265] pci_express 0000:00:1c.0:pcie03: allocate port service
[    0.985380] pcieport-driver 0000:00:1c.3: setting latency timer to 6=
4
[    0.985429] pcieport-driver 0000:00:1c.3: found MSI capability
[    0.985479] pci_express 0000:00:1c.3:pcie00: allocate port service
[    0.985514] pci_express 0000:00:1c.3:pcie02: allocate port service
[    0.985550] pci_express 0000:00:1c.3:pcie03: allocate port service
[    0.985657] pcieport-driver 0000:00:1c.5: setting latency timer to 6=
4
[    0.985706] pcieport-driver 0000:00:1c.5: found MSI capability
[    0.985755] pci_express 0000:00:1c.5:pcie00: allocate port service
[    0.985789] pci_express 0000:00:1c.5:pcie02: allocate port service
[    0.985823] pci_express 0000:00:1c.5:pcie03: allocate port service
[    0.986477] vesafb: framebuffer at 0xf1000000, mapped to 0xffffc2001=
1100000, using 8000k, total 14336k
[    0.986480] vesafb: mode is 1280x800x32, linelength=3D5120, pages=3D=
1
[    0.986482] vesafb: scrolling: redraw
[    0.986484] vesafb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    1.060746] Console: switching to colour frame buffer device 160x50
[    1.128391] fb0: VESA VGA frame buffer device
[    1.131008] hpet_resources: 0xfed00000 is busy
[    1.131067] Linux agpgart interface v0.103
[    1.131069] Serial: 8250/16550 driver4 ports, IRQ sharing enabled
[    1.131355] pnp: the driver 'serial' has been registered
[    1.131607] ahci 0000:00:1f.2: version 3.0
[    1.131622] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> I=
RQ 19
[    1.131732] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 3 ports 3 Gbp=
s 0x7 impl SATA mode
[    1.131735] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio =
slum part=20
[    1.131741] ahci 0000:00:1f.2: setting latency timer to 64
[    1.131959] scsi0 : ahci
[    1.132118] scsi1 : ahci
[    1.132187] scsi2 : ahci
[    1.132300] ata1: SATA max UDMA/133 abar m2048@0xf3504000 port 0xf35=
04100 irq 315
[    1.132304] ata2: SATA max UDMA/133 abar m2048@0xf3504000 port 0xf35=
04180 irq 315
[    1.132307] ata3: SATA max UDMA/133 abar m2048@0xf3504000 port 0xf35=
04200 irq 315
[    1.437021] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.437592] ata1.00: _GTF unexpected object type 0x1
[    1.491048] ata1.00: ATA-8: WDC WD2500BEVS-22UST0, 01.01A01, max UDM=
A/133
[    1.491050] ata1.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 3=
1/32)
[    1.491888] ata1.00: _GTF unexpected object type 0x1
[    1.492018] ata1.00: configured for UDMA/133
[    1.808017] ata2: SATA link down (SStatus 0 SControl 300)
[    2.124016] ata3: SATA link down (SStatus 0 SControl 300)
[    2.135105] scsi 0:0:0:0: Direct-Access     ATA      WDC WD2500BEVS-=
2 01.0 PQ: 0 ANSI: 5
[    2.135244] usbmon: debugfs is not available
[    2.135247] pnp: the driver 'i8042 kbd' has been registered
[    2.135268] i8042 kbd 00:09: driver attached
[    2.135296] pnp: the driver 'i8042 aux' has been registered
[    2.135316] i8042 aux 00:0a: driver attached
[    2.135348] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60=
,0x64 irq 1,12
[    2.137350] i8042.c: Detected active multiplexing controller, rev 1.=
1.
[    2.138404] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.138409] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    2.138412] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    2.138414] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    2.138416] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    2.138545] mice: PS/2 mouse device common for all mice
[    2.138619] pnp: the driver 'rtc_cmos' has been registered
[    2.139524] rtc_cmos 00:07: rtc core: registered rtc_cmos as rtc0
[    2.139558] rtc0: alarms up to one month, y3k, hpet irqs
[    2.139560] rtc_cmos 00:07: driver attached
[    2.139591] cpuidle: using governor ladder
[    2.139593] cpuidle: using governor menu
[    2.139868] TCP cubic registered
[    2.139871] NET: Registered protocol family 17
[    2.139993] registered taskstats version 1
[    2.140150] rtc_cmos 00:07: setting system clock to 2008-10-22 23:56=
:07 UTC (1224719767)
[    2.140201] Freeing unused kernel memory: 428k freed
[    2.219714] input: AT Translated Set 2 keyboard as /class/input/inpu=
t0
[    2.225461] ACPI: SSDT BFED481A, 01F6 (r1  PmRef  Cpu0Ist     3000 I=
NTL 20050624)
[    2.225973] ACPI: SSDT BFED419E, 05F7 (r1  PmRef  Cpu0Cst     3001 I=
NTL 20050624)
[    2.228533] Monitor-Mwait will be used to enter C-1 state
[    2.228536] Monitor-Mwait will be used to enter C-2 state
[    2.228538] Monitor-Mwait will be used to enter C-3 state
[    2.228710] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[    2.228758] processor ACPI0007:00: registered as cooling_device0
[    2.228764] ACPI: Processor [CPU0] (supports 8 throttling states)
[    2.229146] ACPI: SSDT BFED4A10, 00C8 (r1  PmRef  Cpu1Ist     3000 I=
NTL 20050624)
[    2.229521] ACPI: SSDT BFED4795, 0085 (r1  PmRef  Cpu1Cst     3000 I=
NTL 20050624)
[    2.230741] ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
[    2.230780] processor ACPI0007:01: registered as cooling_device1
[    2.230784] ACPI: Processor [CPU1] (supports 8 throttling states)
[    2.230893] Marking TSC unstable due to TSC halts in idle
[    2.338602] thermal LNXTHERM:01: registered as thermal_zone0
[    2.354694] ACPI: Thermal Zone [THRM] (53 C)
[    2.423463] Driver 'sd' needs updating - please use bus_type methods
[    2.423573] sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (2=
50059 MB)
[    2.423597] sd 0:0:0:0: [sda] Write Protect is off
[    2.423599] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.423639] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enab=
led, doesn't support DPO or FUA
[    2.423718] sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (2=
50059 MB)
[    2.423740] sd 0:0:0:0: [sda] Write Protect is off
[    2.423742] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.423782] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enab=
led, doesn't support DPO or FUA
[    2.423785]  sda: sda1 sda2 sda3 sda4 < sda5 sda6<4>Clocksource tsc =
unstable (delta =3D -97102636 ns)
[    2.522464]  sda7 >
[    2.522660] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.565748] USB Universal Host Controller Interface driver v3.0
[    2.565797] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) =
-> IRQ 16
[    2.565807] uhci_hcd 0000:00:1a.0: setting latency timer to 64
[    2.565811] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    2.565853] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned =
bus number 1
[    2.565894] uhci_hcd 0000:00:1a.0: irq 16, io base 0x00001800
[    2.565991] usb usb1: configuration #1 chosen from 1 choice
[    2.566020] hub 1-0:1.0: USB hub found
[    2.566027] hub 1-0:1.0: 2 ports detected
[    2.624761] Uniform Multi-Platform E-IDE driver
[    2.636761] ricoh-mmc: Ricoh MMC Controller disabling driver
[    2.636764] ricoh-mmc: Copyright(c) Philip Langdale
[    2.638072] sdhci: Secure Digital Host Controller Interface driver
[    2.638074] sdhci: Copyright(c) Pierre Ossman
[    2.768278] usb usb1: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0001
[    2.768281] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    2.768284] usb usb1: Product: UHCI Host Controller
[    2.768286] usb usb1: Manufacturer: Linux 2.6.27.1bp uhci_hcd
[    2.768288] usb usb1: SerialNumber: 0000:00:1a.0
[    2.768500] ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) =
-> IRQ 18
[    2.768520] ehci_hcd 0000:00:1a.7: setting latency timer to 64
[    2.768524] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[    2.768552] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned =
bus number 2
[    2.772454] ehci_hcd 0000:00:1a.7: debug port 1
[    2.772461] ehci_hcd 0000:00:1a.7: cache line size of 32 is not supp=
orted
[    2.772480] ehci_hcd 0000:00:1a.7: irq 18, io mem 0xf3504800
[    2.871073] usb 1-2: new full speed USB device using uhci_hcd and ad=
dress 2
[    2.877077] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, drive=
r 10 Dec 2004
[    2.877219] usb usb2: configuration #1 chosen from 1 choice
[    2.877251] hub 2-0:1.0: USB hub found
[    2.877268] hub 2-0:1.0: 4 ports detected
[    2.932103] hub 1-0:1.0: unable to enumerate USB device on port 2
[    3.079482] usb usb2: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002
[    3.079485] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    3.079487] usb usb2: Product: EHCI Host Controller
[    3.079489] usb usb2: Manufacturer: Linux 2.6.27.1bp ehci_hcd
[    3.079491] usb usb2: SerialNumber: 0000:00:1a.7
[    3.079559] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) =
-> IRQ 21
[    3.079568] uhci_hcd 0000:00:1a.1: setting latency timer to 64
[    3.079571] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    3.079595] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned =
bus number 3
[    3.079632] uhci_hcd 0000:00:1a.1: irq 21, io base 0x00001820
[    3.079711] usb usb3: configuration #1 chosen from 1 choice
[    3.079741] hub 3-0:1.0: USB hub found
[    3.079747] hub 3-0:1.0: 2 ports detected
[    3.180396] usb usb3: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0001
[    3.180401] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    3.180405] usb usb3: Product: UHCI Host Controller
[    3.180408] usb usb3: Manufacturer: Linux 2.6.27.1bp uhci_hcd
[    3.180411] usb usb3: SerialNumber: 0000:00:1a.1
[    3.180761] piix 0000:00:1f.1: IDE controller (0x8086:0x2850 rev 0x0=
3)
[    3.180768] PIIX_IDE 0000:00:1f.1: PCI INT A -> GSI 19 (level, low) =
-> IRQ 19
[    3.180786] piix 0000:00:1f.1: not 100% native mode: will probe irqs=
 later
[    3.180793]     ide0: BM-DMA at 0x18a0-0x18a7
[    3.180801]     ide1: BM-DMA at 0x18a8-0x18af
[    3.180806] Probing IDE interface ide0...
[    3.182036] usb 2-2: new high speed USB device using ehci_hcd and ad=
dress 2
[    3.305247] usb 2-2: configuration #1 chosen from 1 choice
[    3.305768] usb 2-2: New USB device found, idVendor=3D064e, idProduc=
t=3Da101
[    3.305773] usb 2-2: New USB device strings: Mfr=3D2, Product=3D1, S=
erialNumber=3D3
[    3.305777] usb 2-2: Product: Acer CrystalEye webcam
[    3.305780] usb 2-2: Manufacturer: SuYin
[    3.305783] usb 2-2: SerialNumber: CN0314-OV03-VA-R02.00.00
[    3.852484] hda: TSSTcorp CDDVDW TS-L632H, ATAPI CD/DVD-ROM drive
[    4.464288] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO=
4
[    4.469859] hda: UDMA/33 mode selected
[    4.491266] Probing IDE interface ide1...
[    5.010511] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    5.023554] ide1 at 0x170-0x177,0x376 on irq 15
[    5.023916] tg3.c:v3.94 (August 14, 2008)
[    5.023970] tg3 0000:08:00.0: enabling device (0000 -> 0002)
[    5.023979] tg3 0000:08:00.0: PCI INT A -> GSI 17 (level, low) -> IR=
Q 17
[    5.023997] tg3 0000:08:00.0: setting latency timer to 64
[    5.056899] eth0: Tigon3 [partno(BCM95787m) rev b002 PHY(5787)] (PCI=
 Express) 10/100/1000Base-T Ethernet 00:1e:68:3e:f9:7a
[    5.056903] eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] WireSpeed=
[1] TSOcap[1]
[    5.056905] eth0: dma_rwctrl[76180000] dma_mask[64-bit]
[    5.057326] ohci1394 0000:0a:09.0: PCI INT A -> GSI 16 (level, low) =
-> IRQ 16
[    5.071174] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) =
-> IRQ 23
[    5.071184] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    5.071188] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    5.071229] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned =
bus number 4
[    5.071282] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001840
[    5.071381] usb usb4: configuration #1 chosen from 1 choice
[    5.071412] hub 4-0:1.0: USB hub found
[    5.071419] hub 4-0:1.0: 2 ports detected
[    5.112162] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[16]  MMI=
O=3D[f3200000-f32007ff]  Max Packet=3D[2048]  IR/IT contexts=3D[4/4]
[    5.116462] sdhci-pci 0000:0a:09.1: SDHCI controller found [1180:082=
2] (rev 22)
[    5.116474] sdhci-pci 0000:0a:09.1: PCI INT B -> GSI 17 (level, low)=
 -> IRQ 17
[    5.117528] sdhci-pci 0000:0a:09.1: Will use DMA mode even though HW=
 doesn't fully claim to support it.
[    5.119646] mmc0: SDHCI controller on PCI [0000:0a:09.1] using DMA
[    5.119661] ricoh-mmc: Ricoh MMC controller found at 0000:0a:09.2 [1=
180:0843] (rev 12)
[    5.119681] ricoh-mmc: Controller is now disabled.
[    5.273433] usb usb4: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0001
[    5.273438] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    5.273442] usb usb4: Product: UHCI Host Controller
[    5.273446] usb usb4: Manufacturer: Linux 2.6.27.1bp uhci_hcd
[    5.273449] usb usb4: SerialNumber: 0000:00:1d.0
[    5.273512] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) =
-> IRQ 23
[    5.273530] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    5.273534] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    5.273565] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned =
bus number 5
[    5.277480] ehci_hcd 0000:00:1d.7: debug port 1
[    5.277487] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supp=
orted
[    5.277494] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xf3504c00
[    5.375242] usb 4-2: new low speed USB device using uhci_hcd and add=
ress 2
[    5.381229] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, drive=
r 10 Dec 2004
[    5.381348] usb usb5: configuration #1 chosen from 1 choice
[    5.381398] hub 5-0:1.0: USB hub found
[    5.381409] hub 5-0:1.0: 6 ports detected
[    5.437263] hub 4-0:1.0: unable to enumerate USB device on port 2
[    5.583373] usb usb5: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002
[    5.583377] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    5.583382] usb usb5: Product: EHCI Host Controller
[    5.583385] usb usb5: Manufacturer: Linux 2.6.27.1bp ehci_hcd
[    5.583388] usb usb5: SerialNumber: 0000:00:1d.7
[    5.583459] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) =
-> IRQ 19
[    5.583467] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    5.583471] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    5.583493] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned =
bus number 6
[    5.583532] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00001860
[    5.583607] usb usb6: configuration #1 chosen from 1 choice
[    5.583633] hub 6-0:1.0: USB hub found
[    5.583639] hub 6-0:1.0: 2 ports detected
[    5.785375] usb usb6: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0001
[    5.785379] usb usb6: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    5.785383] usb usb6: Product: UHCI Host Controller
[    5.785386] usb usb6: Manufacturer: Linux 2.6.27.1bp uhci_hcd
[    5.785390] usb usb6: SerialNumber: 0000:00:1d.1
[    5.785475] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) =
-> IRQ 18
[    5.785482] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    5.785485] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    5.785507] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned =
bus number 7
[    5.785534] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001880
[    5.785617] usb usb7: configuration #1 chosen from 1 choice
[    5.785641] hub 7-0:1.0: USB hub found
[    5.785648] hub 7-0:1.0: 2 ports detected
[    5.886397] usb usb7: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0001
[    5.886402] usb usb7: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    5.886406] usb usb7: Product: UHCI Host Controller
[    5.886409] usb usb7: Manufacturer: Linux 2.6.27.1bp uhci_hcd
[    5.886412] usb usb7: SerialNumber: 0000:00:1d.2
[    5.911028] usb 4-2: new low speed USB device using uhci_hcd and add=
ress 3
[    5.942367] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff880037977d98, rq->data_len: 0x18, on_stac=
k: 1
[    5.960861] hda: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB C=
ache
[    5.960869] Uniform CD-ROM driver Revision: 3.20
[    6.074872] usb 4-2: configuration #1 chosen from 1 choice
[    6.077466] usb 4-2: New USB device found, idVendor=3D046d, idProduc=
t=3Dc052
[    6.077468] usb 4-2: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
[    6.077470] usb 4-2: Product: USB Optical Mouse
[    6.077472] usb 4-2: Manufacturer: Logitech
[    6.179235] usb 6-1: new low speed USB device using uhci_hcd and add=
ress 2
[    6.345715] usb 6-1: configuration #1 chosen from 1 choice
[    6.374609] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00241b0056=
30d300]
[    6.374736] usb 6-1: New USB device found, idVendor=3D04fc, idProduc=
t=3D05d8
[    6.374738] usb 6-1: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
[    6.374741] usb 6-1: Product: Trust Deskset 15176
[    6.374742] usb 6-1: Manufacturer: MLK
[    6.374835] usbcore: registered new interface driver hiddev
[    6.388789] input: Logitech USB Optical Mouse as /class/input/input1
[    6.391297] input,hidraw0: USB HID v1.10 Mouse [Logitech USB Optical=
 Mouse] on usb-0000:00:1d.0-2
[    6.406069] input: MLK Trust Deskset 15176 as /class/input/input2
[    6.409277] input,hidraw1: USB HID v1.00 Keyboard [MLK Trust Deskset=
 15176] on usb-0000:00:1d.1-1
[    6.433612] Fixing up Sunplus Wireless Desktop report descriptor
[    6.434712] input: MLK Trust Deskset 15176 as /class/input/input3
[    6.440352] input,hiddev96,hidraw2: USB HID v1.00 Mouse [MLK Trust D=
eskset 15176] on usb-0000:00:1d.1-1
[    6.440385] usbcore: registered new interface driver usbhid
[    6.440390] usbhid: v2.6:USB HID core driver
[   14.131302] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff880037977c58, rq->data_len: 0x8, on_stack=
: 1
[   14.133247] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bd0b1010, rq->data_len: 0x4, on_stack=
: 0
[   14.139349] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff880037881a18, rq->data_len: 0x8, on_stack=
: 1
[   14.141283] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bd0b1010, rq->data_len: 0x4, on_stack=
: 0
[   14.143747] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bd01e000, rq->data_len: 0x24, on_stac=
k: 0
[   14.145647] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bd01e000, rq->data_len: 0x8, on_stack=
: 0
[   14.164628] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bd01e000, rq->data_len: 0x150, on_sta=
ck: 0
[   14.177046] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bd01e000, rq->data_len: 0xc, on_stack=
: 0
[   14.234175] PM: Starting manual resume from disk
[   14.539761] kjournald starting.  Commit interval 5 seconds
[   14.539802] EXT3-fs: mounted filesystem with ordered data mode.
[   16.731773] udevd version 125 started
[   16.873091] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff88003784b000, rq->data_len: 0x24, on_stac=
k: 0
[   16.874980] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff88003784b000, rq->data_len: 0x8, on_stack=
: 0
[   16.893470] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff88003784b000, rq->data_len: 0x150, on_sta=
ck: 0
[   16.905610] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff88003784b000, rq->data_len: 0xc, on_stack=
: 0
[   17.223546] input: Power Button (FF) as /class/input/input4
[   17.236076] ACPI: Power Button (FF) [PWRF]
[   17.236184] input: Lid Switch as /class/input/input5
[   17.240185] ACPI: Lid Switch [LID]
[   17.240246] input: Power Button (CM) as /class/input/input6
[   17.256105] ACPI: Power Button (CM) [PWRB]
[   17.256179] input: Sleep Button (CM) as /class/input/input7
[   17.268089] ACPI: Sleep Button (CM) [SLPB]
[   17.276177] ACPI: AC Adapter [ACAD] (on-line)
[   17.276319] ACPI: Battery Slot [BAT1] (battery absent)
[   17.276801] ACPI: WMI: Mapper loaded
[   17.376166] acpi device:04: registered as cooling_device2
[   17.376662] input: Video Bus as /class/input/input8
[   17.390091] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post=
: no)
[   17.700603] input: PC Speaker as /class/input/input9
[   17.706140] Linux video capture interface: v2.00
[   17.901511] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 19 (level, low=
) -> IRQ 19
[   17.901518] ACPI: I/O resource 0000:00:1f.3 [0x1c00-0x1c1f] conflict=
s with ACPI region SMBI [0x1c00-0x1c0f]
[   17.901521] ACPI: Device needs an ACPI driver
[   17.907540] uvcvideo: Found UVC 1.00 device Acer CrystalEye webcam (=
064e:a101)
[   17.910897] input: Acer CrystalEye webcam as /class/input/input10
[   17.916477] usbcore: registered new interface driver uvcvideo
[   17.916481] USB Video Class driver (v0.1.0)
[   17.947404] iwl3945: Intel(R) PRO/Wireless 3945ABG/BG Network Connec=
tion driver for Linux, 1.2.26ks
[   17.947409] iwl3945: Copyright(c) 2003-2008 Intel Corporation
[   17.947538] iwl3945 0000:06:00.0: enabling device (0000 -> 0002)
[   17.947550] iwl3945 0000:06:00.0: PCI INT A -> GSI 19 (level, low) -=
> IRQ 19
[   17.947570] iwl3945 0000:06:00.0: setting latency timer to 64
[   17.947598] iwl3945: Detected Intel Wireless WiFi Link 3945ABG
[   18.000063] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low)=
 -> IRQ 22
[   18.000100] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   18.011981] iwl3945: Tunable channels: 13 802.11bg, 23 802.11a chann=
els
[   18.012542] phy0: Selected rate control algorithm 'iwl-3945-rs'
[   18.071024] iwl3945 0000:06:00.0: PCI INT A disabled
[   18.338166] Synaptics Touchpad, model: 1, fw: 6.5, id: 0x1e0b1, caps=
: 0xc04751/0xe0500f
[   18.374786] input: SynPS/2 Synaptics TouchPad as /class/input/input1=
1
[   18.965805] Synaptics Touchpad, model: 1, fw: 6.5, id: 0x81a0b1, cap=
s: 0xa04711/0xa04000
[   18.999513] input: SynPS/2 Synaptics TouchPad as /class/input/input1=
2
[   19.481071] Adding 2931820k swap on /dev/sda5.  Priority:-1 extents:=
1 across:2931820k
[   20.056109] EXT3 FS on sda2, internal journal
[   21.456934] fuse init (API version 7.9)
[   21.570101] kjournald starting.  Commit interval 5 seconds
[   21.570318] EXT3 FS on sda3, internal journal
[   21.570325] EXT3-fs: mounted filesystem with ordered data mode.
[   21.619136] kjournald starting.  Commit interval 5 seconds
[   21.619173] EXT3-fs warning: maximal mount count reached, running e2=
fsck is recommended
[   21.619474] EXT3 FS on sda6, internal journal
[   21.619480] EXT3-fs: mounted filesystem with ordered data mode.
[   28.144704] NET: Registered protocol family 10
[   28.145346] lo: Disabled Privacy Extensions
[   36.032404] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bbdd1000, rq->data_len: 0x8, on_stack=
: 0
[   36.076491] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bbdd1000, rq->data_len: 0x44, on_stac=
k: 0
[   36.107032] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bbdd1000, rq->data_len: 0xc, on_stack=
: 0
[   36.138839] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bbdd1000, rq->data_len: 0x4c, on_stac=
k: 0
[   36.535684] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bbda19b8, rq->data_len: 0x8, on_stack=
: 1
[   36.556528] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bd0b1010, rq->data_len: 0x4, on_stack=
: 0
[   36.583090] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bbda1c98, rq->data_len: 0x20, on_stac=
k: 1
[   36.627163] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bbda1a98, rq->data_len: 0x8, on_stack=
: 1
[   36.652164] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bd0b1010, rq->data_len: 0x4, on_stack=
: 0
[   36.677457] cdrom: This disc doesn't have any tracks I recognize!
[   36.677522] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bbd30000, rq->data_len: 0x8, on_stack=
: 0
[   36.712433] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bbd30000, rq->data_len: 0x4, on_stack=
: 0
[   36.737177] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bbd30000, rq->data_len: 0x1c, on_stac=
k: 0
[   36.766285] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bbda1ae8, rq->data_len: 0x8, on_stack=
: 1
[   36.789914] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bd0b1010, rq->data_len: 0x4, on_stack=
: 0
[   36.813882] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bbda1b08, rq->data_len: 0x8, on_stack=
: 1
[   36.836406] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bd0b1010, rq->data_len: 0x4, on_stack=
: 0
[   37.206421] Bluetooth: Core ver 2.13
[   37.207135] NET: Registered protocol family 31
[   37.207195] Bluetooth: HCI device and connection manager initialized
[   37.207242] Bluetooth: HCI socket layer initialized
[   37.285246] Bluetooth: L2CAP ver 2.11
[   37.285268] Bluetooth: L2CAP socket layer initialized
[   37.322793] Bluetooth: RFCOMM socket layer initialized
[   37.323015] Bluetooth: RFCOMM TTY layer initialized
[   37.323125] Bluetooth: RFCOMM ver 1.10
[   37.671132] iwl3945 0000:06:00.0: PCI INT A -> GSI 19 (level, low) -=
> IRQ 19
[   37.671447] iwl3945 0000:06:00.0: restoring config space at offset 0=
x1 (was 0x100002, writing 0x100006)
[   37.671861] firmware: requesting iwlwifi-3945-1.ucode
[   37.752313] Registered led device: iwl-phy0:radio
[   37.753144] Registered led device: iwl-phy0:assoc
[   37.753736] Registered led device: iwl-phy0:RX
[   37.754403] Registered led device: iwl-phy0:TX
[   37.764568] ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   38.003999] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   38.369335] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bbd30000, rq->data_len: 0x8, on_stack=
: 0
[   38.394340] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ba03d000, rq->data_len: 0xc, on_stack=
: 0
[   38.425173] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ba03d000, rq->data_len: 0x4c, on_stac=
k: 0
[   40.369141] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ba066000, rq->data_len: 0x8, on_stack=
: 0
[   42.368289] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ba15f000, rq->data_len: 0x8, on_stack=
: 0
[   44.247786] nvidia: module license 'NVIDIA' taints kernel.
[   44.369228] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ba19a000, rq->data_len: 0x8, on_stack=
: 0
[   44.511851] nvidia 0000:01:00.0: PCI INT A -> GSI 16 (level, low) ->=
 IRQ 16
[   44.511862] nvidia 0000:01:00.0: setting latency timer to 64
[   44.512213] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  177.80  =
Wed Oct  1 14:43:46 PDT 2008
[   46.369257] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ba1d7000, rq->data_len: 0x8, on_stack=
: 0
[   48.369628] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800b80a9000, rq->data_len: 0x8, on_stack=
: 0
[   50.368623] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800b80ad000, rq->data_len: 0x8, on_stack=
: 0
[   53.842302] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ba1cb000, rq->data_len: 0x8, on_stack=
: 0
[   54.369612] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800b811c000, rq->data_len: 0x8, on_stack=
: 0
[   56.368778] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800b817a000, rq->data_len: 0x8, on_stack=
: 0
[   58.373120] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800b817a000, rq->data_len: 0x8, on_stack=
: 0
[   60.374065] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800b8044000, rq->data_len: 0x8, on_stack=
: 0
[   62.372798] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800b8097000, rq->data_len: 0x8, on_stack=
: 0
[   64.372831] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ba1cc000, rq->data_len: 0x8, on_stack=
: 0
[   66.372664] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800b8193000, rq->data_len: 0x8, on_stack=
: 0
[   68.374059] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800b3593000, rq->data_len: 0x8, on_stack=
: 0
[   70.373815] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800b3634000, rq->data_len: 0x8, on_stack=
: 0
[   71.178850] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800b351dae8, rq->data_len: 0x8, on_stack=
: 1
[   71.180896] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bd0b1010, rq->data_len: 0x4, on_stack=
: 0
[   72.373124] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800b8092000, rq->data_len: 0x8, on_stack=
: 0
[   74.372802] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800b1d4c000, rq->data_len: 0x8, on_stack=
: 0
[   76.373396] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800b1e03000, rq->data_len: 0x8, on_stack=
: 0
[   78.373347] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800b045c000, rq->data_len: 0x8, on_stack=
: 0
[   80.373026] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800b057e000, rq->data_len: 0x8, on_stack=
: 0
[   81.649419] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800af448000, rq->data_len: 0x24, on_stac=
k: 0
[   82.372627] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800af51c000, rq->data_len: 0x8, on_stack=
: 0
[   84.375201] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800b05ac000, rq->data_len: 0x8, on_stack=
: 0
[   86.375729] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800acdb6000, rq->data_len: 0x8, on_stack=
: 0
[   88.392731] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800acc6f000, rq->data_len: 0x8, on_stack=
: 0
[   90.374248] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ab40e000, rq->data_len: 0x8, on_stack=
: 0
[   92.376241] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800acd86000, rq->data_len: 0x8, on_stack=
: 0
[   93.634057] CE: hpet increasing min_delta_ns to 15000 nsec
[   94.374067] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800acdfb000, rq->data_len: 0x8, on_stack=
: 0
[   96.374059] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ab493000, rq->data_len: 0x8, on_stack=
: 0
[   98.373427] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ab588000, rq->data_len: 0x8, on_stack=
: 0
[  100.373341] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ba428000, rq->data_len: 0x8, on_stack=
: 0
[  102.374209] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bbd73000, rq->data_len: 0x8, on_stack=
: 0
[  104.374098] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bbd73000, rq->data_len: 0x8, on_stack=
: 0
[  106.373923] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800acc78000, rq->data_len: 0x8, on_stack=
: 0
[  108.373172] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800b1dbc000, rq->data_len: 0x8, on_stack=
: 0
[  110.373927] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800b1dbc000, rq->data_len: 0x8, on_stack=
: 0
[  112.373143] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ab597000, rq->data_len: 0x8, on_stack=
: 0
[  114.373189] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ab597000, rq->data_len: 0x8, on_stack=
: 0
[  116.374138] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ab406000, rq->data_len: 0x8, on_stack=
: 0
[  118.373893] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800b0407000, rq->data_len: 0x8, on_stack=
: 0
[  120.374122] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800b0407000, rq->data_len: 0x8, on_stack=
: 0
[  122.374191] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ab431000, rq->data_len: 0x8, on_stack=
: 0
[  124.374187] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800acc2f000, rq->data_len: 0x8, on_stack=
: 0
[  126.373150] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800acc2f000, rq->data_len: 0x8, on_stack=
: 0
[  128.374251] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800af540000, rq->data_len: 0x8, on_stack=
: 0
[  130.374482] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800acd37000, rq->data_len: 0x8, on_stack=
: 0
[  132.373235] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ba442000, rq->data_len: 0x8, on_stack=
: 0
[  134.374344] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ba442000, rq->data_len: 0x8, on_stack=
: 0
[  136.373325] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800acc5b000, rq->data_len: 0x8, on_stack=
: 0
[  138.374508] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800acdfb000, rq->data_len: 0x8, on_stack=
: 0
[  140.373506] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ab52a000, rq->data_len: 0x8, on_stack=
: 0
[  142.373485] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800acd86000, rq->data_len: 0x8, on_stack=
: 0
[  144.373435] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800acd86000, rq->data_len: 0x8, on_stack=
: 0
[  146.373545] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800acd86000, rq->data_len: 0x8, on_stack=
: 0
[  146.801538] wlan0: authenticate with AP 00:14:7c:53:c4:34
[  146.803379] wlan0: authenticated
[  146.803447] wlan0: associate with AP 00:14:7c:53:c4:34
[  146.805931] wlan0: RX AssocResp from 00:14:7c:53:c4:34 (capab=3D0x43=
1 status=3D0 aid=3D1)
[  146.805992] wlan0: associated
[  146.807548] ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[  148.375379] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ab550000, rq->data_len: 0x8, on_stack=
: 0
[  150.374913] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bbc5e000, rq->data_len: 0x8, on_stack=
: 0
[  152.374174] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ba447000, rq->data_len: 0x8, on_stack=
: 0
[  154.374174] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bbd82000, rq->data_len: 0x8, on_stack=
: 0
[  156.374466] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800bbd82000, rq->data_len: 0x8, on_stack=
: 0
[  158.374200] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ba457000, rq->data_len: 0x8, on_stack=
: 0
[  160.374486] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800accc7000, rq->data_len: 0x8, on_stack=
: 0
[  161.244143] wlan0: no IPv6 routers present
[  162.374780] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800accc7000, rq->data_len: 0x8, on_stack=
: 0
[  164.375072] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ba460000, rq->data_len: 0x8, on_stack=
: 0
[  166.375383] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ba43a000, rq->data_len: 0x8, on_stack=
: 0
[  168.375571] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ab5da000, rq->data_len: 0x8, on_stack=
: 0
[  170.375922] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ab5da000, rq->data_len: 0x8, on_stack=
: 0
[  172.375955] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ab49d000, rq->data_len: 0x8, on_stack=
: 0
[  174.373494] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800af5ff000, rq->data_len: 0x8, on_stack=
: 0
[  176.373420] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800af5ff000, rq->data_len: 0x8, on_stack=
: 0
[  178.373266] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800acc3d000, rq->data_len: 0x8, on_stack=
: 0
[  180.374367] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800acc3d000, rq->data_len: 0x8, on_stack=
: 0
[  182.374511] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->=
dma_pad_mask: 0xf,addr: 0xffff8800ab52a000, rq->data_len: 0x8, on_stack=
: 0

