From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/6] icside: fix ->speedproc to return on unsupported
 modes
Date: Wed, 11 Jul 2007 23:07:51 +0400
Message-ID: <46952A87.6010005@ru.mvista.com>
References: <200707110200.37607.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:27307 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S933008AbXGKTFu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Jul 2007 15:05:50 -0400
In-Reply-To: <200707110200.37607.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>

Hello.

Bartlomiej Zolnierkiewicz wrote:

> icside_set_speed() happily accepts unsupported transfer modes which
> results in drive->drive_data being set to the maximum value (480)
> and drive->current_speed being set to the unsupported transfer mode.

> Fix it.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
