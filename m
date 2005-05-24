From: "Oskar Liljeblad" <oskar@osk.mine.nu>
Subject: clock drift with 2x Promise Ultra133 TX2 (PDC 20269) (again)
Date: Tue, 24 May 2005 18:53:39 +0200
Message-ID: <20050524165339.GA16577@oskar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from diadema.skane.tbv.se ([193.13.139.13]:14055 "EHLO
	diadema.skane.tbv.se") by vger.kernel.org with ESMTP
	id S261349AbVEXQxm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 May 2005 12:53:42 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: raw@dslr.net

Problem:
I have two Promise Ultra133 TX2 (PDC 20269) cards, each with two
Maxtor UDMA133 hard drives connected. The system also has another
hard drive connected to the motherboard. A total of five drives.

When I concurrently read from two hard drives connected to
different Promise cards, there is heavy software clock drift.
The software clock runs too fast - approx. a few seconds per
minute during this i/o. To reproduce:

  hwclock --hctosys
  hwclock --show
  date
  dd if=/dev/hde of=/dev/null bs=1M count=7200 &
  dd if=/dev/hdi of=/dev/null bs=1M count=7200 &
  wait
  wait
  hwclock --show
  date

This doesn't happen if I read from two drives connected to the
same card, or one drive connected to the motherboard and one
connected to a Promise card.

I've removed all other PCI devices in the system - problem remains.
I tried different motherboards:

  Asus A7V266-C with AMD AthlonXP 2000+ (i686) - problem occurs
  Asus A7V600-X with AMD Sempron 2600+  (i686) - problem occurs
  Abit KV8 Pro  with AMD Athlon64 3000+ (i686) - problem does not occur!

So what makes the Abit motherboard different?

Regards,

Oskar Liljeblad (oskar@osk.mine.nu)
