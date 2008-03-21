From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/7] palm_bk3710: use ->init_dma method
Date: Fri, 21 Mar 2008 21:29:54 +0300
Message-ID: <47E3FEA2.9080700@ru.mvista.com>
References: <200803091632.50199.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.mvista.com ([63.81.120.155]:4359 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753668AbYCUS2e (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 Mar 2008 14:28:34 -0400
In-Reply-To: <200803091632.50199.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Anton Vorontsov <avorontsov@ru.mvista.com>

Bartlomiej Zolnierkiewicz wrote:

> * Move DMA setup to palm_bk3710_init_dma().

> * Convert the driver to use ->init_dma method.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
