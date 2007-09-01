From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/10] ide: use I/O ops directly part #2
Date: Sat, 01 Sep 2007 20:31:24 +0400
Message-ID: <46D993DC.40902@ru.mvista.com>
References: <200708292318.23393.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:49175 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755432AbXIAQ2g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Sep 2007 12:28:36 -0400
In-Reply-To: <200708292318.23393.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

    Strange I thought I've already replaced everything in hpt366.c ... 
although we could switch to using MMIO there -- at least for HPT37x chips. B-)

> Index: b/drivers/ide/pci/hpt366.c
> ===================================================================
> --- a/drivers/ide/pci/hpt366.c
> +++ b/drivers/ide/pci/hpt366.c

    Could you bump a version before committing?

MBR, Sergei
