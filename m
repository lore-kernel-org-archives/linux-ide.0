From: Tejun Heo <htejun@gmail.com>
Subject: Re: PROBLEM: WARNING: at kernel/irq/manage.c:158 enable_irq() during
 boot
Date: Wed, 12 Dec 2007 08:39:48 +0900
Message-ID: <475F1FC4.7080501@gmail.com>
References: <fd0490a021a8.21a8fd0490a0@comp.waw.pl> <475D085F.9010307@gmail.com> <475E89EE.70501@comp.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:33980 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbXLKXjz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Dec 2007 18:39:55 -0500
Received: by wa-out-1112.google.com with SMTP id v27so8066wah.23
        for <linux-ide@vger.kernel.org>; Tue, 11 Dec 2007 15:39:55 -0800 (PST)
In-Reply-To: <475E89EE.70501@comp.waw.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wojciech Zareba <wojtekz@comp.waw.pl>
Cc: linux-ide@vger.kernel.org

Wojciech Zareba wrote:
> Hello,
> 
> Tejun Heo pisze:
>> (cc'ing Bartlomiej)
>> Hello,
>>
>> wojtekz@comp.waw.pl wrote:
>>> Dec  6 11:58:23 titanium kernel: WARNING: at kernel/irq/manage.c:158 enable_irq()
>>> Dec  6 11:58:23 titanium kernel:  [<c014b5c3>] enable_irq+0x6e/0xa2
>>> Dec  6 11:58:23 titanium kernel:  [<f887b783>] probe_hwif+0x6d8/0x7c7 [ide_core]
>>> Dec  6 11:58:23 titanium kernel:  [<f887c0be>] probe_hwif_init_with_fixup+0xc/0x80 [ide_core]
>>> Dec  6 11:58:23 titanium kernel:  [<c0190007>] elf_core_dump+0x627/0xb60
>>> Dec  6 11:58:23 titanium kernel:  [<f887df7b>] ide_setup_pci_device+0x6f/0x9c [ide_core]
>>> Dec  6 11:58:23 titanium kernel:  [<f883b1a7>] pdc202new_init_one+0xf/0x10 [pdc202xx_new]
>>> Dec  6 11:58:23 titanium kernel:  [<c01d94de>] pci_device_probe+0x36/0x55
>>> Dec  6 11:58:23 titanium kernel:  [<c021f8cb>] driver_probe_device+0xc8/0x14b
>>> Dec  6 11:58:23 titanium kernel:  [<c021fa37>] __driver_attach+0x52/0x87
>>> Dec  6 11:58:23 titanium kernel:  [<c021eecc>] bus_for_each_dev+0x35/0x57
>>> Dec  6 11:58:23 titanium kernel:  [<c021f748>] driver_attach+0x16/0x18
>>> Dec  6 11:58:23 titanium kernel:  [<c021f9e5>] __driver_attach+0x0/0x87
>>> Dec  6 11:58:23 titanium kernel:  [<c021f1a8>] bus_add_driver+0x6d/0x153
>>> Dec  6 11:58:23 titanium kernel:  [<c01d961d>] __pci_register_driver+0x4b/0x77
>>> Dec  6 11:58:23 titanium kernel:  [<c0143a39>] sys_init_module+0x1525/0x15fb
>>> Dec  6 11:58:23 titanium kernel:  [<f8879af9>] ide_config_drive_speed+0x0/0x314 [ide_core]
>>> Dec  6 11:58:23 titanium kernel:  [<c0103f9e>] syscall_call+0x7/0xb
>>> Dec  6 11:58:23 titanium kernel:  [<c02b0000>] wireless_nlevent_process+0x15/0x31
>>> Dec  6 11:58:23 titanium kernel:  =======================
>> That means IRQ is being enabled more times than it should be.  Can you
>> please give a shot at 2.6.24-rc4 and see whether the problem is still there?
>>
> It seems to be no more of this warning in the 2.6.24-rc4 kernel. But my feeling
> is that overall system performance is much poorer... pity. Maybe I should change
> something in the .config file?

Good, so it's something fixed during 2.6.24 devel cycle.  What do you
mean by 'overall system performance'?  Does IO feel much slower?

-- 
tejun
