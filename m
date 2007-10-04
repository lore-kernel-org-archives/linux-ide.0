From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 5/10] ide: add hwif_register_devices() helper
Date: Thu, 04 Oct 2007 20:19:33 +0400
Message-ID: <47051295.3040507@ru.mvista.com>
References: <200709112338.21389.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:47911 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756545AbXJDQTw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 12:19:52 -0400
In-Reply-To: <200709112338.21389.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Add hwif_register_devices() helper to fix code duplication between
> probe_hwif_init_with_fixup() and ideprobe_init().  Also remove stale
> comment while at it.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
