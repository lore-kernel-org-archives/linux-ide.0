From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/9] ide: move ide_dma_timeout_retry() to ide-dma.c
Date: Sat, 17 Jan 2009 23:20:52 +0300
Message-ID: <49723DA4.4@ru.mvista.com>
References: <20090115200032.17294.84745.sendpatchset@localhost.localdomain> <20090115200101.17294.76431.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:10873 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755144AbZAQUU6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Jan 2009 15:20:58 -0500
In-Reply-To: <20090115200101.17294.76431.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Move ide_dma_timeout_retry() to ide-dma.c and add static inline
> version for CONFIG_BLK_DEV_IDEDMA=n.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>   

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei


