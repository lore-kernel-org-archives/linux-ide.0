From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/8] amd74xx/via82cxxx: don't initialize drive->dn
Date: Fri, 28 Sep 2007 16:07:00 +0400
Message-ID: <46FCEE64.8030003@ru.mvista.com>
References: <200708271927.21528.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:44667 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752736AbXI1MHS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Sep 2007 08:07:18 -0400
In-Reply-To: <200708271927.21528.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> drive->dn is initialized by ide-probe.c::probe_hwif() so no need to do it
> in ->init_hwif method.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
