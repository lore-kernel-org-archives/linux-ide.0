From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git patches] IDE update
Date: Mon, 4 Jul 2005 17:41:34 +0200
Message-ID: <58cb370e05070408417dc3c067@mail.gmail.com>
References: <58cb370e05070405302d47fdfd@mail.gmail.com>
	 <200507041530.SAA02324@raad.intranet>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.200]:20982 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261228AbVGDPlh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Jul 2005 11:41:37 -0400
Received: by nproxy.gmail.com with SMTP id o25so172199nfa
        for <linux-ide@vger.kernel.org>; Mon, 04 Jul 2005 08:41:34 -0700 (PDT)
In-Reply-To: <200507041530.SAA02324@raad.intranet>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Al Boldi <a1426z@gawab.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 7/4/05, Al Boldi <a1426z@gawab.com> wrote:
> Bartlomiej Zolnierkiewicz wrote: {
> What is the "int/dma problem"?
> }
> 
> Hdparm -tT gives 38mb/s in 2.4.31
> Cat /dev/hda > /dev/null gives 2% user 33% sys 65% idle
> 
> Hdparm -tT gives 28mb/s in 2.6.12
> Cat /dev/hda > /dev/null gives 2% user 25% sys 0% idle 73% IOWAIT
> 
> It feels like DMA is not being applied properly in 2.6.12.
> 
> Your comments please.

Are earlier 2.6.x kernels okay?

dmesg output?

Bartlomiej
