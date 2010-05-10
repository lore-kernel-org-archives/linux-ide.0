From: saeed bishara <saeed.bishara@gmail.com>
Subject: Re: [BUG] bug when enabling VM DEBUG
Date: Mon, 10 May 2010 16:09:45 +0300
Message-ID: <AANLkTinmx0RM73y4rDloMa8zibqlLcCwIEntqpdW_ksJ@mail.gmail.com>
References: <AANLkTikkSRI6u_mp6mNQReECB84t3oh-_MPVzAYEQULN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:51445 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754351Ab0EJNJr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 May 2010 09:09:47 -0400
Received: by wwa36 with SMTP id 36so1527948wwa.19
        for <linux-ide@vger.kernel.org>; Mon, 10 May 2010 06:09:46 -0700 (PDT)
In-Reply-To: <AANLkTikkSRI6u_mp6mNQReECB84t3oh-_MPVzAYEQULN@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

forgot to mention that the system is arm based.

On Mon, May 10, 2010 at 4:06 PM, saeed bishara <saeed.bishara@gmail.com=
> wrote:
> Hi,
> =C2=A0I got the following bug when enabling the VM_DEBGU on 2.6.34-rc=
6:
>
> Unable to handle kernel NULL pointer dereference at virtual address 0=
0000000
> pgd =3D c0004000
> [00000000] *pgd=3D00000000
> Internal error: Oops: 805 [#1]
> last sysfs file:
> Modules linked in:
> CPU: 0 =C2=A0 =C2=A0Not tainted =C2=A0(2.6.34-rc6-00176-g00047b8-dirt=
y #331)
> PC is at flush_dcache_page+0x2c/0xc4
> LR is at ata_pio_sector+0xd8/0x124
> pc : [<c002d30c>] =C2=A0 =C2=A0lr : [<c01c29d4>] =C2=A0 =C2=A0psr: 20=
000013
> sp : f5513ee8 =C2=A0ip : 79a50000 =C2=A0fp : 00001ee8
> r10: 00000058 =C2=A0r9 : f54f0000 =C2=A0r8 : 00000000
> r7 : f54f1358 =C2=A0r6 : c03e6b84 =C2=A0r5 : 00000000 =C2=A0r4 : 0000=
0000
> r3 : 00000000 =C2=A0r2 : 00000000 =C2=A0r1 : f54f17b8 =C2=A0r0 : c0ac=
4e20
> Flags: nzCv =C2=A0IRQs on =C2=A0FIQs on =C2=A0Mode SVC_32 =C2=A0ISA A=
RM =C2=A0Segment kernel
> Control: 10c5387d =C2=A0Table: 00004019 =C2=A0DAC: 00000017
> Process ata/0 (pid: 145, stack limit =3D 0xf55122f0)
> Stack: (0xf5513ee8 to 0xf5514000)
> 3ee0: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
c0ac4e20 c01c29d4 00000009 f54f1358 f54f1358 00000001
> 3f00: c040d18c c01c2ad8 00000005 00000009 f54f0000 c01c3204 c03cfe78 =
00000000
> 3f20: 00200200 f54f13d4 c00446e4 00000001 f54f1424 00000000 00000000 =
00000000
> 3f40: 00000000 00000000 ffffffff 00000009 f54f0000 f54f1358 00000001 =
c040d18c
> 3f60: 00000005 0000000a 00001ee8 c01c46d8 f5413c70 f54b5b68 c01c45d4 =
f54b5b60
> 3f80: f5512000 f5513f9c 00000000 00000000 00000000 c004b2c0 00000000 =
00000000
> 3fa0: f54be0c0 c004e12c f5513fa8 f5513fa8 f5429ec8 f5513fd4 f5429ec8 =
f54b5b60
> 3fc0: c004b1c8 00000000 00000000 c004e014 00000000 00000000 f5513fd8 =
f5513fd8
> 3fe0: 00000000 00000000 00000000 00000000 00000000 c0026dec bc7e4afb =
6a3a8a30
> [<c002d30c>] (flush_dcache_page+0x2c/0xc4) from [<c01c29d4>]
> (ata_pio_sector+0xd8/0x124)
> [<c01c29d4>] (ata_pio_sector+0xd8/0x124) from [<c01c2ad8>]
> (ata_pio_sectors+0xb8/0xc4)
> [<c01c2ad8>] (ata_pio_sectors+0xb8/0xc4) from [<c01c3204>]
> (ata_sff_hsm_move+0x618/0x76c)
> [<c01c3204>] (ata_sff_hsm_move+0x618/0x76c) from [<c01c46d8>]
> (ata_pio_task+0x104/0x124)
> [<c01c46d8>] (ata_pio_task+0x104/0x124) from [<c004b2c0>]
> (worker_thread+0xf8/0x170)
> [<c004b2c0>] (worker_thread+0xf8/0x170) from [<c004e014>] (kthread+0x=
78/0x80)
> [<c004e014>] (kthread+0x78/0x80) from [<c0026dec>] (kernel_thread_exi=
t+0x0/0x8)
> Code: e5904010 e3130080 0a000002 e3a03000 (e5833000)
> ---[ end trace 8a7ce1ae66250005 ]---
>
