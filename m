Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566D7C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 24 Mar 2022 08:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242453AbiCXIOp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 24 Mar 2022 04:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244723AbiCXIOo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Mar 2022 04:14:44 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2999A1FCD0
        for <linux-ide@vger.kernel.org>; Thu, 24 Mar 2022 01:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648109592; x=1679645592;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C5vVWVB7/LFmRp2nM5VW2qNIB2apV1ZrEDVdwcEgN8M=;
  b=JoY1bM4MIYXGPIQlrbImlhbiEdxTRYvsYI3nnL2s6QxYG3T9fPXrFOBH
   RxhL5/Q2XfCpLOMAYpqjKzFvhoJDpB/Kff90x3MdymnKQ0tkBv9is+mGQ
   0wGCGnfOY4VBknyywALAfMCFme4PvWzEVm/lTXCViLs/OLAd6HOCQBZvy
   O+lCnMDn13N2TBf/mfagU44YmUzmQ8jZFAUXPb9Z5bCGxRF4DgUCFltf0
   mZ0CJfhzNmMGtl4OdNBcMJETOFmXwnXDv6Wsk97R1TasYLEJj4LWqoY/r
   VgohyeRhWpUAHQOx9nKg9/lY5DztYxTo7QnQDXXUcCTlTo+Y+eZusop91
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,206,1643644800"; 
   d="scan'208";a="200993320"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 16:13:01 +0800
IronPort-SDR: 4MlgvOyRNOy5MnW8GL02D3tyBUP5vpZDyOsJJmOY1d5AnC4JJnuhulPnhT3/Are0bdXcPiOn26
 PULc5hb4vf5PSfSuCdCEn8yqfpxLQiyPnyG+HNupDt8vy070sv6pw6TKRpMQm8rg6yYgoZfftS
 e2i/pTUvHZOJLBS/w+BqrLgaigHyre050Mvb7yjKP2Bxh1tbktmrSUUg0dXT15JocnVaq/l8Te
 6wqaUHiSxn6FOlcf/3HBj8bQx7aR5if0cj1GOPemtd/U8YN9iEbz/Kspi6ely/BfD3rjm4W1+O
 XiD6Q6hLwn766pkxoHPmR2I1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 00:43:59 -0700
IronPort-SDR: HO9Ka8MXdkBFU4wvH6biuAQO2nDEQUloW//cmIuChWJRCVQUjS6MzzJAGZeoZea5RZhgy+NlrB
 7L67Hiacx8L6xduDkCfktyAJVv3l0Jan65fbzaWDeHLCTcys6hlTRs6vf+/FjTto/lc9hA6jLD
 9vjJcbuv1pVYJvqhkmm42H+CWA+1plZhGlB5TbqlTsk1TnpxrykNnKJxqvVpySU5vSpvmh2SrX
 nicUorA12y8RH4tFqm10u5jFoky2fWaABkLsR2dKSCbGHuYnaKPYq+JYqHKKnV2XvVmG9aqOjB
 cc8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 01:13:02 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KPHz21VxCz1SVp0
        for <linux-ide@vger.kernel.org>; Thu, 24 Mar 2022 01:13:02 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648109581; x=1650701582; bh=C5vVWVB7/LFmRp2nM5VW2qNIB2apV1ZrEDV
        dwcEgN8M=; b=ti9qTwy2DuMKbUOLefuFcwIfvoeARpBHXC1KrQDUGuZ8tITBu6d
        PMcbuS+91n+MwsgzdgDGH4JAscQBOnZe5iJ+wsn9rykA6Vbau7F56mC6wakavSCJ
        oJPRO6tRslWs6TP5H2UPD6dT9++596N6Y08Uz/Fae1HtpQhYmxTn5GGPRHyJmEWA
        a/x4u2LVrhUNsztSuuto3IRtq9g2yAsxfBNOZiEuuqpI757JP/rxepx3bxD0Xk88
        7If9uv1I3S1faidEnK49HxHpxkgG3YnozzQEAeKVGZu6a/3SxZExMteLcO1Wa7nT
        uMCgQjRb7vDG+9xmJYq/+NGWngBKo/5GIiA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id S5MKXztBW5vG for <linux-ide@vger.kernel.org>;
        Thu, 24 Mar 2022 01:13:01 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KPHz05xvrz1Rvlx;
        Thu, 24 Mar 2022 01:13:00 -0700 (PDT)
Message-ID: <0d150c5d-03fc-38fe-274b-0c0261bdf775@opensource.wdc.com>
Date:   Thu, 24 Mar 2022 17:12:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCHv2 0/3] libata: sysfs naming
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>
References: <20220321145659.97150-1-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220321145659.97150-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/21/22 23:56, Hannes Reinecke wrote:
> Hi all,
> 
> here's my second attempt the align the libata object naming with sysfs.
> Key point is to introduce an 'ata' bus, which serves to collect all
> libata object (ata_port, ata_link, and ata_device).
> 
> To facilitate that the name of the 'ata_port' object changes from 'ata'
> to 'port'. To provide backwards compability I've added an additional
> class object for the ata_port with the name of 'ata'.
> This additional object can be disabled with the config option
> ATA_SYSFS_COMPAT.
> 
> As usual, comments and reviews are welcome.
> 
> Hannes Reinecke (3):
>   libata: sysfs naming option
>   libata: CONFIG_ATA_SYSFS_COMPAT
>   libata: sanitize PMP link naming
> 
>  drivers/ata/Kconfig            | 10 +++++++
>  drivers/ata/libata-transport.c | 55 ++++++++++++++++++++++++++++++----
>  include/linux/libata.h         | 54 ++++++++++-----------------------
>  3 files changed, 76 insertions(+), 43 deletions(-)
> 

Kasan is not happy at all when I do "rmmod ahci"...

[ 1657.438508] BUG: KASAN: double-free or invalid-free in
attribute_container_release+0x37/0x50
[ 1657.447070]
[ 1657.448597] CPU: 8 PID: 1597 Comm: rmmod Not tainted 5.17.0-libata+ #25
[ 1657.455314] Hardware name: Supermicro Super Server/X11DPL-i, BIOS 3.3
02/21/2020
[ 1657.462809] Call Trace:
[ 1657.465304]  <TASK>
[ 1657.467447]  dump_stack_lvl+0x45/0x59
[ 1657.471180]  print_address_description.constprop.0+0x1f/0x120
[ 1657.477021]  ? attribute_container_release+0x37/0x50
[ 1657.482060]  ? attribute_container_release+0x37/0x50
[ 1657.487108]  kasan_report_invalid_free+0x51/0x80
[ 1657.491802]  __kasan_slab_free+0xf4/0x110
[ 1657.495885]  ? attribute_container_release+0x37/0x50
[ 1657.500930]  kfree+0xca/0x210
[ 1657.503956]  attribute_container_release+0x37/0x50
[ 1657.508826]  device_release+0x98/0x200
[ 1657.512642]  kobject_put+0x139/0x410
[ 1657.516283]  ata_tport_delete+0x4a/0x60 [libata]
[ 1657.521015]  ata_host_detach+0x336/0x660 [libata]
[ 1657.525820]  ? kernfs_remove_by_name_ns+0x9a/0xe0
[ 1657.530615]  pci_device_remove+0x65/0x110
[ 1657.534696]  __device_release_driver+0x316/0x680
[ 1657.539398]  driver_detach+0x1ec/0x2d0
[ 1657.543217]  bus_remove_driver+0xe7/0x2d0
[ 1657.547293]  ? lock_is_held_type+0x98/0x110
[ 1657.551546]  pci_unregister_driver+0x26/0x250
[ 1657.555982]  __x64_sys_delete_module+0x2fd/0x510
[ 1657.560673]  ? free_module+0xaa0/0xaa0
[ 1657.564487]  ? __cond_resched+0x1c/0x90
[ 1657.568392]  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
[ 1657.573611]  ? syscall_enter_from_user_mode+0x21/0x70
[ 1657.578740]  ? trace_hardirqs_on+0x1c/0x110
[ 1657.583000]  do_syscall_64+0x35/0x80
[ 1657.586635]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1657.591765] RIP: 0033:0x7f4eb289d84b
[ 1657.595403] Code: 73 01 c3 48 8b 0d dd 75 0e 00 f7 d8 64 89 01 48 83 c8
ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05
<48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ad 75 0e 00 f7 d8 64 89 01 48
[ 1657.618085] RSP: 002b:00007fffa28f9158 EFLAGS: 00000206 ORIG_RAX:
00000000000000b0
[ 1657.627664] RAX: ffffffffffffffda RBX: 000055e1a7f54760 RCX:
00007f4eb289d84b
[ 1657.636822] RDX: 000000000000000a RSI: 0000000000000800 RDI:
000055e1a7f547c8
[ 1657.645965] RBP: 0000000000000000 R08: 0000000000000000 R09:
0000000000000000
[ 1657.655065] R10: 00007f4eb292eac0 R11: 0000000000000206 R12:
00007fffa28f93d0
[ 1657.664115] R13: 00007fffa28fa780 R14: 000055e1a7f542a0 R15:
000055e1a7f54760
[ 1657.673133]  </TASK>
[ 1657.677130]
[ 1657.680403] Allocated by task 183:
[ 1657.685577]  kasan_save_stack+0x1e/0x40
[ 1657.691152]  __kasan_kmalloc+0x7f/0xa0
[ 1657.696603]  kmem_cache_alloc_trace+0x1f9/0x470
[ 1657.702809]  ata_port_alloc+0x40/0x5a0 [libata]
[ 1657.709031]  ata_host_alloc+0x1ca/0x260 [libata]
[ 1657.715301]  ata_host_alloc_pinfo+0x1d/0x540 [libata]
[ 1657.721978]  ahci_init_one+0xc5b/0x1d40 [ahci]
[ 1657.728037]  local_pci_probe+0xc6/0x150
[ 1657.733487]  work_for_cpu_fn+0x4e/0xa0
[ 1657.738833]  process_one_work+0x7f0/0x1310
[ 1657.744509]  worker_thread+0x6e0/0xf70
[ 1657.749855]  kthread+0x28f/0x330
[ 1657.754665]  ret_from_fork+0x1f/0x30
[ 1657.759818]
[ 1657.762850] The buggy address belongs to the object at ffff8885e2ce0000
[ 1657.762850]  which belongs to the cache kmalloc-32k of size 32768
[ 1657.778757] The buggy address is located 15088 bytes inside of
[ 1657.778757]  32768-byte region [ffff8885e2ce0000, ffff8885e2ce8000)
[ 1657.794105] The buggy address belongs to the page:
[ 1657.800540] page:00000000ddc44957 refcount:1 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x5e2ce0
[ 1657.811675] head:00000000ddc44957 order:4 compound_mapcount:0
compound_pincount:0
[ 1657.820907] flags: 0x20000000010200(slab|head|node=0|zone=2)
[ 1657.828316] raw: 0020000000010200 ffffea0018392808 ffffea00178b3c08
ffff888100040200
[ 1657.837857] raw: 0000000000000000 ffff8885e2ce0000 0000000100000001
0000000000000000
[ 1657.847408] page dumped because: kasan: bad access detected
[ 1657.854796]
[ 1657.858067] Memory state around the buggy address:
[ 1657.864684]  ffff8885e2ce3980: 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00
[ 1657.873803]  ffff8885e2ce3a00: 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00
[ 1657.882884] >ffff8885e2ce3a80: 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00
[ 1657.891942]                                                              ^
[ 1657.900670]  ffff8885e2ce3b00: 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00
[ 1657.909774]  ffff8885e2ce3b80: 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00

And after that, doing "rmmod libata; modprobe libata", Things get really
bad...

[ 1820.226215] sysfs: cannot create duplicate filename '/bus/ata'

And then NULL pointer dereference oops.

My PMP setup also does not show the devices named devX.Y. I suspect this
is because my eSATA box supports FIS based switching. Even with that, the
eSATA box has 4 drives all connected behind one port/one link, but I still
see each device with its own port and link. Weird. Since I am not 100% up
to speed on how the PMP code works, I need to dig into it.



-- 
Damien Le Moal
Western Digital Research
