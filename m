From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] libata: always use polling SETXFER
Date: Wed, 14 Mar 2007 15:09:45 +0100
Message-ID: <200703141509.45652.bzolnier@gmail.com>
References: <20070314053338.GA15600@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:18273 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030860AbXCNOCh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Mar 2007 10:02:37 -0400
Received: by ug-out-1314.google.com with SMTP id 44so595386uga
        for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 07:02:35 -0700 (PDT)
In-Reply-To: <20070314053338.GA15600@htj.dyndns.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, pmhahn@titan.lahn.de, flyboy@gmail.com


On Wednesday 14 March 2007, Tejun Heo wrote:
> Several people have reported LITE-ON LTR-48246S detection failed
> because SETXFER fails.  It seems the device raises IRQ too early after
> SETXFER.  This is controller independent.  The same problem has been
> reported for different controllers.
> 
> So, now we have pata_via where the controller raises IRQ before it's
> ready after SETXFER and a device which does similar thing.  This patch
> makes libata always execute SETXFER via polling.  As this only happens
> during EH, performance impact is nil.  Setting ATA_TFLAG_POLLING is
> also moved from issue hot path to ata_dev_set_xfermode() - the only
> place where SETXFER can be issued.
> 
> Jeff Garzik suggests that, in the long term, it might be better to
> modify libata HSM implementation such that we're more tolerant of
> erratic ATAPI IRQ behavior - e.g. default to IRQ but falling back to
> polling if the device doesn't seem ready at the point of interrupt.
> Such change might be necessary to support ancient/weird ATAPI devices.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
