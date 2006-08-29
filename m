From: Tejun Heo <htejun@gmail.com>
Subject: Re: Libata-tj-stable patch /w sil3124 and PMP... 'device or	resource
 busy'
Date: Tue, 29 Aug 2006 11:55:39 +0900
Message-ID: <44F3ACAB.5070506@gmail.com>
References: <44E105A7.3030900@grokthis.net> <44E1C43E.1020302@gmail.com>	 <44E28313.7050601@grokthis.net>  <44F16750.5080100@gmail.com> <1156727790.28709.1.camel@lennon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.226]:21043 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932116AbWH2Czq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Aug 2006 22:55:46 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1906449wxc
        for <linux-ide@vger.kernel.org>; Mon, 28 Aug 2006 19:55:45 -0700 (PDT)
In-Reply-To: <1156727790.28709.1.camel@lennon>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eric Windisch <eric@grokthis.net>
Cc: linux-ide@vger.kernel.org

Hello, there.

Eric Windisch wrote:
<--snip-->
> [4294682.866000] XXX bd_claim 3:2/3:0 1@c0406572 1@c0162830
> [4294682.866000]  <c01628d6> bd_claim+0xa6/0x130  <c0162830> bd_claim+0x0/0x130
> [4294682.867000]  <c0163001> bd_claim_by_disk+0x91/0x1b0  <c0314615> open_dev+0x55/0xa0
> [4294682.867000]  <c03153fd> dm_get_device+0x19d/0x470  <c0233fd7> vsscanf+0x4b7/0x530
> [4294682.867000]  <c0315fcf> linear_ctr+0xaf/0x130  <c0314f4b> dm_table_add_target+0x17b/0x2f0
> [4294682.867000]  <c0317e6f> table_load+0xff/0x220  <c0317371> ctl_ioctl+0x1c1/0x2e0
> [4294682.868000]  <c0317d70> table_load+0x0/0x220  <c016e176> do_ioctl+0x76/0x80
> [4294682.868000]  <c016e1d2> vfs_ioctl+0x52/0x2c0  <c016e4c8> sys_ioctl+0x88/0xa0
> [4294682.868000]  <c0102c33> syscall_call+0x7/0xb 
> [4294682.941000] XXX bd_claim 3:2/3:0 2@c0406572 2@c0162830
> [4294682.941000]  <c01628d6> bd_claim+0xa6/0x130  <c0162830> bd_claim+0x0/0x130
> [4294682.941000]  <c0163001> bd_claim_by_disk+0x91/0x1b0  <c0314615> open_dev+0x55/0xa0
> [4294682.942000]  <c03153fd> dm_get_device+0x19d/0x470  <c0233fd7> vsscanf+0x4b7/0x530
> [4294682.942000]  <c0315fcf> linear_ctr+0xaf/0x130  <c0314f4b> dm_table_add_target+0x17b/0x2f0
> [4294682.942000]  <c0317e6f> table_load+0xff/0x220  <c0317371> ctl_ioctl+0x1c1/0x2e0
> [4294682.942000]  <c0317d70> table_load+0x0/0x220  <c016e176> do_ioctl+0x76/0x80
> [4294682.943000]  <c016e1d2> vfs_ioctl+0x52/0x2c0  <c016e4c8> sys_ioctl+0x88/0xa0
> [4294682.943000]  <c0102c33> syscall_call+0x7/0xb 
> [4294683.015000] XXX bd_claim 3:2/3:0 3@c0406572 3@c0162830
> [4294683.016000]  <c01628d6> bd_claim+0xa6/0x130  <c0162830> bd_claim+0x0/0x130
> [4294683.016000]  <c0163001> bd_claim_by_disk+0x91/0x1b0  <c0314615> open_dev+0x55/0xa0
> [4294683.016000]  <c03153fd> dm_get_device+0x19d/0x470  <c0233fd7> vsscanf+0x4b7/0x530
> [4294683.016000]  <c0315fcf> linear_ctr+0xaf/0x130  <c0314f4b> dm_table_add_target+0x17b/0x2f0
> [4294683.017000]  <c0317e6f> table_load+0xff/0x220  <c0317371> ctl_ioctl+0x1c1/0x2e0
> [4294683.017000]  <c0317d70> table_load+0x0/0x220  <c016e176> do_ioctl+0x76/0x80
> [4294683.017000]  <c016e1d2> vfs_ioctl+0x52/0x2c0  <c016e4c8> sys_ioctl+0x88/0xa0
> [4294683.017000]  <c0102c33> syscall_call+0x7/0xb 

/dev/hda2 is exclusively opened three times by dm.

> [4294683.087000] Attempting manual resume
> [4294683.115000] XXX bd_claim 253:0/253:0 2@c0442a60 2@c0442a60
> [4294683.115000]  <c01628d6> bd_claim+0xa6/0x130  <c0163ae5> open_bdev_excl+0x65/0x90
> [4294683.115000]  <c01623af> get_sb_bdev+0x2f/0x15a  <c01422a3> __alloc_pages+0x53/0x310
> [4294683.115000]  <c01deab0> ext3_get_sb+0x30/0x40  <c01e0a60> ext3_fill_super+0x0/0x17f0
> [4294683.116000]  <c0161af9> do_kern_mount+0xd9/0x190  <c0178f09> do_mount+0x3f9/0x770
> [4294683.116000]  <c014a418> __handle_mm_fault+0x678/0x830  <c016b7bb> do_path_lookup+0x8b/0x200
> [4294683.116000]  <c0168f3f> getname+0xdf/0x110  <c01422a3> __alloc_pages+0x53/0x310
> [4294683.117000]  <c0113b30> do_page_fault+0x0/0x701  <c01427ee> __get_free_pages+0x1e/0x50
> [4294683.118000]  <c0177b68> copy_mount_options+0x48/0x160  <c0179318> sys_mount+0x98/0xe0
> [4294683.118000]  <c0102c33> syscall_call+0x7/0xb 

Hmmm... maybe, created dm device being mounted.

<--snip-->
> [4294694.160000] XXX bd_claim 253:2/253:2 2@c01525b0 2@c01525b0
> [4294694.160000]  <c01628d6> bd_claim+0xa6/0x130  <c01525b0> sys_swapon+0x0/0xb50
> [4294694.161000]  <c01525b0> sys_swapon+0x0/0xb50  <c01528c2> sys_swapon+0x312/0xb50
> [4294694.161000]  <c01525b0> sys_swapon+0x0/0xb50  <c0113c67> do_page_fault+0x137/0x701
> [4294694.161000]  <c0102bcb> sysenter_past_esp+0x54/0x75 

Swap on the dm device (right?)

> [4294705.726000] XXX bd_claim 3:0 failed 3@c0162830
> [4294705.726000] device-mapper: dm-linear: Device lookup failed
> [4294705.726000] device-mapper: error adding target to table
> [4294705.728000] XXX bd_claim 3:0 failed 3@c0162830
> [4294705.728000] device-mapper: dm-linear: Device lookup failed
> [4294705.728000] device-mapper: error adding target to table
> [4294705.730000] XXX bd_claim 3:0 failed 3@c0162830
> [4294705.730000] device-mapper: dm-linear: Device lookup failed
> [4294705.731000] device-mapper: error adding target to table
> [4294705.733000] XXX bd_claim 3:0 failed 3@c0162830
> [4294705.733000] device-mapper: dm-linear: Device lookup failed
> [4294705.733000] device-mapper: error adding target to table

hda is already grabbed.  dm is trying to open the device exclusively 
again with a different id, which is correctly denied.  Is this normal 
behavior?

> [4294705.735000] XXX bd_claim 8:0/8:0 2@c0406572 2@c0406572
> [4294705.735000]  <c01628d6> bd_claim+0xa6/0x130  <c0163001> bd_claim_by_disk+0x91/0x1b0
> [4294705.735000]  <c0314615> open_dev+0x55/0xa0  <c03153fd> dm_get_device+0x19d/0x470
> [4294705.736000]  <c0233fd7> vsscanf+0x4b7/0x530  <c0315fcf> linear_ctr+0xaf/0x130
> [4294705.736000]  <c0314f4b> dm_table_add_target+0x17b/0x2f0  <c0317e6f> table_load+0xff/0x220
> [4294705.736000]  <c0317371> ctl_ioctl+0x1c1/0x2e0  <c013f305> __generic_file_aio_write_nolock+0x285/0x490
> [4294705.737000]  <c0317d70> table_load+0x0/0x220  <c016e176> do_ioctl+0x76/0x80
> [4294705.737000]  <c016e1d2> vfs_ioctl+0x52/0x2c0  <c016e4c8> sys_ioctl+0x88/0xa0
> [4294705.737000]  <c0102bcb> sysenter_past_esp+0x54/0x75 
> [4294705.740000] XXX bd_claim 8:16/8:16 2@c0406572 2@c0406572
> [4294705.740000]  <c01628d6> bd_claim+0xa6/0x130  <c0163001> bd_claim_by_disk+0x91/0x1b0
> [4294705.740000]  <c0314615> open_dev+0x55/0xa0  <c03153fd> dm_get_device+0x19d/0x470
> [4294705.740000]  <c0233fd7> vsscanf+0x4b7/0x530  <c0315fcf> linear_ctr+0xaf/0x130
> [4294705.741000]  <c0314f4b> dm_table_add_target+0x17b/0x2f0  <c0317e6f> table_load+0xff/0x220
> [4294705.741000]  <c0317371> ctl_ioctl+0x1c1/0x2e0  <c0173b33> dput+0x93/0x140
> [4294705.741000]  <c0317d70> table_load+0x0/0x220  <c016e176> do_ioctl+0x76/0x80
> [4294705.742000]  <c016e1d2> vfs_ioctl+0x52/0x2c0  <c016e4c8> sys_ioctl+0x88/0xa0
> [4294705.742000]  <c0102bcb> sysenter_past_esp+0x54/0x75 
> [4294705.745000] XXX bd_claim 8:32/8:32 2@c0406572 2@c0406572
> [4294705.745000]  <c01628d6> bd_claim+0xa6/0x130  <c0163001> bd_claim_by_disk+0x91/0x1b0
> [4294705.745000]  <c0314615> open_dev+0x55/0xa0  <c03153fd> dm_get_device+0x19d/0x470
> [4294705.745000]  <c0233fd7> vsscanf+0x4b7/0x530  <c0315fcf> linear_ctr+0xaf/0x130
> [4294705.746000]  <c0314f4b> dm_table_add_target+0x17b/0x2f0  <c0317e6f> table_load+0xff/0x220
> [4294705.746000]  <c0317371> ctl_ioctl+0x1c1/0x2e0  <c0173b33> dput+0x93/0x140
> [4294705.746000]  <c0317d70> table_load+0x0/0x220  <c016e176> do_ioctl+0x76/0x80
> [4294705.746000]  <c016e1d2> vfs_ioctl+0x52/0x2c0  <c016e4c8> sys_ioctl+0x88/0xa0
> [4294705.747000]  <c0102bcb> sysenter_past_esp+0x54/0x75 
> [4294705.749000] XXX bd_claim 8:48/8:48 2@c0406572 2@c0406572
> [4294705.749000]  <c01628d6> bd_claim+0xa6/0x130  <c0163001> bd_claim_by_disk+0x91/0x1b0
> [4294705.750000]  <c0314615> open_dev+0x55/0xa0  <c03153fd> dm_get_device+0x19d/0x470
> [4294705.750000]  <c0233fd7> vsscanf+0x4b7/0x530  <c0315fcf> linear_ctr+0xaf/0x130
> [4294705.750000]  <c0314f4b> dm_table_add_target+0x17b/0x2f0  <c0317e6f> table_load+0xff/0x220
> [4294705.751000]  <c0317371> ctl_ioctl+0x1c1/0x2e0  <c0173b33> dput+0x93/0x140
> [4294705.751000]  <c0317d70> table_load+0x0/0x220  <c016e176> do_ioctl+0x76/0x80
> [4294705.751000]  <c016e1d2> vfs_ioctl+0x52/0x2c0  <c016e4c8> sys_ioctl+0x88/0xa0
> [4294705.751000]  <c0102bcb> sysenter_past_esp+0x54/0x75 
> [4294705.754000] XXX bd_claim 8:64/8:64 2@c0406572 2@c0406572
> [4294705.754000]  <c01628d6> bd_claim+0xa6/0x130  <c0163001> bd_claim_by_disk+0x91/0x1b0
> [4294705.755000]  <c0314615> open_dev+0x55/0xa0  <c03153fd> dm_get_device+0x19d/0x470
> [4294705.755000]  <c0233fd7> vsscanf+0x4b7/0x530  <c0315fcf> linear_ctr+0xaf/0x130
> [4294705.755000]  <c0314f4b> dm_table_add_target+0x17b/0x2f0  <c0317e6f> table_load+0xff/0x220
> [4294705.755000]  <c0317371> ctl_ioctl+0x1c1/0x2e0  <c0173b33> dput+0x93/0x140
> [4294705.756000]  <c0317d70> table_load+0x0/0x220  <c016e176> do_ioctl+0x76/0x80
> [4294705.756000]  <c016e1d2> vfs_ioctl+0x52/0x2c0  <c016e4c8> sys_ioctl+0x88/0xa0
> [4294705.756000]  <c0102bcb> sysenter_past_esp+0x54/0x75 

Here, all the SCSI disks are claimed exclusively by dm.

<--snip-->

The exclusive refs held above are never released.  Thus the kernel 
correctly denies any other exclusive access to the devices.  dm is 
holding them all.  I have never used dm so don't know much about it.  It 
seems that you'll have to make dm ignore those SCSI disks if you wanna 
use them for any other purpose.

-- 
tejun
