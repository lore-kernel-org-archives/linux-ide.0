From: Marek <mlf.conv@gmail.com>
Subject: requesting block devices via netlink
Date: Thu, 3 Dec 2015 17:49:56 +0100
Message-ID: <CA+sqOsbWecJnPTew-hXm+7a02xwPXnj2L5+MmV_BBn602yFDmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33077 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbbLCQt5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2015 11:49:57 -0500
Received: by wmec201 with SMTP id c201so36387609wme.0
        for <linux-ide@vger.kernel.org>; Thu, 03 Dec 2015 08:49:56 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

hi,

i'd like to ask whether it's possible to request block devices via
netlink e.g. ata devices.
There's NETLINK_KOBJECT_UEVENT but it only seems to be for  dumping
events to userspace. I'd like to construct a message that would allow
me to request block devices from the kernel. Is something like this
implemented inside the kernel.
