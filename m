From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/3] libata: set default cbl in probeinit
Date: Tue, 11 Apr 2006 12:40:02 -0400
Message-ID: <443BDBE2.7010800@pobox.com>
References: <11447614043099-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59779 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750827AbWDKQkP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 12:40:15 -0400
In-Reply-To: <11447614043099-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Make setting CBL type responsibility of probeinit.  This allows using
> only ap->cbl == ATA_CBL_SATA test in all other parts.  Without this,
> ata_down_sata_spd_limit() doesn't work during probe reset.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied 1-3


