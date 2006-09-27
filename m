From: Jeff Garzik <jeff@garzik.org>
Subject: Re: SATA: Marvell 88SE6141 kernel support?
Date: Wed, 27 Sep 2006 05:33:25 -0400
Message-ID: <451A4565.2080601@garzik.org>
References: <393855126.1159346763423.JavaMail.root@fepweb13>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35755 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965474AbWI0Jd2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Sep 2006 05:33:28 -0400
In-Reply-To: <393855126.1159346763423.JavaMail.root@fepweb13>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: genestapp@charter.net
Cc: linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

genestapp@charter.net wrote:
> I talked to Gord Peters who asked about this sata chip in June. He said there is a experimental patch for it, but the one he had was an old version. I've been looking all over but could not find it. Also I've checked the newest linux kernel builds and there is no mention of mv_61x support. Does anyone know the status of kernel support for this chip? I'm running 2.6.17 kernel currently but will be upgrading to .18 on Thursday (FC5)
> 
> I'm using the Asus P5WD2-E motherboard. I've already used the 4 sata ports on the ICH7 chip and I'm looking to expand my software raid 5 array with a couple more drives (and more later).
> For reference, this was the earlier thread from archives:
> http://lkml.org/lkml/2006/6/14/259

This chip is vastly different from sata_mv.

For the SATA portion (not PATA), you might have some luck adding your 
PCI ID to ahci.c.  Give that a try, and let us know if it works or 
explodes :)

Other than that, no progress at all to report.  Marvell just provided 
the documentation to me, but I've made no progress yet.

	Jeff



