From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: add ide_dev_has_iordy() helper (take 4)
Date: Mon, 02 Jul 2007 18:27:25 +0400
Message-ID: <46890B4D.7050604@ru.mvista.com>
References: <200707010044.55052.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:15148 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758086AbXGBOZo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 10:25:44 -0400
In-Reply-To: <200707010044.55052.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

Hello.

Bartlomiej Zolnierkiewicz wrote:
> * Add ide_dev_has_iordy() helper and use it sl82c105 host driver.

> * Remove no longer needed ide_pio_data_t.use_iordy field.

> v2/v3:
> * Fix issues noticed by Sergei:
>   - correct patch description
>   - fix comment in ide_get_best_pio_mode()

> v4:
> * Fix "ata_" prefix (Noticed by Jeff).

    I've noticed it first! ;-)

MBR, Sergei
