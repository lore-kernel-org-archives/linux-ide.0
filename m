From: Yu Chen <yu.chen.surf@gmail.com>
Subject: BUG: sleeping function called from invalid context at kernel/locking/mutex.c:238
Date: Wed, 18 Oct 2017 16:56:05 +0800
Message-ID: <CADjb_WS86DytQ1FFMG-ucv2Pr282hacGzqpeW0_aHjON=_j5+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:48636 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759098AbdJRI4H (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 18 Oct 2017 04:56:07 -0400
Received: by mail-lf0-f46.google.com with SMTP id a69so4951957lfe.5
        for <linux-ide@vger.kernel.org>; Wed, 18 Oct 2017 01:56:06 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I saw the following backtrace when running some benchmarks, it might
not be critical, but it is even better we can get rid of this warning : )


[  318.808335] BUG: sleeping function called from invalid context at
kernel/locking/mutex.c:238
[  318.818779] in_atomic(): 1, irqs_disabled(): 1, pid: 1144, name: scsi_eh_7
[  318.826248] CPU: 5 PID: 1144 Comm: scsi_eh_7 Tainted: G           O
   4.14.0-rc4-00128-g30e9e23 #2
[  318.835882] Call Trace:
[  318.838973]  dump_stack+0x63/0x86
[  318.842882]  ___might_sleep+0xf1/0x110
[  318.847214]  __might_sleep+0x4a/0x80
[  318.851368]  mutex_lock+0x20/0x50
[  318.855247]  kernfs_find_and_get_ns+0x23/0x60
[  318.860158]  sysfs_notify+0x77/0x90
[  318.864237]  scsi_device_set_state+0x63/0x150
[  318.869180]  ata_scsi_offline_dev+0x1c/0x30 [libata]
[  318.874696]  ata_eh_detach_dev+0x3b/0xb0 [libata]
[  318.879929]  ata_eh_schedule_probe+0x59/0x1c0 [libata]
[  318.885590]  ata_eh_recover+0x108/0x12d0 [libata]
[  318.890807]  ? ahci_pmp_attach+0x70/0x70 [libahci]
[  318.896105]  ? ahci_do_hardreset+0x110/0x110 [libahci]
[  318.901744]  ? ahci_do_softreset+0x210/0x210 [libahci]
[  318.907371]  ? ata_phys_link_offline+0x30/0x30 [libata]
[  318.913123]  ? ata_eh_report+0x34f/0x850 [libata]
[  318.918345]  sata_pmp_eh_recover+0xb7/0xa00 [libata]
[  318.923818]  ? ata_eh_report+0x6e6/0x850 [libata]
[  318.929028]  sata_pmp_error_handler+0x22/0x30 [libata]
[  318.934631]  ahci_error_handler+0x1d/0x70 [libahci]
[  318.939968]  ata_scsi_port_error_handler+0x430/0x720 [libata]
[  318.946167]  ? ata_scsi_cmd_error_handler+0xe9/0x140 [libata]
[  318.952368]  ata_scsi_error+0x86/0xb0 [libata]
[  318.957260]  ? scsi_error_handler+0x38/0x5d0
[  318.961965]  scsi_error_handler+0xe7/0x5d0
[  318.966499]  kthread+0x114/0x150
[  318.970155]  ? scsi_eh_get_sense+0x280/0x280
[  318.974848]  ? kthread_create_on_node+0x40/0x40
[  318.979798]  ret_from_fork+0x25/0x30
[  318.983813] ata8: hard resetting link

Thanks,
Yu
