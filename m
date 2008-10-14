From: Stan Cunningham <stan.cunningham@yahoo.com>
Subject: Re: Porting old hardware from ide to libata (was [PATCH 0/7] ide: locking improvements)
Date: Mon, 13 Oct 2008 19:11:04 -0700 (PDT)
Message-ID: <232037.89022.qm@web57407.mail.re1.yahoo.com>
References: <20081013234648.41cfca48@lxorguk.ukuu.org.uk>
Reply-To: stan.cunningham@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from n8.bullet.re3.yahoo.com ([68.142.237.93]:22627 "HELO
	n8.bullet.re3.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753686AbYJNCLH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Oct 2008 22:11:07 -0400
In-Reply-To: <20081013234648.41cfca48@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

--- On Mon, 10/13/08, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Libata supports more prehistoric pointless
> ISA and VLB controllers than drivers/ide.

Perhaps, but the ultimate goal for libata should be to support *all* the hardware that works under drivers/ide. Until that's achieved, drivers/ide is still needed despite the drawbacks of having two frameworks.

> Unfortunately the big remaining one (mac support)
> didn't happen as the
> Mac that dwmw2 loaned me died and as in typical crapple
> design style it
> needed major surgery with sharpened wall paper scrapers to
> even open it
> the work didn't get done.

I started a wiki page ( http://ata.wiki.kernel.org/index.php/Hardware_For_Developers ) where developers can list the hardware they need in order to develop libata drivers. I'm sure there are people with unused hardware that they would be be willing to donate to interested developers. Or give money donations so that developers can buy the necessary hardware. Please feel free to add the Apple parts you need to that page.

BTW, I recall there was another attempt at writing a libata driver for Apple hardware, namely pata_macio by Benjamin Herrenschmidt.

Stan


      

