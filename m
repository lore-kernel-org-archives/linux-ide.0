From: "Tony Battersby" <tonyb@cybernetics.com>
Subject: SATA (libata) + sg oops in 2.4.28-pre1
Date: Mon, 16 Aug 2004 17:04:54 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <04Aug16.170456edt.332566@cyborg.cybernetics.com>
Reply-To: <tonyb@cybernetics.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_001C_01C483B3.27872750"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cyborg.cybernetics.com ([206.246.200.18]:26895 "EHLO
	cybernetics.com") by vger.kernel.org with ESMTP id S266341AbUHPVff
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Aug 2004 17:35:35 -0400
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_001C_01C483B3.27872750
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I get an oops trying to get standard inquiry data from a SATA disk via
/dev/sg0 in kernel 2.4.28-pre1:

Unable to handle kernel NULL pointer dereference at virtual address
0000001b
 printing eip:
d0873f99
*pde = 00000000
Oops: 0000
ata_piix libata sg e1000
CPU:    0
EIP:    0010:[<d0873f99>]    Not tainted
EFLAGS: 00010002
EIP is at ata_scsi_rbuf_get+0x19/0x80 [libata]
eax: 00000000   ebx: d0874060   ecx: cf7c4000   edx: cf7908f4
esi: cfc42800   edi: cf80fd8c   ebp: cf790800   esp: cf80fd5c
ds: 0018   es: 0018   ss: 0018
Process cytdtest (pid: 264, stackpage=cf80f000)
Stack: d0874060 cf80fd8c d087401a cfc42800 cf80fd70 c0131d13 cfc42800
c01ac2e0
       c01ac2e0 d0874915 cf80fd8c d0874060 cf79087c cf7908f4 cfc42800
c01ac2e0
       cfc42800 cf79087c d08747f9 cf79087c cf7908f4 cfc42800 c01ac2e0
00000287
Call Trace:
 [<d0874060>] ata_scsiop_inq_std+0x0/0xd0 [libata]
 [<d087401a>] ata_scsi_rbuf_fill+0x1a/0x60 [libata]
 [<c0131d13>] kmalloc+0xa3/0x180 [kernel]
 [<c01ac2e0>] scsi_done+0x0/0xd0 [kernel]
 [<c01ac2e0>] scsi_done+0x0/0xd0 [kernel]
 [<d0874915>] ata_scsi_simulate+0xe5/0x144 [libata]
 [<d0874060>] ata_scsiop_inq_std+0x0/0xd0 [libata]
 [<c01ac2e0>] scsi_done+0x0/0xd0 [kernel]
 [<d08747f9>] ata_scsi_queuecmd+0xe9/0x120 [libata]
 [<c01ac2e0>] scsi_done+0x0/0xd0 [kernel]
 [<c01abaa5>] scsi_dispatch_cmd+0x195/0x380 [kernel]
 [<c01ac2e0>] scsi_done+0x0/0xd0 [kernel]
 [<c01b3cd4>] scsi_request_fn+0x354/0x3b0 [kernel]
 [<c01b2f9c>] __scsi_insert_special+0x6c/0x80 [kernel]
 [<c01b2ffa>] scsi_insert_special_req+0x1a/0x20 [kernel]
 [<c01abeb4>] scsi_do_req+0x174/0x1b0 [kernel]
 [<d08681d0>] sg_cmd_done_bh+0x0/0x380 [sg]
 [<d086706b>] sg_common_write+0x24b/0x260 [sg]
 [<d08681d0>] sg_cmd_done_bh+0x0/0x380 [sg]
 [<d0866df5>] sg_new_write+0x225/0x250 [sg]
 [<d08669d4>] sg_write+0x104/0x300 [sg]
 [<c01147a7>] do_page_fault+0x1a7/0x4eb [kernel]
 [<c012a2e6>] do_brk+0x206/0x250 [kernel]
 [<c013b456>] sys_write+0x96/0x110 [kernel]
 [<c013a9ad>] filp_open+0x4d/0x60 [kernel]
 [<c01290ca>] sys_brk+0xba/0xf0 [kernel]
 [<c0106ff3>] system_call+0x33/0x38 [kernel]

Code: 0f b6 50 1b 8b 14 95 88 f0 2e c0 8b ba c4 00 00 00 8b 9a c8

The same problem exists in kernel 2.4.27 with 2.4.27-rc3-libata1.patch
applied.

The program to reproduce the problem is attached.  *** NOTE *** You must
do "echo 1 > /proc/scsi/sg/allow_dio" before running the program for the
oops to happen.

The condition that triggers the oops is having struct scsi_cmnd::use_sg
!= 0 in ata_scsi_rbuf_get().  The attached test program accomplishes
this by using direct I/O with a user buffer that crosses page
boundaries.  The test program works just fine when using indirect I/O or
when using direct I/O with a user buffer that doesn't cross page
boundaries (in which case use_sg == 0).

Here is some extra dmesg output if useful:

libata version 1.02 loaded.
ata_piix version 1.02
PCI: Setting latency timer of device 00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD800 irq 10
ata2: SATA max UDMA/133 cmd 0xD000 ctl 0xD402 bmdma 0xD808 irq 10
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003
88:207f
ata1: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
ata1: dev 0 configured for UDMA/133
ata2: SATA port has no device.
scsi0 : ata_piix
scsi1 : ata_piix
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
 sda: unknown partition table

Anthony J. Battersby
Cybernetics

------=_NextPart_000_001C_01C483B3.27872750
Content-Type: application/octet-stream;
	name="inquiry.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="inquiry.c"

#include <stdlib.h>=0A=
#include <stdio.h>=0A=
#include <stdint.h>=0A=
#include <string.h>=0A=
#include <unistd.h>=0A=
#include <limits.h>=0A=
#include <sys/types.h>=0A=
#include <sys/stat.h>=0A=
#include <fcntl.h>=0A=
#include <scsi/sg.h>=0A=
=0A=
#define TXFER_LEN 56=0A=
=0A=
int main(int argc, char *argv[]) {=0A=
    char *sgd =3D (argc =3D=3D 2) ? argv[1] : "/dev/sg0";=0A=
    sg_io_hdr_t io;=0A=
    uint8_t cdb[16];=0A=
    uint8_t *sense_data;=0A=
    uint8_t *buf;=0A=
    int pagesize =3D getpagesize();=0A=
    int fd;=0A=
    unsigned long addr;=0A=
    ssize_t len;=0A=
=0A=
    fd =3D open(sgd, O_RDWR);=0A=
    if (fd =3D=3D -1) {=0A=
        perror("open(/dev/sgX)");=0A=
        exit(EXIT_FAILURE);=0A=
    }=0A=
=0A=
    buf =3D malloc(pagesize + TXFER_LEN);=0A=
    if (buf =3D=3D NULL) {=0A=
        printf("OOM\n");=0A=
        exit(EXIT_FAILURE);=0A=
    }=0A=
=0A=
    /* Force the buffer to cross a page boundary. */=0A=
    addr =3D (unsigned long) buf;=0A=
    addr =3D (addr & ~(pagesize - 1)) |=0A=
           (-(TXFER_LEN / 2) & (pagesize - 1));=0A=
    buf =3D (uint8_t *) addr;=0A=
=0A=
    sense_data =3D malloc(0x100);=0A=
    if (sense_data =3D=3D NULL) {=0A=
        printf("OOM\n");=0A=
        exit(EXIT_FAILURE);=0A=
    }=0A=
=0A=
    memset(&io, 0, sizeof(io));=0A=
=0A=
    io.interface_id =3D 'S';=0A=
    io.timeout      =3D UINT_MAX;=0A=
=0A=
    io.sbp       =3D sense_data;=0A=
    io.mx_sb_len =3D 0xff;=0A=
=0A=
    io.dxferp          =3D buf;=0A=
    io.dxfer_len       =3D TXFER_LEN;=0A=
    io.dxfer_direction =3D SG_DXFER_FROM_DEV;=0A=
    io.flags           =3D SG_FLAG_DIRECT_IO;=0A=
=0A=
    io.cmdp =3D cdb;=0A=
    io.cmd_len =3D 6;=0A=
    cdb[0] =3D 0x12; /* inquiry */=0A=
    cdb[1] =3D 0x00;=0A=
    cdb[2] =3D 0x00;=0A=
    cdb[3] =3D 0x00;=0A=
    cdb[4] =3D TXFER_LEN;=0A=
    cdb[5] =3D 0x00;=0A=
=0A=
    len =3D write(fd, &io, sizeof(io));=0A=
    if (len < 0) {=0A=
        perror("write /dev/sgX");=0A=
        exit(EXIT_FAILURE);=0A=
    }=0A=
=0A=
    len =3D read(fd, &io, sizeof(io));=0A=
    if (len < 0) {=0A=
        perror("read /dev/sgX");=0A=
        exit(EXIT_FAILURE);=0A=
    }=0A=
=0A=
    if ((io.status !=3D 0) ||=0A=
        (io.host_status !=3D 0) ||=0A=
        ((io.driver_status & 0x07) !=3D 0)) {=0A=
        printf("error getting inquiry string\n");=0A=
        exit(EXIT_FAILURE);=0A=
    }=0A=
=0A=
    printf("%.28s\n", &buf[8]);=0A=
=0A=
    if (!(io.info & SG_INFO_DIRECT_IO)) {=0A=
        printf("You must do 'echo 1 > /proc/scsi/sg/allow_dio' for the =
oops to happen.\n");=0A=
    }=0A=
=0A=
    return EXIT_SUCCESS;=0A=
}=0A=

------=_NextPart_000_001C_01C483B3.27872750--

