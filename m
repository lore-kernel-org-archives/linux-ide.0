From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 02/10] ide: inline ide_dma_timeout() into ide_dma_timeout_retry()
Date: Mon, 09 Mar 2009 01:18:16 +0300
Message-ID: <49B44428.7070605@ru.mvista.com>
References: <20090220171139.25429.26702.sendpatchset@localhost.localdomain> <20090220171154.25429.24988.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:6013 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753521AbZCHWSX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Mar 2009 18:18:23 -0400
In-Reply-To: <20090220171154.25429.24988.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Since ide_dma_timeout() is only used by ide_dma_timeout_retry()
> inline it there.
>
> There should be no functional changes caused by this patch.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei


