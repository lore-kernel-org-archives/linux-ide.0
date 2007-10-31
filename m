From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 13/15] ide: remove hwif->intrproc
Date: Thu, 01 Nov 2007 00:15:06 +0300
Message-ID: <4728F05A.5000502@ru.mvista.com>
References: <200710310055.13329.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:42994 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760149AbXJaVO7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Oct 2007 17:14:59 -0400
In-Reply-To: <200710310055.13329.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Given that:

> * hpt366.c::hpt3xx_intrproc() is the only user of hwif->intrproc

> * hpt366.c::hpt3xx_quirkproc() sets drive->quirk_list to 1 for quirky drives
>   which is a value unique to hpt366 host driver

> we can remove hwif->intproc and just check for drive->quirk_list == 1
> in ide_do_request().

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> ---
> Handling of quirky drives (problems with nIEN) by hpt366 and pdc202xx_*
> looks suspicious...  are the problems really dependent on the host type
> (thus hwif->quirkproc and ->quirk_list == 1/2)?  Shouldn't we just handle
> quirky drives in the same way in the core IDE code regardless of the host
> driver being used (of course using hwif->maskproc where needed)?

    Indeed...

MBR, Sergei
