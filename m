From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 13/13] ide: merge ->dma_host_{on,off} methods into ->dma_host_set
 method
Date: Wed, 14 Nov 2007 19:38:11 +0300
Message-ID: <473B2473.4050301@ru.mvista.com>
References: <200711130002.25301.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:47165 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756451AbXKNQiD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 11:38:03 -0500
In-Reply-To: <200711130002.25301.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Merge ->dma_host_{on,off} methods into ->dma_host_set method
> which takes 'int on' argument.

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
