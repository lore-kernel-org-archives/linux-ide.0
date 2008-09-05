From: Mariusz Kozlowski <m.kozlowski-NWF1p15JEu3VItvQsEIGlw@public.gmane.org>
Subject: Re: 2.6.27-rc5-mm1: rmmod ide-cd_mod: tried to init an initialized object, something is seriously wrong.
Date: Fri, 5 Sep 2008 15:44:34 +0200
Message-ID: <200809051544.35443.m.kozlowski@tuxland.pl>
References: <20080904224004.d3dd3076.akpm@linux-foundation.org> <200809051439.32724.m.kozlowski@tuxland.pl> <200809051528.54213.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200809051528.54213.rjw-KKrjLPT3xs0@public.gmane.org>
Content-Disposition: inline
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, bzolnier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Witam,

> > 	Again 100% reproducible rmmod ide-cd_mod problem. Kernel is tainte=
d because
> > of earlier sysfs acpi problems similar (probably identical) to thos=
e reported
> > by Li Zefan here http://marc.info/?l=3Dlinux-kernel&m=3D12192105902=
6064&w=3D2
> >=20
> > Steps to reproduce: unload ide-cd_mod
> >=20
> > kobject (dd9e4a7c): tried to init an initialized object, something =
is seriously wrong.
> > Pid: 4734, comm: modprobe Tainted: G        W 2.6.27-rc5-mm1 #1
> >  [<c01ec982>] kobject_init+0xc4/0xc9
> >  [<c02cb84a>] ? _spin_unlock+0x27/0x3f
> >  [<c01aff2e>] ? sysfs_find_dirent+0x21/0x2b
> >  [<c01aff7e>] ? __sysfs_add_one+0x46/0x6d
> >  [<c01affb4>] ? sysfs_add_one+0xf/0x44
> >  [<c01b0036>] ? sysfs_addrm_start+0x4d/0x90
> >  [<c01b0f31>] ? sysfs_do_create_link+0x9a/0x14c
> >  [<c01ec9c5>] kobject_init_and_add+0x14/0x30
> >  [<c01b1009>] ? sysfs_create_link+0x12/0x19
> >  [<c01e8bad>] blk_register_filter+0x3b/0x46
> >  [<ded9e40a>] ide_cd_probe+0x253/0x5a8 [ide_cd_mod]
> >  [<c01b0000>] ? sysfs_addrm_start+0x17/0x90
> >  [<c01b0f31>] ? sysfs_do_create_link+0x9a/0x14c
> >  [<c01b004e>] ? sysfs_addrm_start+0x65/0x90
> >  [<c025145f>] generic_ide_probe+0x1f/0x21
> >  [<c024c002>] driver_probe_device+0x77/0x15b
> >  [<c02cb91b>] ? _spin_unlock_irqrestore+0x39/0x60
> >  [<c024c146>] __driver_attach+0x60/0x62
> >  [<c024b7bd>] bus_for_each_dev+0x44/0x62
> >  [<c0251461>] ? generic_ide_remove+0x0/0x1e
> >  [<c024bead>] driver_attach+0x19/0x1b
> >  [<c024c0e6>] ? __driver_attach+0x0/0x62
> >  [<c024bca8>] bus_add_driver+0x1ab/0x213
> >  [<c0251461>] ? generic_ide_remove+0x0/0x1e
> >  [<c024c291>] driver_register+0x4f/0x118
> >  [<de7bf000>] ? ide_cdrom_init+0x0/0xf [ide_cd_mod]
> >  [<de7bf00d>] ide_cdrom_init+0xd/0xf [ide_cd_mod]
> >  [<c0101114>] do_one_initcall+0x24/0x12f
> >  [<c02c9d8e>] ? mutex_unlock+0x8/0xa
> >  [<c01455ca>] sys_init_module+0xa5/0x1c1
> >  [<c0176a0a>] ? sys_read+0x3d/0x64
> >  [<c01030f1>] sysenter_do_call+0x12/0x35
> >  [<c012007b>] ? __set_special_pids+0x43/0x71
> >=20
> > First time I modprobe/rmmod ide-cd_mod the system works but quickly=
 gets unstable.
> > Second modprobe/rmmod is 100% fatal. Memory gets corruped seriously=
 I guess.
> > pcspeaker beeps all the time, kernel throws dumps on the screen unt=
il
> > its really dead, sadly blinking 'leds of panic' ;)
>=20
> Can you please verify if that happens with the current mainline?

Oops. How come I didn't find it earlier? hmm...
This is current mainline:

kobject (ddb049fc): tried to init an initialized object, something is s=
eriously wrong.
Pid: 4650, comm: modprobe Not tainted 2.6.27-rc5-00132-gb380b0d #8
 [<c01e3196>] kobject_init+0x6a/0x6c
 [<c01e35cb>] kobject_init_and_add+0x14/0x30
 [<c01e32f7>] ? kobject_get+0x12/0x17
 [<c01df89c>] blk_register_filter+0x4b/0x5a
 [<de839310>] ide_cd_probe+0x289/0x5ae [ide_cd_mod]
 [<c01aad99>] ? sysfs_addrm_start+0x65/0x90
 [<c01aba69>] ? sysfs_do_create_link+0x9a/0x11c
 [<c024f7a0>] generic_ide_probe+0x1f/0x21
 [<c024a672>] driver_probe_device+0x77/0x15b
 [<c02c8bdb>] ? _spin_unlock_irqrestore+0x39/0x60
 [<c024a7b6>] __driver_attach+0x60/0x62
 [<c0249e2a>] bus_for_each_dev+0x44/0x62
 [<c024f7a2>] ? generic_ide_remove+0x0/0x1e
 [<c024a51d>] driver_attach+0x19/0x1b
 [<c024a756>] ? __driver_attach+0x0/0x62
 [<c024a318>] bus_add_driver+0x1ae/0x216
 [<c024f7a2>] ? generic_ide_remove+0x0/0x1e
 [<c024a901>] driver_register+0x4f/0x118
 [<dee3500d>] ide_cdrom_init+0xd/0xf [ide_cd_mod]
 [<c010111a>] do_one_initcall+0x2a/0x14c
 [<c0108560>] ? native_sched_clock+0x58/0xa1
 [<dee35000>] ? ide_cdrom_init+0x0/0xf [ide_cd_mod]
 [<c013d042>] ? trace_hardirqs_on+0xb/0xd
 [<c013cfaf>] ? trace_hardirqs_on_caller+0xac/0x134
 [<c0147083>] sys_init_module+0x7e/0x19f
 [<c013cfaf>] ? trace_hardirqs_on_caller+0xac/0x134
 [<c01e8144>] ? trace_hardirqs_on_thunk+0xc/0x10
 [<c0103035>] sysenter_do_call+0x12/0x35
 [<c012007b>] ? put_fs_struct+0x5/0x2e
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
BUG kmalloc-16: Object already free
-----------------------------------------------------------------------=
------

INFO: Allocated in kvasprintf+0x2d/0x4c age=3D23609 cpu=3D0 pid=3D743
INFO: Freed in kobject_release+0x3a/0x56 age=3D45 cpu=3D0 pid=3D4645
INFO: Slab 0xc13b74e0 objects=3D64 used=3D45 fp=3D0xddba70c0 flags=3D0x=
40000083
INFO: Object 0xddba7400 @offset=3D1024 fp=3D0xddba7440

Bytes b4 0xddba73f0:  25 12 00 00 b4 43 ff ff 5a 5a 5a 5a 5a 5a 5a 5a %=
=2E..=B4C=FF=FFZZZZZZZZ
  Object 0xddba7400:  6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5 k=
kkkkkkkkkkkkkk=A5
 Redzone 0xddba7410:  bb bb bb bb                                     =BB=
=BB=BB=BB           =20
 Padding 0xddba7438:  5a 5a 5a 5a 5a 5a 5a 5a                         Z=
ZZZZZZZ       =20
Pid: 4650, comm: modprobe Not tainted 2.6.27-rc5-00132-gb380b0d #8
 [<c016cf7e>] print_trailer+0xca/0x105
 [<c016d09e>] object_err+0x31/0x39
 [<c016db93>] __slab_free+0x1aa/0x320
 [<c016e74d>] kfree+0x85/0xee
 [<c01e3562>] ? kobject_set_name_vargs+0x3a/0x42
 [<c01e3562>] ? kobject_set_name_vargs+0x3a/0x42
 [<c01e3562>] kobject_set_name_vargs+0x3a/0x42
 [<c01e3585>] kobject_add_varg+0x1b/0x4d
 [<c01e35e1>] kobject_init_and_add+0x2a/0x30
 [<c01df89c>] blk_register_filter+0x4b/0x5a
 [<de839310>] ide_cd_probe+0x289/0x5ae [ide_cd_mod]
 [<c01aad99>] ? sysfs_addrm_start+0x65/0x90
 [<c01aba69>] ? sysfs_do_create_link+0x9a/0x11c
 [<c024f7a0>] generic_ide_probe+0x1f/0x21
 [<c024a672>] driver_probe_device+0x77/0x15b
 [<c02c8bdb>] ? _spin_unlock_irqrestore+0x39/0x60
 [<c024a7b6>] __driver_attach+0x60/0x62
 [<c0249e2a>] bus_for_each_dev+0x44/0x62
 [<c024f7a2>] ? generic_ide_remove+0x0/0x1e
 [<c024a51d>] driver_attach+0x19/0x1b
 [<c024a756>] ? __driver_attach+0x0/0x62
 [<c024a318>] bus_add_driver+0x1ae/0x216
 [<c024f7a2>] ? generic_ide_remove+0x0/0x1e
 [<c024a901>] driver_register+0x4f/0x118
 [<dee3500d>] ide_cdrom_init+0xd/0xf [ide_cd_mod]
 [<c010111a>] do_one_initcall+0x2a/0x14c
 [<c0108560>] ? native_sched_clock+0x58/0xa1
 [<dee35000>] ? ide_cdrom_init+0x0/0xf [ide_cd_mod]
 [<c013d042>] ? trace_hardirqs_on+0xb/0xd
 [<c013cfaf>] ? trace_hardirqs_on_caller+0xac/0x134
 [<c0147083>] sys_init_module+0x7e/0x19f
 [<c013cfaf>] ? trace_hardirqs_on_caller+0xac/0x134
 [<c01e8144>] ? trace_hardirqs_on_thunk+0xc/0x10
 [<c0103035>] sysenter_do_call+0x12/0x35
 [<c012007b>] ? put_fs_struct+0x5/0x2e
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=46IX kmalloc-16: Object at 0xddba7400 not freed

	Mariusz
