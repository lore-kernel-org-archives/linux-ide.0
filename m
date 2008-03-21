From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 7/7] au1xxx-ide: use ->init_dma method
Date: Fri, 21 Mar 2008 21:26:11 +0300
Message-ID: <47E3FDC3.7080208@ru.mvista.com>
References: <200803091633.39456.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.mvista.com ([63.81.120.155]:4340 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753106AbYCUSYw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 Mar 2008 14:24:52 -0400
In-Reply-To: <200803091633.39456.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Pass 'ide_hwif_t *hwif' instead of '_auide_hwif *auide' to
>   auide_ddma_init().

> * Add 'const struct ide_port_info *d' argument to auide_ddma_init().

> * Convert the driver to use ->init_dma method.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
