From: Olaf Hering <olh@suse.de>
Subject: Re: Organized summary of the pacthes
Date: Thu, 30 Jun 2005 19:10:59 +0200
Message-ID: <20050630171059.GA18362@suse.de>
References: <42C12A10.8030308@tw.ibm.com> <42C16AFC.7010908@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:24290 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262839AbVF3RLG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jun 2005 13:11:06 -0400
Content-Disposition: inline
In-Reply-To: <42C16AFC.7010908@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, doug_maxey@us.ibm.com, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

 On Tue, Jun 28, Jeff Garzik wrote:

> >=======
> >4. ata_qc_complete() race condition fix.
> >  => In ata_qc_complete(),
> >     "qc->flags &= ~ATA_QCFLAG_ACTIVE;" should be _before_
> >     "rc = qc->complete_fn(qc, drv_stat);".
> 
> I agree.

Does it need a membarrier as well?
