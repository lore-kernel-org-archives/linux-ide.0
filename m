From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 10/11] ide-pmac: remove nIEN clearing from pmac_ide_do_setfeature()
Date: Sun, 22 Jul 2007 23:25:50 +0400
Message-ID: <46A3AF3E.1070104@ru.mvista.com>
References: <200707222033.55198.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:59975 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757951AbXGVTXs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jul 2007 15:23:48 -0400
In-Reply-To: <200707222033.55198.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Bartlomiej Zolnierkiewicz wrote:

> Upper layers are responsible for controlling nIEN so don't clear nIEN after
> command execution in pmac_ide_do_setfeature().

> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
