From: "Peter Millerchip" <peter.millerchip@gmail.com>
Subject: Patch: ide noprobe fix
Date: Fri, 3 Mar 2006 15:06:49 +0000
Message-ID: <ccd4c3e80603030706t681f0870t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.192]:26029 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751477AbWCCPGu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 3 Mar 2006 10:06:50 -0500
Received: by xproxy.gmail.com with SMTP id t13so466820wxc
        for <linux-ide@vger.kernel.org>; Fri, 03 Mar 2006 07:06:49 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

With 2.6.15.5 I am using ide2=noprobe on the command line but
drivers/ide/setup-pci.c overwrites the hwif->noprobe flag back to zero
on line 442. The following patch fixes it:

442c442
<               hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET];
---
>               hwif->noprobe = hwif->noprobe || !hwif->io_ports[IDE_DATA_OFFSET];

This allows ide2=noprobe to work correctly. Without the patch the
kernel takes around a minute to determine that ide2 is not there, but
with the patch it is instant.

Is this patch the correct way to do it? How do I get it merged into
the main code if it is correct? Sorry for the obvious questions but
I'm a bit of a newbie at this.

Regards,

Pete.
