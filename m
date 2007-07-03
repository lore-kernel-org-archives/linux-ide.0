From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/1] ide: pdc202xx_new PLL input clock fix
Date: Tue, 03 Jul 2007 18:24:26 +0400
Message-ID: <468A5C1A.9060501@ru.mvista.com>
References: <7ac1e90c0706210447k7c1bdb26y43d62e930ce7728e@mail.gmail.com> <46809EA7.5090005@tw.ibm.com> <4680A773.2020009@tw.ibm.com> <200707022013.04383.bzolnier@gmail.com> <46893D48.3060801@ru.mvista.com> <4689DCF5.3040809@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:23983 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759356AbXGCOWp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 10:22:45 -0400
In-Reply-To: <4689DCF5.3040809@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bahadir Balban <bahadir.balban@gmail.com>, linux-ide@vger.kernel.org

Hello.

Albert Lee wrote:
> Recently the PLL input clock of Promise 2027x is sometimes detected
> higer than expected (e.g. 20.027 MHz compared to 16.714 MHz).
      ^ h

> It seems sometimes the mdelay() function is not as precise as it
> used to be. Per Alan's advice, HT or power management might affect
> the precision of mdelay().

> This patch calls gettimeofday() to mesure the time elapsed and
                                        ^ a
> calculate the PLL input clock accordingly.

> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

    Except for types in description:

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei ;-)
