From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: call udma_filter() before resorting to the UltraDMA
 mask
Date: Sat, 15 Sep 2007 21:15:58 +0400
Message-ID: <46EC134E.6040901@ru.mvista.com>
References: <200709152042.37892.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:59438 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752625AbXIORMm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Sep 2007 13:12:42 -0400
In-Reply-To: <200709152042.37892.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

I wrote:

> Give the udma_filter() method call taking precedence over using the mode masks.

    I definitely need to be "talking" less (and doing more :-).

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
