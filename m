From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pci: use pci_ioremap_bar() in drivers/ide
Date: Wed, 22 Oct 2008 22:08:07 +0400
Message-ID: <48FF6C07.5020207@ru.mvista.com>
References: <20081020214830.1586704c@infradead.org>	<48FDA8BF.20206@ru.mvista.com>	<48FF6595.5040203@ru.mvista.com> <20081022105608.51ac9a6f@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:45328 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751118AbYJVSI0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Oct 2008 14:08:26 -0400
In-Reply-To: <20081022105608.51ac9a6f@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Arjan van de Ven wrote:

>>>>Use the newly introduced pci_ioremap_bar() function in drivers/ide.
>>>>pci_ioremap_bar() just takes a pci device and a bar number, with
>>>>the goal of making it really hard to get wrong, while also having
>>>>a central place to stick sanity checks.

>>>>Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

>>>Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>    No, I'm takign back my ACK.
>>    Since the patch intends to address all drivers/ide/, it's clearly
>>no compolete -- siimage.c and scc_pata.c beg for the alike change (it
>>will even permit to kill 4 local variables in the latter driver).

> I'll be happy to take a second pass, but "doesn't convert everyone"
> shouldn't really be a reason to do the first pass ;-)

    To not do, you mean?
    If you're going to leave this patch as it, it's worth to change the 
subject/header reflecting a modest goal of doing this only for one driver. ;-)

MBR, Sergei
