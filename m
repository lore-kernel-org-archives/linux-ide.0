From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Promise IDE controller crashes 2.4.22
Date: Mon, 01 Dec 2003 10:31:15 +1100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1070235074.658.58.camel@gaston>
References: <20031129.140802.28395.1074931@webmail05.lax.untd.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.86.99.235]:10709 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262119AbTK3Xbz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 30 Nov 2003 18:31:55 -0500
In-Reply-To: <20031129.140802.28395.1074931@webmail05.lax.untd.com>
List-Id: linux-ide@vger.kernel.org
To: beolach@juno.com
Cc: jgoerzen@complete.org, linux-ide@vger.kernel.org

On Sun, 2003-11-30 at 09:07, beolach@juno.com wrote:
> I recently had a very similar problem to this on my computer with a
> Promise Ultra133TX2 (PDC20269) addon card.  In my case I had a Western
> Digital drive attached to the PDC20269 that would have major filesystem
> corruption when DMA was enabled during the boot process.  Interestingly,
> if I disabled DMA during boot, and then enabled it after boot with
> hdparm, the drive worked OK.  Also, if I moved the drive to my
> mainboard's IDE controller, it would work.  It seemed to be a
> combination of my drive & IDE controller, because the IDE controller
> works fine with other drives, and the WD hard drive worked fine with
> another IDE controller.  I replaced the drive (20 GB) with a 120 GB
> Maxtor drive, and haven't had any problem since.

Did you have something on the "other" channel ?

Andre seems to imply that the Promise chip may trigger interesting
bugs if you do things like SET_FEATURE on one channel while another
is doing DMA, kind of things that may well happen during boot

Ben.

