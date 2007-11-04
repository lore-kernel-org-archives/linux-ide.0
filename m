From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/15] ide: remove ata_nsector_t, ata_data_t and atapi_bcount_t
Date: Sun, 04 Nov 2007 18:21:57 +0300
Message-ID: <472DE395.6050409@ru.mvista.com>
References: <200710310027.27423.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:11126 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754822AbXKDPVu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Nov 2007 10:21:50 -0500
In-Reply-To: <200710310027.27423.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Remove ata_nsector_t, ata_data_t (unused) and atapi_bcount_t.

> While at it:
> * replace 'HWIF(drive)' by 'hwif'

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
