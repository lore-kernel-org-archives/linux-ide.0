From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 5/5] via82cxxx: backport short cables support from pata_via.c
Date: Tue, 26 Jun 2007 22:25:18 +0400
Message-ID: <46815A0E.3030403@ru.mvista.com>
References: <200706101558.39306.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:41268 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758661AbXFZSXe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Jun 2007 14:23:34 -0400
In-Reply-To: <200706101558.39306.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:
> Backport short cables support from pata_via.c.
> 
> This patch should allow UDMA > 2 modes on Acer Ferrari 3400.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
