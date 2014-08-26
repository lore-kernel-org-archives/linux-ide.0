From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Invoke set_disk_ro() from user space
Date: Tue, 26 Aug 2014 11:58:28 +0200
Message-ID: <CAGm1_kvMt=hPXgnze2fwjT93BwDQ_M-s4YfWP=zA1e2f2mebdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:53152 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283AbaHZJ6s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Aug 2014 05:58:48 -0400
Received: by mail-pa0-f47.google.com with SMTP id kx10so23172622pab.20
        for <linux-ide@vger.kernel.org>; Tue, 26 Aug 2014 02:58:48 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>

I'd like to remove write protection from a device. hdparm has
following command "hdparm -r0 device", but aside from reporting the
state, it does nothing. If you have a buggy hardware the only option
is to recompile the kernel and not invoking set_disk_ro(,1). Is there
any other option?

Yegor
