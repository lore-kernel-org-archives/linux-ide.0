From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/6] au1xxx-ide: au_ide_probe() fixes
Date: Wed, 28 Nov 2007 15:01:25 +0300
Message-ID: <474D5895.60203@ru.mvista.com>
References: <200711272355.33053.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:54054 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751467AbXK1MBM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 07:01:12 -0500
In-Reply-To: <200711272355.33053.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * hwif->hold is always set in au_ide_probe() (few lines earlier),
>   no need to set it again

> * hwif->{channel,select_data,config_data} should be always zero

> * autotune PIO also if CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_BDMA is not defined

    You mean "also if CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA is defined"?

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
