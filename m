From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 10/12] ide: move ide_rate_filter() calls to the upper
 layer
Date: Tue, 10 Jul 2007 17:03:02 +0400
Message-ID: <46938386.5010709@ru.mvista.com>
References: <200707081539.14463.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:13281 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751213AbXGJNBA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 09:01:00 -0400
In-Reply-To: <200707081539.14463.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> * Move ide_rate_filter() calls from host drivers to IDE core.

> * Make ide_rate_filter() static.

> * Make 'speed' argument of ->speedproc const.

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
