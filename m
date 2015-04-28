From: Alexey Orishko <alexey.orishko@gmail.com>
Subject: printouts about removable disk in the kernel log
Date: Tue, 28 Apr 2015 17:49:18 +0200
Message-ID: <CAL_Kpj2BAO781yXF-q2Q1AHoxXZpSXeOHfxDc7uoyeEURJZ5qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33646 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965792AbbD1PtS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Apr 2015 11:49:18 -0400
Received: by qkx62 with SMTP id 62so82482825qkx.0
        for <linux-ide@vger.kernel.org>; Tue, 28 Apr 2015 08:49:18 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi guys,

Sorry, if I'm off topic/wrong email list..
I'm using kernel 3.18.11 kernel with log level 3 and I wonder what module/driver
spamming kernel log with messages like:
...
[333670.400456]  sdc: sdc1
[333681.164482]  sdc: sdc1
[333703.092187]  sdc: sdc1
[333735.383544]  sdc: sdc1
[333745.723305]  sdc: sdc1
[333767.222874]  sdc: sdc1
[333777.664778]  sdc: sdc1
...
[334196.922476]  sdc: sdc1
[334203.111184] sdc: detected capacity change from 80022167552 to 0
[334203.113963] ata4: exception Emask 0x10 SAct 0x0 SErr 0x4010000
action 0xe frozen
[334203.113965] ata4: irq_stat 0x00400040, connection status changed
[334203.113968] ata4: SError: { PHYRdyChg DevExch }
[334203.113976] ata4: hard resetting link
[334203.836637] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
..

When a removable disk is connected, kernel log is overwhelmed with
messages about
disk and its partition like in example above. Messages in the kernel
log stop after disk
was removed (ejected). The messages are not really informative and I
wonder if they can be
switched off.

It is difficult to find this message in the kernel code, since based
on the the look it is
most likely containing only arguments to print function.

Does anyone know the origin of such messages so they can be removed?

Regards,
Alexey
