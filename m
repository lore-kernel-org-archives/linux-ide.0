From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/5] alim15x3: backport short cables support from pata_ali.c
Date: Tue, 26 Jun 2007 22:26:56 +0400
Message-ID: <46815A70.9060608@ru.mvista.com>
References: <200706101558.28262.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:41273 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752379AbXFZSZL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Jun 2007 14:25:11 -0400
In-Reply-To: <200706101558.28262.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Backport short cables support from pata_ali.c and while at it cleanup
> existing cable detection code.

> This patch should allow UDMA > 2 modes on HP Pavilion N5430 and Fujitsu P2000.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
