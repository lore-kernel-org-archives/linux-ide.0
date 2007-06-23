From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/6] ide: make ide_get_best_pio_mode() print info if overriding
 PIO mode
Date: Sat, 23 Jun 2007 23:07:10 +0400
Message-ID: <467D6F5E.1020108@ru.mvista.com>
References: <200706232004.41342.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:15327 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754062AbXFWTF2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jun 2007 15:05:28 -0400
In-Reply-To: <200706232004.41342.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> * Print info about overriding PIO mode in ide_get_best_pio_mode().

> * Remove info about overriding PIO mode from cmd64{0,x} host drivers.

> * Remove no longer needed ide_pio_data_t.overridden field.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
