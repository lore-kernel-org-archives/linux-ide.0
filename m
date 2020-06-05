Return-Path: <SRS0=C8TE=7S=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D71C433E0
	for <linux-ide@archiver.kernel.org>; Fri,  5 Jun 2020 03:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A0FB20772
	for <linux-ide@archiver.kernel.org>; Fri,  5 Jun 2020 03:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MMVqqeLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgFEDPo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 4 Jun 2020 23:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFEDPo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 4 Jun 2020 23:15:44 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D847C08C5C0
        for <linux-ide@vger.kernel.org>; Thu,  4 Jun 2020 20:15:43 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e9so4452340pgo.9
        for <linux-ide@vger.kernel.org>; Thu, 04 Jun 2020 20:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=IwE1MVpfEWI/xmM2k5GbulwhzVRRt8jj+S+YNQHgDj4=;
        b=MMVqqeLjW3wogx82HPBYY3oGYxvgA4ZuVkddeXdeSzkNpsThtZwN/VNCklJsC6Jmkf
         Nu3yXGjRb7MnO3B/ZKw4NEZ/2Z4Oi6s4DFyNbfhrhIudgoiokTP5K6WBGX4dd6HYrPGH
         MMDUgFLBoMvNOohihGnsw2BqgeZFimYHXaoALiuB2W/T+/xRIaeiuPu9WTPE0QOIa/C5
         XSHHpDni1MLM9ZOpcRt28FJZMqrJNxSP5Nb3cm317khDGui5Pm7eGzOHZARXgUqky9Cp
         p3OQhfxcFxKIDn0QqgtjnoDLhzJeQq3Q4JU9iMF+ZhbE6OUkhenGDt5ZVXbtNHKjjysz
         HxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IwE1MVpfEWI/xmM2k5GbulwhzVRRt8jj+S+YNQHgDj4=;
        b=c0GUcN77KqoEU/XPGfRNEAEMbG/Ox5ptIFQ25oV7rElwvuXyZqNIhaKVsjwfcnavIK
         ScQwj8K3HTVqQwzE7MIL0bJ1jBglaAJwDW9EOQaYDuZWN1katB++VtmcuFhRTu2m0S3/
         kP5XMiaCe+7IxRzvIyfe827VCEf+sYy1xF+zELlC0ezlsVWAtZLXXBPCRI7POAH2PyNg
         HyqwhpVaZb2Xb3p1eQCnhyhmGayME8gW+2KsTKqqwBfrEf31zozvmNQEYTf+kKSxScS0
         ZwKc08Oy+SEvSRR2v5+6dlAuNocrZm+SsWq8yk91vFQWYwRgjLutBkvvvTYGH9hxeFCe
         wD+g==
X-Gm-Message-State: AOAM5317ugwVPMFeMxiFtrHjSX8y3hfyp/T93xyGkiud+2+JeDKshlwE
        P3HamsOTYKdhMmSt5Qc8VZi+B1LukUctMA==
X-Google-Smtp-Source: ABdhPJxQLEzYbW59XKBy/B9SvyhHz6iBcpPG0FNqp0Egs6gLqk0UJmL5ac3Gg2MBLmdA09w6QgzP5w==
X-Received: by 2002:a63:4555:: with SMTP id u21mr7273587pgk.127.1591326942724;
        Thu, 04 Jun 2020 20:15:42 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id k126sm5857279pfd.129.2020.06.04.20.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 20:15:42 -0700 (PDT)
Subject: Re: [PATCH v4] ata/libata: Fix usage of page address by page_address
 in ata_scsi_mode_select_xlat function
To:     Ye Bin <yebin10@huawei.com>, linux-ide@vger.kernel.org,
        hch@infradead.org, pbonzini@redhat.com
References: <20200605014149.107604-1-yebin10@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7149f1e6-8e31-a23a-49ec-418b43be6d33@kernel.dk>
Date:   Thu, 4 Jun 2020 21:15:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605014149.107604-1-yebin10@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/4/20 7:41 PM, Ye Bin wrote:
> BUG: KASAN: use-after-free in ata_scsi_mode_select_xlat+0x10bd/0x10f0
> drivers/ata/libata-scsi.c:4045
> Read of size 1 at addr ffff88803b8cd003 by task syz-executor.6/12621
> 
> CPU: 1 PID: 12621 Comm: syz-executor.6 Not tainted 4.19.95 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.10.2-1ubuntu1 04/01/2014
> Call Trace:
> __dump_stack lib/dump_stack.c:77 [inline]
> dump_stack+0xac/0xee lib/dump_stack.c:118
> print_address_description+0x60/0x223 mm/kasan/report.c:253
> kasan_report_error mm/kasan/report.c:351 [inline]
> kasan_report mm/kasan/report.c:409 [inline]
> kasan_report.cold+0xae/0x2d8 mm/kasan/report.c:393
> ata_scsi_mode_select_xlat+0x10bd/0x10f0 drivers/ata/libata-scsi.c:4045
> ata_scsi_translate+0x2da/0x680 drivers/ata/libata-scsi.c:2035
> __ata_scsi_queuecmd drivers/ata/libata-scsi.c:4360 [inline]
> ata_scsi_queuecmd+0x2e4/0x790 drivers/ata/libata-scsi.c:4409
> scsi_dispatch_cmd+0x2ee/0x6c0 drivers/scsi/scsi_lib.c:1867
> scsi_queue_rq+0xfd7/0x1990 drivers/scsi/scsi_lib.c:2170
> blk_mq_dispatch_rq_list+0x1e1/0x19a0 block/blk-mq.c:1186
> blk_mq_do_dispatch_sched+0x147/0x3d0 block/blk-mq-sched.c:108
> blk_mq_sched_dispatch_requests+0x427/0x680 block/blk-mq-sched.c:204
> __blk_mq_run_hw_queue+0xbc/0x200 block/blk-mq.c:1308
> __blk_mq_delay_run_hw_queue+0x3c0/0x460 block/blk-mq.c:1376
> blk_mq_run_hw_queue+0x152/0x310 block/blk-mq.c:1413
> blk_mq_sched_insert_request+0x337/0x6c0 block/blk-mq-sched.c:397
> blk_execute_rq_nowait+0x124/0x320 block/blk-exec.c:64
> blk_execute_rq+0xc5/0x112 block/blk-exec.c:101
> sg_scsi_ioctl+0x3b0/0x6a0 block/scsi_ioctl.c:507
> sg_ioctl+0xd37/0x23f0 drivers/scsi/sg.c:1106
> vfs_ioctl fs/ioctl.c:46 [inline]
> file_ioctl fs/ioctl.c:501 [inline]
> do_vfs_ioctl+0xae6/0x1030 fs/ioctl.c:688
> ksys_ioctl+0x76/0xa0 fs/ioctl.c:705
> __do_sys_ioctl fs/ioctl.c:712 [inline]
> __se_sys_ioctl fs/ioctl.c:710 [inline]
> __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:710
> do_syscall_64+0xa0/0x2e0 arch/x86/entry/common.c:293
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x45c479
> Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89
> f7 48
> 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f
> 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fb0e9602c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fb0e96036d4 RCX: 000000000045c479
> RDX: 0000000020000040 RSI: 0000000000000001 RDI: 0000000000000003
> RBP: 000000000076bfc0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 000000000000046d R14: 00000000004c6e1a R15: 000000000076bfcc
> 
> Allocated by task 12577:
> set_track mm/kasan/kasan.c:460 [inline]
> kasan_kmalloc mm/kasan/kasan.c:553 [inline]
> kasan_kmalloc+0xbf/0xe0 mm/kasan/kasan.c:531
> __kmalloc+0xf3/0x1e0 mm/slub.c:3749
> kmalloc include/linux/slab.h:520 [inline]
> load_elf_phdrs+0x118/0x1b0 fs/binfmt_elf.c:441
> load_elf_binary+0x2de/0x4610 fs/binfmt_elf.c:737
> search_binary_handler fs/exec.c:1654 [inline]
> search_binary_handler+0x15c/0x4e0 fs/exec.c:1632
> exec_binprm fs/exec.c:1696 [inline]
> __do_execve_file.isra.0+0xf52/0x1a90 fs/exec.c:1820
> do_execveat_common fs/exec.c:1866 [inline]
> do_execve fs/exec.c:1883 [inline]
> __do_sys_execve fs/exec.c:1964 [inline]
> __se_sys_execve fs/exec.c:1959 [inline]
> __x64_sys_execve+0x8a/0xb0 fs/exec.c:1959
> do_syscall_64+0xa0/0x2e0 arch/x86/entry/common.c:293
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Freed by task 12577:
> set_track mm/kasan/kasan.c:460 [inline]
> __kasan_slab_free+0x129/0x170 mm/kasan/kasan.c:521
> slab_free_hook mm/slub.c:1370 [inline]
> slab_free_freelist_hook mm/slub.c:1397 [inline]
> slab_free mm/slub.c:2952 [inline]
> kfree+0x8b/0x1a0 mm/slub.c:3904
> load_elf_binary+0x1be7/0x4610 fs/binfmt_elf.c:1118
> search_binary_handler fs/exec.c:1654 [inline]
> search_binary_handler+0x15c/0x4e0 fs/exec.c:1632
> exec_binprm fs/exec.c:1696 [inline]
> __do_execve_file.isra.0+0xf52/0x1a90 fs/exec.c:1820
> do_execveat_common fs/exec.c:1866 [inline]
> do_execve fs/exec.c:1883 [inline]
> __do_sys_execve fs/exec.c:1964 [inline]
> __se_sys_execve fs/exec.c:1959 [inline]
> __x64_sys_execve+0x8a/0xb0 fs/exec.c:1959
> do_syscall_64+0xa0/0x2e0 arch/x86/entry/common.c:293
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> The buggy address belongs to the object at ffff88803b8ccf00
> which belongs to the cache kmalloc-512 of size 512
> The buggy address is located 259 bytes inside of
> 512-byte region [ffff88803b8ccf00, ffff88803b8cd100)
> The buggy address belongs to the page:
> page:ffffea0000ee3300 count:1 mapcount:0 mapping:ffff88806cc03080
> index:0xffff88803b8cc780 compound_mapcount: 0
> flags: 0x100000000008100(slab|head)
> raw: 0100000000008100 ffffea0001104080 0000000200000002 ffff88806cc03080
> raw: ffff88803b8cc780 00000000800c000b 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
> ffff88803b8ccf00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88803b8ccf80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ffff88803b8cd000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ^
> ffff88803b8cd080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88803b8cd100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> 
> You can refer to "https://www.lkml.org/lkml/2019/1/17/474" reproduce
> this error.
> 
> The exception code is "bd_len = p[3];", "p" value is ffff88803b8cd000
> which belongs to the cache kmalloc-512 of size 512. The "page_address(sg_page(scsi_sglist(scmd)))"
> maybe from sg_scsi_ioctl function "buffer" which allocated by kzalloc, so "buffer"
> may not page aligned.
> This also looks completely buggy on highmem systems and really needs to use a
> kmap_atomic.      --Christoph Hellwig
> To address above bugs, Paolo Bonzini advise to simpler to just make a char array
> of size CACHE_MPAGE_LEN+8+8+4-2(or just 64 to make it easy), use sg_copy_to_buffer
> to copy from the sglist into the buffer, and workthere.

Applied, thanks.

-- 
Jens Axboe

