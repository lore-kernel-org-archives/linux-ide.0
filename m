From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: 2.6.10 - IT8212 IDE
Date: Wed, 29 Dec 2004 21:24:45 +0000
Message-ID: <1104355483.31622.2.camel@localhost.localdomain>
References: <1104246926.22366.97.camel@localhost.localdomain>
	 <58cb370e041229092919c1b4a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:22437 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261269AbUL2W2p (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Dec 2004 17:28:45 -0500
In-Reply-To: <58cb370e041229092919c1b4a8@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Mer, 2004-12-29 at 17:29, Bartlomiej Zolnierkiewicz wrote:
> ide_get_best_pio_mode(drive, 4, 5, NULL) always returns 4
> [ quick fix == hardcode 4 for now and add FIXME ]

Doesn't seem that way reading the code.

I've folded the other changes (except moving the fixup) into my code
base and will give it a testing over the next few days and check for any
reversions.


