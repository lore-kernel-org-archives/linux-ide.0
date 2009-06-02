From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/3] ide: remove superfluous SELECT_MASK() call from ide_driveid_update()
Date: Tue, 02 Jun 2009 19:47:35 +0400
Message-ID: <4A254997.1080409@ru.mvista.com>
References: <200906012352.57741.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:23486 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756681AbZFBPqR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Jun 2009 11:46:17 -0400
In-Reply-To: <200906012352.57741.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> We always call SELECT_MASK(drive, 0) after ide_dev_read_id() call
> so there is no need to do it again in the error path.

> Moreover with the combination of HPT36x controller and the drive on
> the quirk_drives[] list this can result in superfluous enable_irq()
> call which in turn will trigger WARN() in __enable_irq().

> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
