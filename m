From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: allow ide-generic users to ask it to capture unknown
	devices
Date: Sat, 06 Nov 2004 00:52:53 +0000
Message-ID: <1099702372.5556.95.camel@localhost.localdomain>
References: <1099671737.5556.32.camel@localhost.localdomain>
	 <200411052256.27303.bzolnier@elka.pw.edu.pl>
	 <1099697274.5567.76.camel@localhost.localdomain>
	 <200411060146.05980.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:43461 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261288AbUKFBzr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 20:55:47 -0500
In-Reply-To: <200411060146.05980.bzolnier@elka.pw.edu.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

On Sad, 2004-11-06 at 00:46, Bartlomiej Zolnierkiewicz wrote:
> > Because when someone adds an entry they'll break the driver.
> 
> Please be specific, what will break?

The entry is currently last. Someone seeing the comment it must be last
is likely to also leave it last in the table and thus the hardcoded 14
would
need to become 15. Making it "0" took away the cause.

> > Correct but they must force it on by hand. It generates a printk to tell
> > the user and so its obvious in any bug reports..
> 
> 99% of IDE bugreports don't contain full dmesg...

At the moment it prints it quite early. If I move the printk down I can
change it so that at the point it grabs the hwif (ie right in the IDE
logs)
it says "blah blah grabbing Unknown device (0x1111, 0x2222)"

Would that be preferable ?

