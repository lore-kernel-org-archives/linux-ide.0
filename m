From: Zdenek Kabelac <zdenek.kabelac@gmail.com>
Subject: WARNING: at drivers/ata/libata-core.c:5027 ata_qc_complete+0x200/0x210()
Date: Thu, 17 Sep 2009 11:13:01 +0200
Message-ID: <c4e36d110909170213v61c61c94m3b4b3270333dafcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:58007 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755104AbZIQJM6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Sep 2009 05:12:58 -0400
Received: by fxm17 with SMTP id 17so2830270fxm.37
        for <linux-ide@vger.kernel.org>; Thu, 17 Sep 2009 02:13:01 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi

Somewhere during recent merge commits this message started to appear
in my qemu kvm guest
(already present with some 2.6.31-040xxx commit)

Is this fault of kvm emulation ?


WARNING: at drivers/ata/libata-core.c:5027 ata_qc_complete+0x200/0x210()
Hardware name:
Modules linked in:
Pid: 167, comm: ata/0 Not tainted 2.6.31-05317-ged0ecd1 #42
Call Trace:
 [<ffffffff81051ddb>] warn_slowpath_common+0x7b/0xc0
 [<ffffffff81051e34>] warn_slowpath_null+0x14/0x20
 [<ffffffff81323690>] ata_qc_complete+0x200/0x210
 [<ffffffff81330243>] ata_do_link_abort+0xf3/0x110
 [<ffffffff81330270>] ata_port_abort+0x10/0x20
 [<ffffffff813302af>] ata_port_freeze+0x2f/0x50
 [<ffffffff81334101>] ata_hsm_qc_complete+0x131/0x140
 [<ffffffff81335347>] ata_sff_hsm_move+0x197/0x760
 [<ffffffff8125891a>] ? delay_tsc+0x8a/0xe0
 [<ffffffff81335ca0>] ? ata_pio_task+0x0/0x120
 [<ffffffff81335ca0>] ? ata_pio_task+0x0/0x120
 [<ffffffff81335cd7>] ata_pio_task+0x37/0x120
 [<ffffffff8106f88a>] worker_thread+0x21a/0x400
 [<ffffffff8106f839>] ? worker_thread+0x1c9/0x400
 [<ffffffff81075a20>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff8106f670>] ? worker_thread+0x0/0x400
 [<ffffffff810755f6>] kthread+0x96/0xa0
 [<ffffffff8100d29a>] child_rip+0xa/0x20
 [<ffffffff81041574>] ? finish_task_switch+0x74/0xf0
 [<ffffffff8140d14b>] ? _spin_unlock_irq+0x3b/0x60
 [<ffffffff8100cc00>] ? restore_args+0x0/0x30
 [<ffffffff81075560>] ? kthread+0x0/0xa0
 [<ffffffff8100d290>] ? child_rip+0x0/0x20


Zdenek
