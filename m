From: Eric Sesterhenn <snakebyte@gmx.de>
Subject: Is drive->id always set when ide_dma_check () gets called?
Date: Mon, 21 Aug 2006 00:51:10 +0200
Message-ID: <1156114270.7078.6.camel@alice>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:53126 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751764AbWHTWvS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Aug 2006 18:51:18 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

hi,

while trying to tackle some more coverity bugs, I came across
bug #206 to #211. They are all about the function they register for 
hwif->ide_dma_check. Basically they all do something like

struct hd_driveid *id	= drive->id

if (id && (id->capability & 1) && drive->autodma) {
	something();
} else if ((id->capability & 8) || (id->field_valid & 2)) {
	something_else();
}

Coverity complains that id is only checked for != NULL in the first case
but not the second. While trying to review the callers, all of them
either checked drive->id or dereferenced it themselves. Only with
probe_hwif() in drivers/ide/ide-probe.c I am not sure. So the question boils down
to: should we,

a) remove the check
b) add the check to the second case
c) just tell coverity to shut up

Thanks for comments,
Eric

