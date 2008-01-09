From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/15] ide: move wait_hwif_ready() documentation in the
 right place
Date: Wed, 09 Jan 2008 20:53:07 +0300
Message-ID: <47850A03.5090805@ru.mvista.com>
References: <20080104212424.6978.93646.sendpatchset@localhost.localdomain> <20080104212439.6978.95269.sendpatchset@localhost.localdomain> <478508BD.9030307@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:37102 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752306AbYAIRwQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 12:52:16 -0500
In-Reply-To: <478508BD.9030307@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi, I wrote:

>> * Move wait_hwif_ready() documentation before this function.

>> * Fix trailing whitespaces.

>> * s/wait-for-busy/wait-for-non-busy/

>> * Remove no longer valid comment about the current code behavior.

>> * Docbook-ize it.

>> * Rename wait_hwif_ready() to ide_port_wait_ready().

>> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

    Oops, forgot to stamp:

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
