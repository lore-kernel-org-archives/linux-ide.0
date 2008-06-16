From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] palm_bk3710: fix resource management
Date: Mon, 16 Jun 2008 23:41:50 +0400
Message-ID: <4856C1FE.5030907@ru.mvista.com>
References: <200806162220.35499.sshtylyov@ru.mvista.com> <200806162134.10579.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:17342 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752037AbYFPTlo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Jun 2008 15:41:44 -0400
In-Reply-To: <200806162134.10579.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>The driver expected a *virtual* address in the IDE platform device's memory
>>resource and didn't request the memory region for the register block. Fix this
>>taking into account the fact that DaVinci SoC devices are fixed-mapped to the
>>virtual memory early and we can get their virtual addresses using IO_ADDRESS()
>>macro, not having to call ioremap()...

>>While at it, also do some cosmetic changes...

>>---
>>The patch is against the recent Linus' tree.

> looks OK but please S-o-b it

    Done. I often forget about it, silly SOB. :-)

MBR, Sergei
