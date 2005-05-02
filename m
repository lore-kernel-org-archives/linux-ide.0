From: "Oskar Liljeblad" <oskar@osk.mine.nu>
Subject: clock drift with two Promise Ultra133 TX2 (PDC 20269) cards
Date: Mon, 2 May 2005 21:28:43 +0200
Message-ID: <20050502192843.GA3367@oskar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from diadema.skane.tbv.se ([193.13.139.13]:14236 "EHLO
	diadema.skane.tbv.se") by vger.kernel.org with ESMTP
	id S261724AbVEBT2p (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 May 2005 15:28:45 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

I'm running 2.6.11.8 on an server with two Promise Ultra133 TX2 (PDC20269)
PCI cards, same hardware revision (judging from stickers on the cards).
I'm using the CONFIG_BLK_DEV_PDC202XX_NEW driver.
Each card has two connected hard drives. Whenever I read from a disk
on one of the cards (e.g. using 'dd if=/dev/hdX of=/dev/null bs=1M'), and
at the same time read from a disk on the other card, there is heavy
software clock drift. It drifts about 2-5 seconds per minute.

This does not happen if I read from two drives connected on the same
card, or if I read from a drive connected to the motherboard IDE
(VIA vt8233a) and a drive on either of the Promise cards.

Oskar Liljeblad (oskar@osk.mine.nu)
