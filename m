From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3] ide: remove superfluous SELECT_MASK() call from do_rw_taskfile()
Date: Tue, 02 Jun 2009 20:24:42 +0400
Message-ID: <4A25524A.2040000@ru.mvista.com>
References: <200906012353.07374.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:24454 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752937AbZFBQXX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Jun 2009 12:23:23 -0400
In-Reply-To: <200906012353.07374.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> With ->write_devctl method call (which unmasks drive IRQ) preceding
> SELECT_MASK() call there is really no need for the latter.

> Moreover with the combination of HPT36x controller and the drive on
> the quirk_drives[] list this can result in superfluous enable_irq()
> call which in turn will trigger WARN() in __enable_irq().

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
