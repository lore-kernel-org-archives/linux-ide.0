From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 12/15] ide: make ide_hwif_t.ide_dma_host_on void
Date: Sat, 21 Apr 2007 00:36:52 +0400
Message-ID: <46292464.90403@ru.mvista.com>
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain> <20070119003220.14846.14258.sendpatchset@localhost.localdomain> <460800A8.4050501@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:48531 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030866AbXDTUf4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Apr 2007 16:35:56 -0400
In-Reply-To: <460800A8.4050501@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, once I wrote:

>> [PATCH] ide: make ide_hwif_t.ide_dma_host_on void
 
>> * since ide_hwif_t.ide_dma_host_on is called either when 
>> drive->using_dma == 1
>>   or when return value is discarded make it void, also drop "ide_" prefix
>> * make __ide_dma_host_on() void and drop "__" prefix

>    BTW, it would also make sense to make hwif->ide_dma_timeout() and 
> hwif->ide_dma_lostirq void too (and possibly drop the ide_ prefix). 
> Their results are *explicitly* ignored.

   I've started preparing the patches and found out that aec62xx has completely bogus ide_dma_timeout() -- the same as ide_dma_lostirq() and it doesn't even call __ide_dma_timeout()... :-/
   Don't know whether to deal with this in a separate patch...

MBR, Sergei
