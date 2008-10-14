From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Porting old hardware from ide to libata (was [PATCH 0/7] ide:
 locking improvements)
Date: Tue, 14 Oct 2008 10:01:23 +0100
Message-ID: <20081014100123.41beb64f@lxorguk.ukuu.org.uk>
References: <20081013234648.41cfca48@lxorguk.ukuu.org.uk>
	<232037.89022.qm@web57407.mail.re1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:43699 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751771AbYJNJBZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Oct 2008 05:01:25 -0400
In-Reply-To: <232037.89022.qm@web57407.mail.re1.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: stan.cunningham@yahoo.com
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

On Mon, 13 Oct 2008 19:11:04 -0700 (PDT)
Stan Cunningham <stan.cunningham@yahoo.com> wrote:

> --- On Mon, 10/13/08, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > Libata supports more prehistoric pointless
> > ISA and VLB controllers than drivers/ide.
> 
> Perhaps, but the ultimate goal for libata should be to support *all* the hardware that works under drivers/ide. Until that's achieved, drivers/ide is still needed despite the drawbacks of having two frameworks.

I don't have a problem having two frameworks, one of which is just used
by things like the commode amiga and other ancient relics. If one of the
tiny number of users of the port wants libata they can probably port it
over in a few minutes and then spend a week recompiling ;)

> BTW, I recall there was another attempt at writing a libata driver for Apple hardware, namely pata_macio by Benjamin Herrenschmidt.

Yes Ben is working on this stuff now

Alan
