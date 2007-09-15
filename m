From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/10] rz1000: set serialized flag only if mate interface
 exists
Date: Sat, 15 Sep 2007 21:01:13 +0400
Message-ID: <46EC0FD9.7040007@ru.mvista.com>
References: <200709112337.07455.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:59344 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750780AbXIOQ55 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Sep 2007 12:57:57 -0400
In-Reply-To: <200709112337.07455.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Setting hwif->serialized makes sense only if the mate interface exists.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
