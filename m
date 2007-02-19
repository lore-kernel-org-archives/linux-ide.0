From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [git patches] more IDE updates
Date: Mon, 19 Feb 2007 18:23:09 +0300
Message-ID: <45D9C0DD.6070500@ru.mvista.com>
References: <200702170325.02337.bzolnier@gmail.com> <45D9BFD2.6030509@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:1833 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932354AbXBSPXR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Feb 2007 10:23:17 -0500
In-Reply-To: <45D9BFD2.6030509@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Sergei Shtylyov wrote:

>> Contains: IRQ-ack fix for ICH chipsets (Albert Lee), ide-floppy 
>> unformatted
>> media fix (Alan Cox), more fixes for IDE PCI drivers (Sergei Shtylyov),
>> new driver for Toshiba Cell Reference Board (Kou Ishizaki <kou.ishizaki
>> at toshiba.co.jp>) and a bunch of rather obvious cleanups/improvements 
>> (me).

>> There are still some bugfix patches in my tree which should go into 
>> 2.6.21
>> but since they are quite fresh and there have already been a lot of IDE
>> changes since the merge window was opened I will wait for -rc1 to push
>> them upstream.

>> [ Andrew, IDE quilt tree has already been updated wrt to this update ]

>    Which quilt tree do you mean? I've noticed that in 
> http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/ the series file 
> itself hasn't been updated, so this tree appears broken currently.

    Begging your pardon, it's all browser caching. :-<

WBR, Sergei
