From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 5/7] ide: remove chipset field from hw_regs_t
Date: Thu, 14 May 2009 21:08:20 +0400
Message-ID: <4A0C5004.9040904@ru.mvista.com>
References: <20090513205139.28638.87226.sendpatchset@localhost.localdomain> <20090513205215.28638.80164.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:9128 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757895AbZENRHl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 May 2009 13:07:41 -0400
In-Reply-To: <20090513205215.28638.80164.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Convert host drivers that still use hw_regs_t's chipset field to use
>   the one in struct ide_port_info instead.

> * Move special handling of ide_pci chipset type from ide_hw_configure()
>   to ide_init_port().

> * Remove chipset field from hw_regs_t.

> While at it:
> - remove stale comment in delkin_cb.c

> There should be no functional changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
