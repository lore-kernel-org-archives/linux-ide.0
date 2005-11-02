From: thomas schorpp <t.schorpp@gmx.de>
Subject: [Merging ATA passthru] on integrating SMART/ATA-Security in usb-storage
 driver
Date: Wed, 02 Nov 2005 15:08:17 +0100
Message-ID: <4368C851.80203@gmx.de>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imap.gmx.net ([213.165.64.20]:54740 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932708AbVKBOIV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Nov 2005 09:08:21 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: usb-storage@lists.one-eyed-alien.net
Cc: linux-ide@vger.kernel.org

hi,

i'll try integrating SMART/ATA-Security in usb-storage driver for usb2
ide disks.

other people working on it yet? ive read something on SMART efforts for
SATA.

i think of using the passthrough code (libata?) or module in
usb-storage.ko like the SATA driver for ATA-Security.

comments?

thx
y
tom


-------- Original Message --------
Subject: Merging ATA passthru
Date: Fri, 21 Oct 2005 15:14:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org <linux-ide@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>


Folks,

Taking Mark Lord's (and others) criticism to heart, I'm going to merge
the ATA passthru work upstream, once 2.6.14 is released.

Since there are still some reported problems that I haven't had time to
track down, I'm going to -- like ATAPI -- introduce a module option that
enables passthru.  It will default to off.

Other features that follow a similar pattern -- 98% there but needs a
few final tweaks -- will be treated in the same way.

This gets lesser-used features upstream where they can get the most
testing, while defaulting them to off ensures that we won't perturb the
known-working code.

This also will help me, in that I won't have to maintain a bunch of
parallel codebases.

	Jeff



-
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

