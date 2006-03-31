From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] libata: fix ata_qc_issue failure path
Date: Fri, 31 Mar 2006 10:16:24 -0500
Message-ID: <442D47C8.8030609@pobox.com>
References: <20060331113647.GD13172@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40634 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751318AbWCaPQ1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 10:16:27 -0500
In-Reply-To: <20060331113647.GD13172@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> On sg_err failure path, ata_qc_issue() doesn't mark the qc active
> before returning.  This triggers WARN_ON() in __ata_qc_complete() when
> the qc gets completed.  This patch moves ap->active_tag and
> QCFLAG_ACTIVE setting to the top of the function.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied 1-2, but two comments:

* this patch widens the race window for the remaining unlocked uses of 
ATA_QCFLAG_ACTIVE

* in the current code, its questionable whether ATA_QCFLAG_ACTIVE has 
much value.  The flag may have more value after your EH work, but its 
not terribly important in the current #upstream.

	Jeff


