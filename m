From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: So, is there support for IDE devices that have no IRQ?
Date: Thu, 25 Mar 2004 03:23:44 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200403250323.44984.bzolnier@elka.pw.edu.pl>
References: <20040324232905.GA11286@buici.com> <200403250104.10142.bzolnier@elka.pw.edu.pl> <20040325014423.GA9860@buici.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:2528 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263121AbUCYCPV
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Mar 2004 21:15:21 -0500
In-Reply-To: <20040325014423.GA9860@buici.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Marc Singer <elf@buici.com>
Cc: linux-ide@vger.kernel.org

On Thursday 25 of March 2004 02:44, Marc Singer wrote:
> On Thu, Mar 25, 2004 at 01:04:10AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > Probing code uses polling but actual NODATA/PIO/DMA handlers require IRQ
> > so it needs much effort to make it work.
>
> Well, I'm thinking that I can emulate the irq by using a timer.  A bad
> hack, but it ought to work as long as I can get the timing correct.
> This is for a compact flash interface.

Sigh, proper fix is to convert NODATA/PIO handlers to use polling.

