From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: remove ->hold field from ide_hwif_t (take 2)
Date: Sat, 09 Feb 2008 20:48:56 +0300
Message-ID: <47ADE788.90504@ru.mvista.com>
References: <200802091854.07310.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:5231 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750804AbYBIRsE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 9 Feb 2008 12:48:04 -0500
In-Reply-To: <200802091854.07310.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> ->hold is write-only now, remove it.

> v2:
> * v1 missed bast-ide, palm_bk3710, ide-cs and delkin_cb host drivers.

    And those drivers were reading it, so it wasn't quite write-only. :-)

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
