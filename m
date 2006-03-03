From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/6] ata_piix: add a couple of flags
Date: Fri, 03 Mar 2006 15:33:45 -0500
Message-ID: <4408A829.6090805@pobox.com>
References: <11411439393863-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:11666 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932359AbWCCUdw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Mar 2006 15:33:52 -0500
In-Reply-To: <11411439393863-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jfs@keytradebank.com, 0602@eq.cz, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Add PIIX_FLAG_IGN_PRESENT and SCR flags.  Thi patch doesn't cause any
> functional change.  To be used by later init/scr updates.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Please rename PIIX_FLAG_IGN_PRESENT to PIIX_FLAG_IGNORE_PCS or 
PIIX_FLAG_IGN_PCS in an update patch.

	Jeff


