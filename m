Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB93C433DB
	for <linux-ide@archiver.kernel.org>; Wed,  3 Feb 2021 12:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D89F64F74
	for <linux-ide@archiver.kernel.org>; Wed,  3 Feb 2021 12:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbhBCMXV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 3 Feb 2021 07:23:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:46968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232525AbhBCMXT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 3 Feb 2021 07:23:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1859AB174;
        Wed,  3 Feb 2021 12:22:37 +0000 (UTC)
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org
Subject: Lock inversion in ata_piix
Message-ID: <f763098b-10e1-8825-84ea-1e4cb3c3c0ba@suse.de>
Date:   Wed, 3 Feb 2021 13:22:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uqf9FRpp0U7sEXkuUQApj0XZNbFEiVRpB"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uqf9FRpp0U7sEXkuUQApj0XZNbFEiVRpB
Content-Type: multipart/mixed; boundary="jhXnfSPc9nc6n23FwK7HkBdBezPk7dggi";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: axboe@kernel.dk
Cc: linux-ide@vger.kernel.org
Message-ID: <f763098b-10e1-8825-84ea-1e4cb3c3c0ba@suse.de>
Subject: Lock inversion in ata_piix

--jhXnfSPc9nc6n23FwK7HkBdBezPk7dggi
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

there's a possible lock inversion reported during boot-up. The rsp=20
driver is ata_piix. The full error is below.

Best regards
Thomas


[   15.782834] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   15.789912] WARNING: possible irq lock inversion dependency detected
[   15.789915] 5.11.0-rc5-1-default+ #752 Tainted: G            E
[   15.789918] --------------------------------------------------------
[   15.789919] loadkeys/347 just changed the state of lock:
[   15.789922] ffff88810c289c18 (&host->lock){-...}-{2:2}, at:=20
ata_bmdma_interrupt+0x22/0x2f0
[   15.789938] but this lock took another, HARDIRQ-READ-unsafe lock in=20
the past:
[   15.789940]  (&trig->leddev_list_lock){.+.?}-{2:2}
[   15.834024]
[   15.834024]
[   15.834024] and interrupts could create inverse lock ordering between =

them.
[   15.834024]
[   15.834028]
[   15.834028] other info that might help us debug this:
[   15.834029]  Possible interrupt unsafe locking scenario:
[   15.834029]
[   15.834031]        CPU0                    CPU1
[   15.834032]        ----                    ----
[   15.834033]   lock(&trig->leddev_list_lock);
[   15.834037]                                local_irq_disable();
[   15.834038]                                lock(&host->lock);
[   15.834041]                                lock(&trig->leddev_list_loc=
k);
[   15.834044]   <Interrupt>
[   15.834045]     lock(&host->lock);
[   15.834048]
[   15.834048]  *** DEADLOCK ***
[   15.834048]
[   15.834049] no locks held by loadkeys/347.
[   15.834051]
[   15.834051] the shortest dependencies between 2nd lock and 1st lock:
[   15.834064]  -> (&trig->leddev_list_lock){.+.?}-{2:2} {
[   15.834071]     HARDIRQ-ON-R at:
[   15.834074]                       __lock_acquire+0x2d7/0x930
[   15.834081]                       lock_acquire.part.0+0xf7/0x1e0
[   15.834085]                       _raw_read_lock+0x3d/0xa0
[   15.834090]                       led_trigger_event+0x25/0x80
[   15.834095]                       kbd_bh+0xd1/0x100
[   15.834100]=20
tasklet_action_common.constprop.0+0x1b1/0x1d0
[   15.834105]                       __do_softirq+0x108/0x554
[   15.834109]                       run_ksoftirqd+0x3a/0x60
[   15.834112]                       smpboot_thread_fn+0x1b7/0x300
[   15.834115]                       kthread+0x1e4/0x210
[   15.834119]                       ret_from_fork+0x22/0x30
[   15.834124]     IN-SOFTIRQ-R at:
[   15.834126]                       __lock_acquire+0x2d7/0x930
[   15.834130]                       lock_acquire.part.0+0xf7/0x1e0
[   15.834133]                       _raw_read_lock+0x3d/0xa0
[   15.834137]                       led_trigger_event+0x25/0x80
[   15.834141]                       kbd_bh+0xd1/0x100
[   15.834144]=20
tasklet_action_common.constprop.0+0x1b1/0x1d0
[   15.834148]                       __do_softirq+0x108/0x554
[   15.834151]                       run_ksoftirqd+0x3a/0x60
[   15.834154]                       smpboot_thread_fn+0x1b7/0x300
[   15.834157]                       kthread+0x1e4/0x210
[   15.834160]                       ret_from_fork+0x22/0x30
[   15.834164]     SOFTIRQ-ON-R at:
[   15.834166]                       __lock_acquire+0x2d7/0x930
[   15.834169]                       lock_acquire.part.0+0xf7/0x1e0
[   15.834173]                       _raw_read_lock+0x3d/0xa0
[   15.834177]                       led_trigger_event+0x25/0x80
[   15.834181]                       ledtrig_cpu+0xb1/0x110
[   15.834184]                       ledtrig_online_cpu+0xf/0x20
[   15.834188]                       cpuhp_invoke_callback+0xf9/0x5b0
[   15.834193]                       cpuhp_thread_fun+0x237/0x330
[   15.834197]                       smpboot_thread_fn+0x1b7/0x300
[   15.834200]                       kthread+0x1e4/0x210
[   15.834203]                       ret_from_fork+0x22/0x30
[   15.834207]     INITIAL USE at:
[   15.834209]                      __lock_acquire+0x2d7/0x930
[   15.834213]                      lock_acquire.part.0+0xf7/0x1e0
[   15.834216]                      _raw_write_lock_irqsave+0x4d/0x90
[   15.834221]                      led_trigger_set+0x224/0x470
[   15.834225]                      led_trigger_set_default.part.0+0xd1/0=
xf0
[   15.834229]                      led_classdev_register_ext+0x37a/0x440=

[   15.834233]                      input_leds_connect+0x1e6/0x380
[   15.834236]                      input_attach_handler+0xb1/0xd0
[   15.834241]                      input_register_device.cold+0xd0/0x192=

[   15.834245]                      atkbd_connect+0x3bb/0x460
[   15.834248]                      serio_driver_probe+0x56/0x70
[   15.834252]                      really_probe+0x185/0x6c0
[   15.834255]                      driver_probe_device+0x13f/0x1d0
[   15.834259]                      device_driver_attach+0x114/0x120
[   15.834262]                      __driver_attach+0xb0/0x1a0
[   15.834265]                      bus_for_each_dev+0xdd/0x120
[   15.834269]                      serio_handle_event+0x18f/0x3f0
[   15.834273]                      process_one_work+0x571/0xa40
[   15.834277]                      worker_thread+0x8b/0x620
[   15.834280]                      kthread+0x1e4/0x210
[   15.834283]                      ret_from_fork+0x22/0x30
[   15.834287]     INITIAL READ USE at:
[   15.834289]                           __lock_acquire+0x2d7/0x930
[   15.834292]                           lock_acquire.part.0+0xf7/0x1e0
[   15.834296]                           _raw_read_lock+0x3d/0xa0
[   15.834300]                           led_trigger_event+0x25/0x80
[   15.834304]                           kbd_bh+0xd1/0x100
[   15.834307]=20
tasklet_action_common.constprop.0+0x1b1/0x1d0
[   15.834311]                           __do_softirq+0x108/0x554
[   15.834314]                           run_ksoftirqd+0x3a/0x60
[   15.834318]                           smpboot_thread_fn+0x1b7/0x300
[   15.834321]                           kthread+0x1e4/0x210
[   15.834323]                           ret_from_fork+0x22/0x30
[   15.834327]   }
[   15.834328]   ... key      at: [<ffffffff962167c0>] __key.0+0x0/0x40
[   15.834334]   ... acquired at:
[   15.834335]    __lock_acquire+0x54f/0x930
[   15.834339]    lock_acquire.part.0+0xf7/0x1e0
[   15.834342]    _raw_read_lock+0x3d/0xa0
[   15.834346]    led_trigger_blink_oneshot+0x34/0x90
[   15.834350]    ledtrig_disk_activity+0x67/0xc0
[   15.834354]    ata_qc_complete+0x3b/0x6d0
[   15.834357]    ata_sff_hsm_move+0x226/0x690
[   15.834361]    ata_sff_pio_task+0x265/0x290
[   15.834365]    process_one_work+0x571/0xa40
[   15.834368]    worker_thread+0x8b/0x620
[   15.834372]    kthread+0x1e4/0x210
[   15.834374]    ret_from_fork+0x22/0x30
[   15.834378]
[   15.834379] -> (&host->lock){-...}-{2:2} {
[   15.834385]    IN-HARDIRQ-W at:
[   15.834387]                     __lock_acquire+0x2d7/0x930
[   15.834391]                     lock_acquire.part.0+0xf7/0x1e0
[   15.834394]                     _raw_spin_lock_irqsave+0x4d/0x90
[   15.834398]                     ata_bmdma_interrupt+0x22/0x2f0
[   15.834402]                     __handle_irq_event_percpu+0x176/0x410
[   15.834406]                     handle_irq_event+0xb1/0x140
[   15.834409]                     handle_fasteoi_irq+0x100/0x390
[   15.834413]                     asm_call_irq_on_stack+0x12/0x20
[   15.834416]                     common_interrupt+0xee/0x190
[   15.834421]                     asm_common_interrupt+0x1e/0x40
[   15.834424]                     __orc_find+0x39/0xc0
[   15.834428]                     unwind_next_frame+0x107/0xa20
[   15.834431]                     arch_stack_walk+0x6c/0xb0
[   15.834435]                     stack_trace_save+0x81/0xa0
[   15.834439]                     kasan_save_stack+0x1b/0x40
[   15.834443]                     ____kasan_kmalloc.constprop.0+0x81/0xa=
0
[   15.834446]                     kmem_cache_alloc_trace+0x136/0x310
[   15.834451]                     vt_kdskbent+0x78/0x300
[   15.834455]                     vt_do_kdsk_ioctl+0xe5/0x1e0
[   15.834459]                     vt_k_ioctl+0x4dd/0x6f0
[   15.834462]                     vt_ioctl+0xc5/0x850
[   15.834465]                     tty_ioctl+0x472/0xab0
[   15.834471]                     __x64_sys_ioctl+0xb9/0xf0
[   15.834475]                     do_syscall_64+0x33/0x80
[   15.834478]                     entry_SYSCALL_64_after_hwframe+0x44/0x=
a9
[   15.834483]    INITIAL USE at:
[   15.834485]                    __lock_acquire+0x2d7/0x930
[   15.834489]                    lock_acquire.part.0+0xf7/0x1e0
[   15.834492]                    _raw_spin_lock_irqsave+0x4d/0x90
[   15.834496]                    ata_dev_init+0xb3/0x170
[   15.834500]                    ata_link_init+0xc7/0x140
[   15.834503]                    ata_port_alloc+0x2e7/0x300
[   15.834506]                    ata_host_alloc+0x136/0x180
[   15.834510]                    ata_host_alloc_pinfo+0x1e/0x190
[   15.834513]                    ata_pci_sff_prepare_host+0x3c/0xa0
[   15.834517]                    ata_pci_bmdma_prepare_host+0x10/0x30
[   15.834520]                    piix_init_one+0x47b/0x681 [ata_piix]
[   15.834532]                    local_pci_probe+0x74/0xc0
[   15.834535]                    pci_call_probe+0xb7/0x1d0
[   15.834538]                    pci_device_probe+0x102/0x140
[   15.834541]                    really_probe+0x185/0x6c0
[   15.834544]                    driver_probe_device+0x13f/0x1d0
[   15.834547]                    device_driver_attach+0x114/0x120
[   15.834550]                    __driver_attach+0xb0/0x1a0
[   15.834553]                    bus_for_each_dev+0xdd/0x120
[   15.834557]                    bus_add_driver+0x1fb/0x2e0
[   15.834560]                    driver_register+0x103/0x180
[   15.834563]                    piix_init+0x1f/0x1000 [ata_piix]
[   15.834572]                    do_one_initcall+0xbb/0x3a0
[   15.834576]                    do_init_module+0xfd/0x3c0
[   15.834580]                    load_module+0xbef/0xc70
[   15.834584]                    __do_sys_finit_module+0xff/0x180
[   15.834588]                    do_syscall_64+0x33/0x80
[   15.834591]                    entry_SYSCALL_64_after_hwframe+0x44/0xa=
9
[   15.834595]  }
[   15.834597]  ... key      at: [<ffffffff9620bec0>] __key.5+0x0/0x40
[   15.834601]  ... acquired at:
[   15.834603]    mark_lock_irq+0x151/0x360
[   15.834606]    mark_lock+0x309/0x4f0
[   15.834609]    mark_usage+0x185/0x1a0
[   15.834612]    __lock_acquire+0x2d7/0x930
[   15.834615]    lock_acquire.part.0+0xf7/0x1e0
[   15.834618]    _raw_spin_lock_irqsave+0x4d/0x90
[   15.834622]    ata_bmdma_interrupt+0x22/0x2f0
[   15.834626]    __handle_irq_event_percpu+0x176/0x410
[   15.834629]    handle_irq_event+0xb1/0x140
[   15.834632]    handle_fasteoi_irq+0x100/0x390
[   15.834635]    asm_call_irq_on_stack+0x12/0x20
[   15.834639]    common_interrupt+0xee/0x190
[   15.834642]    asm_common_interrupt+0x1e/0x40
[   15.834645]    __orc_find+0x39/0xc0
[   15.834648]    unwind_next_frame+0x107/0xa20
[   15.834651]    arch_stack_walk+0x6c/0xb0
[   15.834654]    stack_trace_save+0x81/0xa0
[   15.834657]    kasan_save_stack+0x1b/0x40
[   15.834660]    ____kasan_kmalloc.constprop.0+0x81/0xa0
[   15.834663]    kmem_cache_alloc_trace+0x136/0x310
[   15.834667]    vt_kdskbent+0x78/0x300
[   15.834670]    vt_do_kdsk_ioctl+0xe5/0x1e0
[   15.834674]    vt_k_ioctl+0x4dd/0x6f0
[   15.834677]    vt_ioctl+0xc5/0x850
[   15.834680]    tty_ioctl+0x472/0xab0
[   15.834684]    __x64_sys_ioctl+0xb9/0xf0
[   15.834687]    do_syscall_64+0x33/0x80
[   15.834690]    entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   15.834695]
[   15.834695]
[   15.834695] stack backtrace:
[   15.834697] CPU: 1 PID: 347 Comm: loadkeys Tainted: G            E=20
   5.11.0-rc5-1-default+ #752
[   15.834702] Hardware name: HP ProLiant DL120 G7, BIOS J01 04/21/2011
[   15.834705] Call Trace:
[   15.834707]  <IRQ>
[   15.834709]  dump_stack+0xae/0xe5
[   15.834715]  check_usage_forwards.cold+0x1f/0x4e
[   15.834722]  ? check_usage_backwards+0x2b0/0x2b0
[   15.834727]  ? stack_trace_save+0x81/0xa0
[   15.834731]  ? jhash.constprop.0+0x1e3/0x260
[   15.834737]  mark_lock_irq+0x151/0x360
[   15.834742]  mark_lock+0x309/0x4f0
[   15.834746]  mark_usage+0x185/0x1a0
[   15.834751]  __lock_acquire+0x2d7/0x930
[   15.834756]  ? check_prev_add+0x11e0/0x11e0
[   15.834760]  lock_acquire.part.0+0xf7/0x1e0
[   15.834764]  ? ata_bmdma_interrupt+0x22/0x2f0
[   15.834769]  ? rcu_read_unlock+0x40/0x40
[   15.834773]  ? lock_is_held_type+0xdc/0x110
[   15.834792]  ? rcu_read_lock_sched_held+0x3f/0x80
[   15.834797]  ? lock_acquire+0x74/0x190
[   15.834801]  ? ata_bmdma_interrupt+0x22/0x2f0
[   15.834806]  _raw_spin_lock_irqsave+0x4d/0x90
[   15.834811]  ? ata_bmdma_interrupt+0x22/0x2f0
[   15.834815]  ata_bmdma_interrupt+0x22/0x2f0
[   15.834819]  ? lock_is_held_type+0xdc/0x110
[   15.834824]  ? ata_bmdma_port_intr+0x180/0x180
[   15.834829]  __handle_irq_event_percpu+0x176/0x410
[   15.834834]  handle_irq_event+0xb1/0x140
[   15.834838]  ? handle_irq_event_percpu+0xd0/0xd0
[   15.834842]  ? handle_fasteoi_irq+0x4d/0x390
[   15.834847]  handle_fasteoi_irq+0x100/0x390
[   15.834853]  asm_call_irq_on_stack+0x12/0x20
[   15.834857]  </IRQ>
[   15.834858]  common_interrupt+0xee/0x190
[   15.834863]  asm_common_interrupt+0x1e/0x40
[   15.834867] RIP: 0010:__orc_find+0x39/0xc0
[   15.834871] Code: 6c 97 fc 41 54 55 53 48 83 ec 08 48 89 34 24 85 d2=20
74 7d 49 89 fc 4c 39 ef 0f 87 82 00 00 00 48 89 cb 48 89 fd 49 89 ff eb=20
0c <4d> 8d 7e 04 4c 89 f5 4d 39 fd 72 37 4c 89 e8 4c 29 f8 48 89 c1 48
[   15.834875] RSP: 0018:ffffc9000304f720 EFLAGS: 00000202
[   15.834879] RAX: ffffffff91494573 RBX: ffffffff9149457a RCX:=20
dffffc0000000000
[   15.834882] RDX: 0000000000000007 RSI: ffffffff93e7301a RDI:=20
ffffffff93b820dc
[   15.834885] RBP: ffffffff93b820d8 R08: ffffffff910bbe28 R09:=20
ffffffff93debf3b
[   15.834888] R10: fffffbfff27bd7e7 R11: 0000000000000001 R12:=20
ffffffff93b82090
[   15.834890] R13: ffffffff93b820dc R14: ffffffff93b820dc R15:=20
ffffffff93b820dc
[   15.834894]  ? kasan_save_stack+0x1a/0x40
[   15.834898]  ? __orc_find+0x68/0xc0
[   15.834901]  ? kasan_save_stack+0x13/0x40
[   15.834908]  unwind_next_frame+0x107/0xa20
[   15.834912]  ? kasan_save_stack+0x1b/0x40
[   15.834915]  ? kasan_save_stack+0x1b/0x40
[   15.834919]  ? kasan_save_stack+0x1b/0x40
[   15.834922]  ? deref_stack_reg+0xb0/0xb0
[   15.834946]  ? __unwind_start.part.0+0x2c5/0x330
[   15.834949]  ? create_prof_cpu_mask+0x20/0x20
[   15.834954]  arch_stack_walk+0x6c/0xb0
[   15.834959]  ? kasan_save_stack+0x1b/0x40
[   15.834963]  stack_trace_save+0x81/0xa0
[   15.834967]  ? stack_trace_consume_entry+0x80/0x80
[   15.834971]  ? stack_trace_consume_entry+0x80/0x80
[   15.834975]  ? check_prev_add+0x11e0/0x11e0
[   15.834979]  kasan_save_stack+0x1b/0x40
[   15.834982]  ? kasan_save_stack+0x1b/0x40
[   15.834986]  ? __lock_acquire+0x572/0x930
[   15.834992]  ? lock_acquire.part.0+0xf7/0x1e0
[   15.834996]  ? sched_clock+0x5/0x10
[   15.835001]  ? sched_clock_cpu+0x18/0x110
[   15.835006]  ? __lock_release+0x12f/0x4f0
[   15.835011]  ? lock_downgrade+0xa0/0xa0
[   15.835014]  ? __lock_contended+0x490/0x490
[   15.835019]  ? cache_alloc_refill+0x2c8/0x310
[   15.835024]  ? do_raw_spin_unlock+0x86/0xf0
[   15.835029]  ? mark_held_locks+0x23/0x90
[   15.835033]  ? unpoison_range+0x3a/0x60
[   15.835037]  ____kasan_kmalloc.constprop.0+0x81/0xa0
[   15.835042]  kmem_cache_alloc_trace+0x136/0x310
[   15.835048]  vt_kdskbent+0x78/0x300
[   15.835053]  vt_do_kdsk_ioctl+0xe5/0x1e0
[   15.835058]  ? vt_do_kbkeycode_ioctl+0x230/0x230
[   15.835063]  ? check_prev_add+0x11e0/0x11e0
[   15.835067]  vt_k_ioctl+0x4dd/0x6f0
[   15.835071]  ? get_pid.part.0+0x50/0x50
[   15.835076]  ? apparmor_capable+0x9d/0x190
[   15.835081]  ? security_capable+0x4d/0x60
[   15.835086]  vt_ioctl+0xc5/0x850
[   15.835090]  ? complete_change_console+0x160/0x160
[   15.835096]  tty_ioctl+0x472/0xab0
[   15.835101]  ? tty_poll+0xd0/0xd0
[   15.835105]  ? lock_is_held_type+0xdc/0x110
[   15.835111]  ? do_vfs_ioctl+0x662/0x680
[   15.835115]  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
[   15.835119]  ? ioctl_fiemap.isra.0+0x1a0/0x1a0
[   15.835123]  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
[   15.835129]  __x64_sys_ioctl+0xb9/0xf0
[   15.835134]  do_syscall_64+0x33/0x80
[   15.835138]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   15.835143] RIP: 0033:0x7f79989113cb
[   15.835146] Code: 89 d8 49 8d 3c 1c 48 f7 d8 49 39 c4 72 b5 e8 1c ff=20
ff ff 85 c0 78 ba 4c 89 e0 5b 5d 41 5c c3 f3 0f 1e fa b8 10 00 00 00 0f=20
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 ba 0c 00 f7 d8 64 89 01 48
[   15.835149] RSP: 002b:00007ffec2615b58 EFLAGS: 00000246 ORIG_RAX:=20
0000000000000010
[   15.835153] RAX: ffffffffffffffda RBX: 000000000000004d RCX:=20
00007f79989113cb
[   15.835156] RDX: 00007ffec2615bac RSI: 0000000000004b47 RDI:=20
0000000000000003
[   15.835158] RBP: 000000000000004d R08: 0000000000000000 R09:=20
0000558170402830
[   15.835161] R10: 00005581703dfc30 R11: 0000000000000246 R12:=20
0000000000000208
[   15.835163] R13: 0000000000000041 R14: 0000000000000041 R15:=20
00005581707dc2f0



--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--jhXnfSPc9nc6n23FwK7HkBdBezPk7dggi--

--uqf9FRpp0U7sEXkuUQApj0XZNbFEiVRpB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAalYwFAwAAAAAACgkQlh/E3EQov+BW
MRAAno61Y1cT6aDalICBzj0dh9ieTjv6z0SDmpTXCILFLrozOiJzF09ESaTVdsGc9KMH+RQzwxLn
KlfQjelIoKvGLTCFAVupaclWe7kaD/wI1EOdTeKfRNXeU9i/kLAVltaPoraTONtizk6LaywBiLV7
pbX7Hk+oHFchceQ0sCtNdmhLFjxn8mtavtef7mjdy4eJVNFf9E7Ms6RG0Vxv5kQ5bFIp3brkJFi2
RmGw9so2kxMNgkC70qwJ7GrOT8MoJ/cwXgpEhZTc/MIgnkuS8SvhY0weRyLBzufkIykBXQKKLReF
pUwHnVxi3wtGr7JURryvRC7P6c/PP2NbHjw6fCI8RABpHeTlpwuiNWS5SEb/qlaSMXBKHDDtUo02
PAkUNxaZk7r8iWwYw6vc44h2o97HnNDb+i8IZ0GT2VttLVPGiITQxE4spKIxvyTNRdlOVRTS48Lb
JyfNoZzKFziSbBYiF/w7EhEyCMcw4gzesCstJs8vBSDJcyBtjyHUH8Oc2HC2xdE+Dag4w1wBGfjV
RWdyTWazV91n56UgzRwEiOSL365lUQzEWwD3FS/bDvPPxuFGtA8xfYuK/DSPUD2T8itne20MFli0
rrTLMs8LtyD4w6xxlfBh1TRB/vCAmE91ceXuxgd5Rg53UoGUOBitFMtw3Dogdikff+Qj07IIE3R0
CGk=
=Chg/
-----END PGP SIGNATURE-----

--uqf9FRpp0U7sEXkuUQApj0XZNbFEiVRpB--
