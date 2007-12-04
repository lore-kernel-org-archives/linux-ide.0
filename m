From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 6/6] cmd64x: remove /proc/ide/cmd64x
Date: Tue, 4 Dec 2007 15:02:07 +0100
Message-ID: <200712041502.07678.bzolnier@gmail.com>
References: <200712032255.08012.bzolnier@gmail.com> <475547A0.4040809@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:48749 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753433AbXLDNzZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 08:55:25 -0500
Received: by ug-out-1314.google.com with SMTP id z38so77824ugc
        for <linux-ide@vger.kernel.org>; Tue, 04 Dec 2007 05:55:24 -0800 (PST)
In-Reply-To: <475547A0.4040809@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


On Tuesday 04 December 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > This belongs to user-space (and only if really needed).
> 
>     Sigh, and why only I spent time fixing this code? :-)
> 
> >    text    data     bss     dec     hex filename
> >    3874     180      28    4082     ff2 drivers/ide/pci/cmd64x.o.before
> >    2231     180       0    2411     96b drivers/ide/pci/cmd64x.o.after
> 
> > Additionaly to being bloat the code contained two bugs:
> > - incorrect UDMA modes were reported for reserved values of UDIDETCR0/1 regs
> 
>     Huh? What reserved values?

According to CMD649 datasheet (rev 1.0):

register 73h
bit [5:4] and bit [7:6]
	00 value is Reserved if bit[2] is 0
	11 value is Reserved if bit[2] is 1

[ in CMD648 datasheet above values are listed as a valid timings but
  they doesn't match UDMA modes reported by /proc/ide/cmd64x anyway ]

> > - MRDMODE_BLK_CH0/1 bits are not defined on CMD643 and early CMD646 revisions
> 
>     They're 0 there anyway, so the code worked properly.

Thanks, I removed this from the patch desription.

PS please don't fix /proc code in alim15x3.c ;-)

Bart
