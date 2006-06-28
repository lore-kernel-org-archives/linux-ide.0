From: Udo van den Heuvel <udovdh@xs4all.nl>
Subject: 2.6.17 on VIA SP8000 sata: via_sata timeout (cmd 0xef) (retry)
Date: Wed, 28 Jun 2006 19:40:54 +0200
Message-ID: <44A2BF26.8090608@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:7948 "EHLO
	smtp-vbr4.xs4all.nl") by vger.kernel.org with ESMTP
	id S1751499AbWF1Rk6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Jun 2006 13:40:58 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

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

