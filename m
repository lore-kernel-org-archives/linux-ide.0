From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 8/9] qd65xx: return error value in qd_probe()
Date: Mon, 18 Feb 2008 20:00:51 +0300
Message-ID: <47B9B9C3.9060903@ru.mvista.com>
References: <20080216202634.25536.78915.sendpatchset@localhost.localdomain> <20080216202722.25536.36800.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:55117 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751799AbYBRQ7w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Feb 2008 11:59:52 -0500
In-Reply-To: <20080216202722.25536.36800.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Return error value in qd_probe() and use it in qd65xx_init()
> instead of checking ide_hwifs[].chipset.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
