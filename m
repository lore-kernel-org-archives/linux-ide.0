From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH pata-2.6] sl82c105: add speedproc() method and MWDMA0/1
 support
Date: Wed, 04 Apr 2007 23:53:35 +0400
Message-ID: <4614023F.90809@ru.mvista.com>
References: <200702140043.25244.sshtylyov@ru.mvista.com> <200702231913.55522.sshtylyov@ru.mvista.com> <200703290024.32035.sshtylyov@ru.mvista.com> <200704042138.25049.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:49420 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with SMTP id S2993036AbXDDTwh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Apr 2007 15:52:37 -0400
In-Reply-To: <200704042138.25049.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>Add the speedproc() method for setting transfer modes, modify config_for_dma()
>>to call it and use ide_max_dma_mode() to select the best DMA mode.
>>Add support for the multiword DMA modes 0 and 1, using the upper half of the
>>'drive_data' field to store the DMA timings to program into the drive control
>>register when DMA is turned on for real.

>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> applied

    I now also have almost complete patch to merge PIO/DMA timings and so get 
rid of selectproc() there... :-)

MBR, Sergei
