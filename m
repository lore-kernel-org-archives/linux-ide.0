From: Marc Singer <elf@buici.com>
Subject: Re: So, is there support for IDE devices that have no IRQ?
Date: Wed, 24 Mar 2004 17:44:23 -0800
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040325014423.GA9860@buici.com>
References: <20040324232905.GA11286@buici.com> <200403250104.10142.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from florence.buici.com ([206.124.142.26]:35488 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S263089AbUCYBoY
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Mar 2004 20:44:24 -0500
Content-Disposition: inline
In-Reply-To: <200403250104.10142.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

On Thu, Mar 25, 2004 at 01:04:10AM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> Probing code uses polling but actual NODATA/PIO/DMA handlers require IRQ
> so it needs much effort to make it work.

Well, I'm thinking that I can emulate the irq by using a timer.  A bad
hack, but it ought to work as long as I can get the timing correct.
This is for a compact flash interface.
