From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 08/10] ide: move ide_map_sg() call out from ->dma_setup
 method
Date: Wed, 11 Mar 2009 20:10:12 +0300
Message-ID: <49B7F074.2080807@ru.mvista.com>
References: <20090220171139.25429.26702.sendpatchset@localhost.localdomain> <20090220171236.25429.25264.sendpatchset@localhost.localdomain> <49B52AE3.1030209@ru.mvista.com> <200903111736.26177.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:5070 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751884AbZCKRJd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Mar 2009 13:09:33 -0400
In-Reply-To: <200903111736.26177.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>Move ide_map_sg() call from ->dma_setup implementations
>>>and ide_destroy_dmatable() one from *_build_dmatable() to
>>>ide_dma_prepare().

>>>There should be no functional changes caused by this patch.

>>>Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

>>[...]
>>
>>>Index: b/drivers/ide/au1xxx-ide.c
>>>===================================================================
>>>--- a/drivers/ide/au1xxx-ide.c
>>>+++ b/drivers/ide/au1xxx-ide.c
>>>@@ -272,9 +272,7 @@ static int auide_build_dmatable(ide_driv
>>> 	if (count)
>>> 		return 1;
>>> 
>>>- use_pio_instead:
>>>-	ide_destroy_dmatable(drive);
>>>-
>>>+use_pio_instead:

>>   Could you please get rid of goto and label too, while at it?

> Sorry but since this patch has been already merged

    Merged where?!

> it would be too much work/noise for too little gain IMO.

    Will you take a reworked patch from me?

MBR, Sergei
