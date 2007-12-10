From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] hpt366: fix HPT37x PIO mode timings (take 2)
Date: Mon, 10 Dec 2007 15:33:33 +0300
Message-ID: <475D321D.9020900@ru.mvista.com>
References: <200712081838.10647.sshtylyov@ru.mvista.com> <200712091810.36063.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:47953 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754785AbXLJMdO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Dec 2007 07:33:14 -0500
In-Reply-To: <200712091810.36063.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>---
>>Many PIO modes at 55/66 MHz (as well as MDDMA modes at all clocks) are also
>>underclocked but I decided not to touch them, at least for the time being.
>>The patch is against the Linus' tree, with PIO0 setup time correct this time...

> Since it is against Linus' tree I assume that it is safe enough to be merged
> for 2.6.24, right?

    Yes, I think so. This is however, at your discretion.

MBR, Sergei
