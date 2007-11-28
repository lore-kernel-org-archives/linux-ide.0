From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/6] au1xxx-ide: au_ide_probe() fixes
Date: Wed, 28 Nov 2007 21:27:41 +0100
Message-ID: <200711282127.41245.bzolnier@gmail.com>
References: <200711272355.33053.bzolnier@gmail.com> <474D5895.60203@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:16022 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbXK1Uab (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 15:30:31 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1615277ugc
        for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2007 12:30:30 -0800 (PST)
In-Reply-To: <474D5895.60203@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Wednesday 28 November 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * hwif->hold is always set in au_ide_probe() (few lines earlier),
> >   no need to set it again
> 
> > * hwif->{channel,select_data,config_data} should be always zero
> 
> > * autotune PIO also if CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_BDMA is not defined
> 
>     You mean "also if CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA is defined"?

Yes, fixed.

Thanks,
Bart
