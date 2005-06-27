From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH] libata-dev-2.6-ncq: rewrite __ata_qc_complete
Date: Mon, 27 Jun 2005 17:27:42 +0800
Message-ID: <42BFC68E.3020707@tw.ibm.com>
References: <20050626144110.GD24968@htj.dyndns.org> <42BEE593.7050004@pobox.com> <20050627082709.GO19550@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:29170 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261981AbVF0J2r (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Jun 2005 05:28:47 -0400
In-Reply-To: <20050627082709.GO19550@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org


Tejun Heo wrote:

>Also, remove spurious clearing of ATA_QCFLAG_ACTIVE from
>ata_qc_complete().
> 
Hi Tejun:

Clearing the ATA_QCFLAG_ACTIVE in ata_qc_complete() is needed. We have to
prevent the interrupt handler from racing with the error handler in ATAPI.
(Please see the following link for the detail:
http://marc.theaimsgroup.com/?l=linux-ide&m=111476734016857&w=2)

Albert


