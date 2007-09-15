From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/10] cmd64x: always set hwif->chipset for CMD646
Date: Sat, 15 Sep 2007 20:54:31 +0400
Message-ID: <46EC0E47.1000102@ru.mvista.com>
References: <200709112335.54396.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:59292 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751948AbXIOQvP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Sep 2007 12:51:15 -0400
In-Reply-To: <200709112335.54396.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> hwif->chipset should be set to ide_cmd646 also when DMA base is invalid.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
