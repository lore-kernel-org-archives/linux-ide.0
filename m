From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH pata-2.6] hpt366: change timing register masks
Date: Mon, 10 Dec 2007 15:35:11 +0300
Message-ID: <475D327F.7040303@ru.mvista.com>
References: <200712082049.20731.sshtylyov@ru.mvista.com> <200712091810.40436.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:47961 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751054AbXLJMev (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Dec 2007 07:34:51 -0500
In-Reply-To: <200712091810.40436.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>Since PIO autotuning is now done always, there's no need anymore to program
>>the taskfile timings also on DMA modes, so chenge the IDE timing register
>>masks accordingly, "inverting the polarity" of the masks while at it...

>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> applied with a whitespace fix to shut up checkpatch.pl:

> ERROR: use tabs not spaces
> #66: FILE: drivers/ide/pci/hpt366.c:718:
> +^I^I^I^I ^I^I^I  0x303c0000);$

    Sorry for not running chackpatch.pl... :-<

WBR, Sergei
