From: Marc Singer <elf@buici.com>
Subject: Re: So, is there support for IDE devices that have no IRQ?
Date: Wed, 24 Mar 2004 18:25:11 -0800
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040325022511.GA12156@buici.com>
References: <20040324232905.GA11286@buici.com> <200403250104.10142.bzolnier@elka.pw.edu.pl> <20040325014423.GA9860@buici.com> <200403250323.44984.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from florence.buici.com ([206.124.142.26]:38816 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S263123AbUCYCZN
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Mar 2004 21:25:13 -0500
Content-Disposition: inline
In-Reply-To: <200403250323.44984.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

On Thu, Mar 25, 2004 at 03:23:44AM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 25 of March 2004 02:44, Marc Singer wrote:
> > On Thu, Mar 25, 2004 at 01:04:10AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > > Probing code uses polling but actual NODATA/PIO/DMA handlers require IRQ
> > > so it needs much effort to make it work.
> >
> > Well, I'm thinking that I can emulate the irq by using a timer.  A bad
> > hack, but it ought to work as long as I can get the timing correct.
> > This is for a compact flash interface.
> 
> Sigh, proper fix is to convert NODATA/PIO handlers to use polling.

Of course, I'd rather do that.  8-)


