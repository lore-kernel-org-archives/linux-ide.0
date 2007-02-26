From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [git patches] more IDE updates
Date: Mon, 26 Feb 2007 20:46:54 +0300
Message-ID: <45E31D0E.6070906@ru.mvista.com>
References: <200702170325.02337.bzolnier@gmail.com> <45D9BFD2.6030509@ru.mvista.com> <45D9C0DD.6070500@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:59154 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030371AbXBZRrI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Feb 2007 12:47:08 -0500
In-Reply-To: <45D9C0DD.6070500@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, I wrote:

>>> Contains: IRQ-ack fix for ICH chipsets (Albert Lee), ide-floppy 
>>> unformatted
>>> media fix (Alan Cox), more fixes for IDE PCI drivers (Sergei Shtylyov),
>>> new driver for Toshiba Cell Reference Board (Kou Ishizaki <kou.ishizaki
>>> at toshiba.co.jp>) and a bunch of rather obvious 
>>> cleanups/improvements (me).

>>> There are still some bugfix patches in my tree which should go into 
>>> 2.6.21
>>> but since they are quite fresh and there have already been a lot of IDE
>>> changes since the merge window was opened I will wait for -rc1 to push
>>> them upstream.

>>> [ Andrew, IDE quilt tree has already been updated wrt to this update ]

>>    Which quilt tree do you mean? I've noticed that in 
>> http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/ the series 
>> file itself hasn't been updated, so this tree appears broken currently.

>    Begging your pardon, it's all browser caching. :-<

   Now it's *actually* borken since rtying to read 
delkin_cb-pci_module_init-to-pci_register_driver.patch gets you "403 Forbidden"...

WBR, Sergei
