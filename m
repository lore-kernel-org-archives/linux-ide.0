From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: always use polling SETXFER
Date: Mon, 30 Apr 2007 09:45:33 +0900
Message-ID: <46353C2D.6030503@gmail.com>
References: <20070314053338.GA15600@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:4230 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140AbXD3DAC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Apr 2007 23:00:02 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1792007nzf
        for <linux-ide@vger.kernel.org>; Sun, 29 Apr 2007 20:00:01 -0700 (PDT)
In-Reply-To: <20070314053338.GA15600@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, pmhahn@titan.lahn.de, flyboy@gmail.com

Tejun Heo wrote:
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

Jeff, ping.

-- 
tejun

