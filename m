From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/20] ide: fix ->io_32bit race in set_io_32bit()
Date: Mon, 10 Dec 2007 15:38:39 +0300
Message-ID: <475D334F.1060003@ru.mvista.com>
References: <200712092206.16225.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:47987 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752426AbXLJMiT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Dec 2007 07:38:19 -0500
In-Reply-To: <200712092206.16225.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> set_io_32bit() (ide_procset_t function) can race against running
> PIO transfers.  Fix it by using ide_spin_wait_hwgroup().

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
