From: Sergei Shtylyov <sshtylyov@dev.rtsoft.ru>
Subject: Re: [PATCH 1/8] alim15x3: PIO fallback fix
Date: Fri, 09 Nov 2007 19:58:39 +0300
Message-ID: <473491BF.8070200@dev.rtsoft.ru>
References: <20070214015603.4619.41923.sendpatchset@localhost.localdomain> <46C6F90E.203@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:56650 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750715AbXKIQ61 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Nov 2007 11:58:27 -0500
In-Reply-To: <46C6F90E.203@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Hello, I wrote:

>> [PATCH] alim15x3: PIO fallback fix

>> If DMA tuning fails always set the best PIO mode.

>> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>    Oh, it's belated now. :-/
>    BTW, I'm going to hack on this driver since I've acquired a board 
> with M1543C chip (that one for which there was an urgent bug that I had 
> to fix some weeks ago :-)...

    Argh! PCI support for this board somehow doesn't work and doesn't even 
want to compile. :-]

MBR, Seregi
