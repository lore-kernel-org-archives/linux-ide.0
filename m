From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 9/12] sis5513: add ->udma_filter method for chipset_family
 >= ATA_133
Date: Thu, 12 Jul 2007 20:25:16 +0400
Message-ID: <469655EC.3090303@ru.mvista.com>
References: <200707081538.32621.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:35681 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755933AbXGLQXQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jul 2007 12:23:16 -0400
In-Reply-To: <200707081538.32621.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> * Add sis5513_ata133_udma_filter() for chipset_family >= ATA_133,
>   use it to filter UDMA6 mode if ATA133 bit is disabled.

> * Remove no longer needed UDMA6 limiting logic from sis5513_tune_chipset().

> * Bump driver version.

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
