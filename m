From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 12/63] ide-cd: fix "missing data" handling in cdrom_pc_intr()
Date: Fri, 21 Dec 2007 15:12:17 +0300
Message-ID: <476BADA1.9040209@ru.mvista.com>
References: <200712200201.31860.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:30287 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751651AbXLUML4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Dec 2007 07:11:56 -0500
In-Reply-To: <200712200201.31860.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> If drive still wants to transfer the data we need to pad the transfer
> instead of just finishing the request.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
