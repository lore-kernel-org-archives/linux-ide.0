From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: DMA doesn't work since "make ata port as parent device of scsi
 host"
Date: Thu, 15 Mar 2012 09:59:01 +0800
Message-ID: <1331776741.3436.33.camel@minggr>
References: <20120315014807.GA3051@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:43673 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759659Ab2COB7E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Mar 2012 21:59:04 -0400
In-Reply-To: <20120315014807.GA3051@alea.gnuu.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Cc: Jeff Garzik <jgarzik@redhat.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On Thu, 2012-03-15 at 02:48 +0100, J=C3=B6rg Sommer wrote:
> Hi,
>=20
> I'm getting these messages in a KVM virtualized host and the access t=
o
> the disks is very slow. Using libata.dma=3D0 suppresses the warnings,=
 but
> the disks are still slow.

Hi J=C3=B6rg,

Let me try to reproduce this issue first.

Thanks for the report.
Lin Ming

>=20
> [    3.117419] pata-macio 0.00020000:ata-1: Activating pata-macio chi=
pset Heathrow ATA, Apple bus ID 0
> [    3.121637] scsi0 : pata_macio
> [    3.123071] ata1: PATA max MWDMA2 irq 17
> [    3.289181] ata1.00: ATA-7: QEMU HARDDISK, 1.0,1, max UDMA/100
> [    3.290843] ata1.00: 3906250 sectors, multi 16: LBA48=20
> [    3.296526] ata1.01: ATA-7: QEMU HARDDISK, 1.0,1, max UDMA/100
> [    3.301789] ata1.01: 1953125 sectors, multi 16: LBA48=20
> [    3.309588] ata1.00: configured for MWDMA2
> [    3.322195] ata1.01: configured for MWDMA2
> [    3.324375] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK=
    1.0, PQ: 0 ANSI: 5
> [    3.335681] sd 0:0:0:0: [sda] 3906250 512-byte logical blocks: (2.=
00 GB/1.86 GiB)
> [    3.342118] scsi 0:0:1:0: Direct-Access     ATA      QEMU HARDDISK=
    1.0, PQ: 0 ANSI: 5
> [    3.349779] sd 0:0:0:0: [sda] Write Protect is off
> [    3.351558] sd 0:0:1:0: [sdb] 1953125 512-byte logical blocks: (1.=
00 GB/953 MiB)
> [    3.361555] sd 0:0:0:0: [sda] Write cache: disabled, read cache: e=
nabled, doesn't support DPO or FUA
> [    3.377923]  sda: unknown partition table
> [    3.387499] sd 0:0:1:0: [sdb] Write Protect is off
> [    3.389902] sd 0:0:0:0: [sda] Attached SCSI disk
> [    3.395363] sd 0:0:1:0: [sdb] Write cache: disabled, read cache: e=
nabled, doesn't support DPO or FUA
> [    3.407258]  sdb: unknown partition table
> [    3.410463] sd 0:0:1:0: [sdb] Attached SCSI disk
> [    4.137709] pata-macio 0.00021000:ata-2: Activating pata-macio chi=
pset Heathrow ATA, Apple bus ID 0
> [    4.141529] scsi1 : pata_macio
> [    4.142797] ata2: PATA max MWDMA2 irq 19
> [    4.302209] ata2.00: ATAPI: QEMU DVD-ROM, 1.0,1, max UDMA/100
> [    4.306595] ata2.00: configured for MWDMA2
> [    4.309863] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM =
    1.0, PQ: 0 ANSI: 5
> [    5.158307] pata-macio 0.00022000:ata-3: Activating pata-macio chi=
pset Heathrow ATA, Apple bus ID 0
> [    5.163497] scsi2 : pata_macio
> [    5.164792] ata3: PATA max MWDMA2 irq 21
> [    5.166278] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Dr=
iver
> [    5.168587] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    5.171020] mousedev: PS/2 mouse device common for all mice
> [    5.174973] device-mapper: ioctl: 4.22.0-ioctl (2011-10-19) initia=
lised: dm-devel@redhat.com
> [    5.178453] zcache: cleancache enabled using kernel transcendent m=
emory and compression buddies
> [    5.181809] TCP cubic registered
> [    5.183188] NET: Registered protocol family 17
> [    5.184472] Registering the dns_resolver key type
> [    5.201059] registered taskstats version 1
> [    5.203025] Running tests on trace events:
>=20
> [   10.524655] EXT4-fs (sda): couldn't mount as ext3 due to feature i=
ncompatibilities
> [   10.528671] EXT4-fs (sda): couldn't mount as ext2 due to feature i=
ncompatibilities
> [   10.574484] zcache: created ephemeral tmem pool, id=3D0, client=3D=
65535
> [   10.577259] EXT4-fs (sda): mounted filesystem without journal. Opt=
s: (null)
> [   10.579299] VFS: Mounted root (ext4 filesystem) readonly on device=
 8:0.
> [   10.583854] Freeing unused kernel memory: 280k freed
> [   40.828762] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action =
0x0
> [   40.830697] ata1.00: failed command: READ DMA
> [   40.831985] ata1.00: cmd c8/00:c8:38:22:00/00:00:00:00:00/e0 tag 0=
 dma 102400 in
> [   40.831992]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask=
 0x20 (host bus error)
> [   40.840162] ata1.00: status: { DRDY }
> [   45.923821] ata1.00: qc timeout (cmd 0xec)
> [   45.925142] ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4=
)
> [   45.926957] ata1.00: revalidation failed (errno=3D-5)
> [   50.975553] ata1: link is slow to respond, please be patient (read=
y=3D0)
> [   55.974506] ata1: device not ready (errno=3D-16), forcing hardrese=
t
> [   55.976336] ata1: soft resetting link
> [   56.137659] ata1.00: configured for MWDMA2
> [   56.142009] ata1.01: configured for MWDMA2
> [   56.143237] ata1.00: device reported invalid CHS sector 0
> [   56.144780] sd 0:0:0:0: [sda]  Result: hostbyte=3D0x00 driverbyte=3D=
0x08
> [   56.146859] sd 0:0:0:0: [sda]  Sense Key : 0xb [current] [descript=
or]
> [   56.148833] Descriptor sense data with sense descriptors (in hex):
> [   56.150542]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 0=
0=20
> [   56.153138]         00 00 00 00=20
> [   56.154286] sd 0:0:0:0: [sda]  ASC=3D0x0 ASCQ=3D0x0
> [   56.155722] sd 0:0:0:0: [sda] CDB: cdb[0]=3D0x28: 28 00 00 00 22 3=
8 00 00 c8 00
> [   56.161462] end_request: I/O error, dev sda, sector 8760
> [   56.163069] ata1: EH complete
> [   86.870671] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action =
0x0
> [   86.872494] ata1.00: failed command: READ DMA
> [   86.873741] ata1.00: cmd c8/00:c0:40:22:00/00:00:00:00:00/e0 tag 0=
 dma 98304 in
> [   86.873748]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask=
 0x20 (host bus error)
> [   86.877995] ata1.00: status: { DRDY }
> [   91.961330] ata1.00: qc timeout (cmd 0xec)
> [   91.962699] ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4=
)
> [   91.964398] ata1.00: revalidation failed (errno=3D-5)
> [   97.014555] ata1: link is slow to respond, please be patient (read=
y=3D0)
> [  102.016502] ata1: device not ready (errno=3D-16), forcing hardrese=
t
> [  102.018329] ata1: soft resetting link
> [  102.182355] ata1.00: configured for MWDMA2
> [  102.186312] ata1.01: configured for MWDMA2
> [  102.187498] ata1.00: device reported invalid CHS sector 0
> [  102.189078] ata1: EH complete
> [  132.862149] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action =
0x0
> [  132.864011] ata1.00: failed command: READ DMA
> [  132.865674] ata1.00: cmd c8/00:c0:40:22:00/00:00:00:00:00/e0 tag 0=
 dma 98304 in
> [  132.865682]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask=
 0x20 (host bus error)
> [  132.869786] ata1.00: status: { DRDY }
> [  137.949377] ata1.00: qc timeout (cmd 0xec)
> [  137.950632] ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4=
)
> [  137.952549] ata1.00: revalidation failed (errno=3D-5)
> [  142.954461] ata1: link is slow to respond, please be patient (read=
y=3D0)
>=20
> I've tracked this down to =E2=80=9Eata: make ata port as parent devic=
e of scsi
> host=E2=80=9C (9a6d6a2ddabbd32c07f6a38b659e5f3db319fa5a) with git bis=
et.
>=20
>     ata: make ata port as parent device of scsi host
>    =20
>     Currently, the device tree of ata port and scsi host looks as bel=
ow,
>    =20
>             /sys/devices/pci0000:00/0000:00:1f.2    (ahci controller)
>             |-- ata1                                (ata port)
>             |-- host0                               (scsi host)
>                |-- target0:0:0                      (scsi target)
>                    |-- 0:0:0:0                      (disk)
>    =20
>     This patch makes ata port as parent device of scsi host, then it =
becomes
>    =20
>             /sys/devices/pci0000:00/0000:00:1f.2    (ahci controller)
>             |-- ata1                                (ata port)
>                 |-- host0                           (scsi host)
>                     |-- target0:0:0                 (scsi target)
>                         |-- 0:0:0:0                 (disk)
>    =20
>     With this change, the ata port runtime PM is easier.
>     For example, the ata port runtime suspend will happen as,
>    =20
>     disk suspend --> scsi target suspend --> scsi host suspend --> at=
a port
>     suspend.
>    =20
>     Acked-by: Tejun Heo <tj@kernel.org>
>     Signed-off-by: Lin Ming <ming.m.lin@intel.com>
>     Signed-off-by: Jeff Garzik <jgarzik@redhat.com>
>=20
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 2a5412e..7ae1e77 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3398,7 +3398,7 @@ int ata_scsi_add_hosts(struct ata_host *host, s=
truct scsi_host_template *sht)
>                  */
>                 shost->max_host_blocked =3D 1;
> =20
> -               rc =3D scsi_add_host(ap->scsi_host, ap->host->dev);
> +               rc =3D scsi_add_host(ap->scsi_host, &ap->tdev);
>                 if (rc)
>                         goto err_add;
>         }
>=20
> Can you tell, what might be wrong?
>=20
> % cat /proc/cpuinfo
> processor	: 0
> cpu		: 7455, altivec supported
> clock		: 798.720000MHz
> revision	: 3.3 (pvr 8001 0303)
> bogomips	: 48.58
> timebase	: 18432000
> platform	: PowerMac
> model		: PowerBook6,3
> machine		: PowerBook6,3
> motherboard	: PowerBook6,3 MacRISC3 Power Macintosh
> detected as	: 287 (iBook G4)
> pmac flags	: 0000001b
> L2 cache	: 256K unified
> pmac-generation	: NewWorld
> Memory		: 640 MB
>=20
> # qemu-system-ppc -enable-kvm -M mac99 -cpu G4 -k de \
>   -kernel /boot/vmlinuz-3.3.0-rc5 \
>   -append 'root=3D/dev/sda ro console=3DttyPZ0 zcache' \
>   -hda /mnt/data/debian-base-root.raw -hdb /mnt/data/debian-base-var.=
raw
>=20
> Bye, J=C3=B6rg.


