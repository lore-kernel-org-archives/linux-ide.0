From: "Al Boldi" <a1426z@gawab.com>
Subject: RE: [git patches] IDE update
Date: Mon, 4 Jul 2005 20:06:04 +0300
Message-ID: <200507041706.UAA11178@raad.intranet>
References: <58cb370e05070408417dc3c067@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [212.76.87.20] ([212.76.87.20]:64516 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S261423AbVGDRGj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jul 2005 13:06:39 -0400
In-Reply-To: <58cb370e05070408417dc3c067@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Bartlomiej Zolnierkiewicz' <bzolnier@gmail.com>
Cc: 'Linus Torvalds' <torvalds@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote: {
> On 7/4/05, Al Boldi <a1426z@gawab.com> wrote:
> Hdparm -tT gives 38mb/s in 2.4.31
> Cat /dev/hda > /dev/null gives 2% user 33% sys 65% idle
> 
> Hdparm -tT gives 28mb/s in 2.6.12
> Cat /dev/hda > /dev/null gives 2% user 25% sys 0% idle 73% IOWAIT
> 
> It feels like DMA is not being applied properly in 2.6.12.

Are earlier 2.6.x kernels okay?

dmesg output?
}

Same on 2.6.10,11,12.
No errors though, only sluggish system.

