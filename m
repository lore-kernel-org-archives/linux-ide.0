From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/15] ide: remove ata_status_t and atapi_status_t
Date: Fri, 09 Nov 2007 16:46:30 +0300
Message-ID: <473464B6.6070905@ru.mvista.com>
References: <200710310025.04369.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:1206 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754516AbXKINqR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Nov 2007 08:46:17 -0500
In-Reply-To: <200710310025.04369.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Remove ata_status_t (unused) and atapi_status_t.

> While at it:
> * replace 'HWIF(drive)' by 'drive->hwif' (or just 'hwif' where possible)

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
