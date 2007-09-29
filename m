From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/13] aec62xx: no need to disable UDMA in ->init_hwif
 method for ATP850UF
Date: Sat, 29 Sep 2007 23:27:21 +0400
Message-ID: <46FEA719.8020204@ru.mvista.com>
References: <200709052350.36494.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:56685 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750985AbXI2T1i (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Sep 2007 15:27:38 -0400
In-Reply-To: <200709052350.36494.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * No need to disable UDMA in ->init_hwif method for ATP850UF (and since we
>   now always tune PIO it will be disabled by ->set_pio_mode calls anyway).

    Indeed. The set_mode() methods there still should get rewrtten...

> * Bump driver version.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
