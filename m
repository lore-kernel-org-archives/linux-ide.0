From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 14/15] ide: remove dead code from ide_driveid_update()
Date: Tue, 02 Oct 2007 17:20:06 +0400
Message-ID: <47024586.6010201@ru.mvista.com>
References: <200710012341.23176.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:22469 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751885AbXJBNUY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 09:20:24 -0400
In-Reply-To: <200710012341.23176.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Remove dead code from ide_driveid_update().

> While at it:

> * Remove useless comment.

> * s/HWIF(drive)/drive->hwif/

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
