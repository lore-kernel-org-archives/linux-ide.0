From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3] sis5513: always tune PIO
Date: Thu, 02 Aug 2007 23:36:37 +0400
Message-ID: <46B23245.9040301@ru.mvista.com>
References: <200708012239.18820.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:39846 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753728AbXHBTej (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Aug 2007 15:34:39 -0400
In-Reply-To: <200708012239.18820.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Always set ->autotune in init_hwif_sis5513(), this means practically
>   no change in behavior since PIO was always tuned in ->ide_dma_check
>   and >autotune was always set for ->dma_base == 0 case.

> * Bump driver version.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
