From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 5/11] ide: remove drive->init_speed zeroing
Date: Mon, 06 Aug 2007 00:24:03 +0400
Message-ID: <46B631E3.8030703@ru.mvista.com>
References: <200708042208.32014.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:64182 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752019AbXHEUWB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Aug 2007 16:22:01 -0400
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP id B53673EF2
	for <linux-ide@vger.kernel.org>; Sun,  5 Aug 2007 13:21:59 -0700 (PDT)
In-Reply-To: <200708042208.32014.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Several host drivers used to reset drive->init_speed in their ->ide_dma_check
> implementations which resulted in incorrect init speed being reported to the
> user, fix it.

    What do you mean by incorrect?  Weren't they doing that intentionally to
report DMA mode instead of PIO?  Won't PIO mode be always reported now since
all drivers are being moved to always autotuning PIO?

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

WBR, Sergei

