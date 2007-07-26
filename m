From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] au1xxx: fix au1xxx_set_pio_mode()
Date: Fri, 27 Jul 2007 00:20:06 +0400
Message-ID: <46A901F6.2000007@ru.mvista.com>
References: <200707262155.19693.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:37223 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755675AbXGZUSF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Jul 2007 16:18:05 -0400
In-Reply-To: <200707262155.19693.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Set transfer mode on the device before programming the host controller for
> the new timings (matches what auide_tune_chipset() is doing wrt DMA modes).

   It's not that the most other drives are doing something different... :-)

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
