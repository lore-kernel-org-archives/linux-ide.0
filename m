From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/6] cmd64x: remove /proc/ide/cmd64x
Date: Tue, 04 Dec 2007 15:27:12 +0300
Message-ID: <475547A0.4040809@ru.mvista.com>
References: <200712032255.08012.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:49487 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753893AbXLDM0y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 07:26:54 -0500
In-Reply-To: <200712032255.08012.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> This belongs to user-space (and only if really needed).

    Sigh, and why only I spent time fixing this code? :-)

>    text    data     bss     dec     hex filename
>    3874     180      28    4082     ff2 drivers/ide/pci/cmd64x.o.before
>    2231     180       0    2411     96b drivers/ide/pci/cmd64x.o.after

> Additionaly to being bloat the code contained two bugs:
> - incorrect UDMA modes were reported for reserved values of UDIDETCR0/1 regs

    Huh? What reserved values?

> - MRDMODE_BLK_CH0/1 bits are not defined on CMD643 and early CMD646 revisions

    They're 0 there anyway, so the code worked properly.

> Also while at it remove unused CNTRL_DIS_RA0/1 defines.

> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
