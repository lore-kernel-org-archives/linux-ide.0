From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/6] ide: set hwif->expiry prior to calling [__]ide_set_handler()
Date: Mon, 16 Mar 2009 17:23:09 +0300
Message-ID: <49BE60CD.3030302@ru.mvista.com>
References: <20090209231945.32406.14874.sendpatchset@localhost.localdomain> <20090209232005.32406.20153.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:39181 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756145AbZCPOW0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Mar 2009 10:22:26 -0400
In-Reply-To: <20090209232005.32406.20153.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Set hwif->expiry prior to calling [__]ide_set_handler()
>   and drop 'expiry' argument.

> * Set hwif->expiry to NULL in ide_{timer_expiry,intr}()
>   and remove 'hwif->expiry = NULL' assignments.

> There should be no functional changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
