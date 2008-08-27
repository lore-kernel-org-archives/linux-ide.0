From: "Andrew Grover" <andy.grover@gmail.com>
Subject: delay & msgs on S3 wakeup, Dell XPS m1330 laptop
Date: Tue, 26 Aug 2008 21:56:56 -0700
Message-ID: <c0a09e5c0808262156u1ed7777ay5f1e6c196a8be6b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:21763 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbYH0E45 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Aug 2008 00:56:57 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2610180wfd.4
        for <linux-ide@vger.kernel.org>; Tue, 26 Aug 2008 21:56:56 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Laptop comes out of suspend and then spends a long time (10 sec)
waiting, and then finishes coming up. Everything seems to be working
fine, but the delay is worrisome.

Any tips? Running latest bios (a12) on Ubuntu 2.6.24-19 kernel.

[    2.946116] sd 2:0:0:0: [sda] Starting disk
[    6.128124] ata3: port is slow to respond, please be patient (Status 0x80)
[   10.941192] ata3: softreset failed (device not ready)
[   11.240148] ata3: port is slow to respond, please be patient (Status 0x80)
[   11.482698] ata3: COMRESET failed (errno=-16)
[   11.508223] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   11.583731] ata3.00: configured for UDMA/133
[   11.585389] sd 2:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)

Thanks -- Andy
