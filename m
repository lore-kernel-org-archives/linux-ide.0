From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/12] jmicron: PIO fixes
Date: Mon, 09 Jul 2007 18:09:27 +0400
Message-ID: <46924197.6000003@ru.mvista.com>
References: <200707081536.04816.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:3023 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754341AbXGIOHZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 10:07:25 -0400
In-Reply-To: <200707081536.04816.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Set transfer mode on the device in jmicron_tuneproc(),
>   also add pio == 255 == "auto-tune" handling.

> * Use jmicron_tuneproc() in jmicron_config_drive_for_dma().

> * Remove no longer needed config_jmicron_chipset_for_pio().

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
