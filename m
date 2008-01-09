From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/15] ide: move wait_hwif_ready() documentation in the
 right place
Date: Wed, 09 Jan 2008 20:47:41 +0300
Message-ID: <478508BD.9030307@ru.mvista.com>
References: <20080104212424.6978.93646.sendpatchset@localhost.localdomain> <20080104212439.6978.95269.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:37060 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753361AbYAIRqu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 12:46:50 -0500
In-Reply-To: <20080104212439.6978.95269.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

HNY. :-)

Bartlomiej Zolnierkiewicz wrote:

> * Move wait_hwif_ready() documentation before this function.

> * Fix trailing whitespaces.

> * s/wait-for-busy/wait-for-non-busy/

> * Remove no longer valid comment about the current code behavior.

> * Docbook-ize it.

> * Rename wait_hwif_ready() to ide_port_wait_ready().

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

MBR, Sergei
