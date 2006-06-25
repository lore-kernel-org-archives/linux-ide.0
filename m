From: Udo van den Heuvel <udovdh@xs4all.nl>
Subject: 2.6.17 on VIA SP8000 sata: via_sata timeout (cmd 0xef)
Date: Sun, 25 Jun 2006 17:30:47 +0200
Message-ID: <449EAC27.2080404@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-vbr16.xs4all.nl ([194.109.24.36]:28179 "EHLO
	smtp-vbr16.xs4all.nl") by vger.kernel.org with ESMTP
	id S1751439AbWFYPaw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 25 Jun 2006 11:30:52 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hello Jeff and others,

While 2.6.16.2 runs quite OK on my VIA SP8000 Epia system, 2.6.17 gives
(with the same config where possible) a sata problem on bootup, it gives
a via_sata timeout(cmd 0xef). (the letters were small to make the stuff
not scroll off the TV)
Immediately rebooting into 2.6.16.2 gives a nice clean bootup.

The drive is a SAMSUNG HD160JJ. Hardware has not changed and the .config
for the kernel compile was not modified except for version differences.

Did I miss something? Is my hardware starting te get picky about linux
kernel version numbers? Or getting defective?
Any ideas?

Kind regards,
Udo
