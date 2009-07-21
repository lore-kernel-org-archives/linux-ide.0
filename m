From: Tejun Heo <teheo@novell.com>
Subject: Re: [PATCH #upstream-fixes 1/2] libata: cosmetic updates
Date: Wed, 22 Jul 2009 00:32:34 +0900
Message-ID: <4A65DF92.5050305@novell.com>
References: <4A65DAD9.8050001@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:45805 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbZGUPcr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Jul 2009 11:32:47 -0400
In-Reply-To: <4A65DAD9.8050001@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Marcus Meissner <meissner@novell.com>

Tejun Heo wrote:
> We're about to add more SATA_* and ATA_ACPI_FILTER_* constants.
> Reformat them in preparation.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

I was about to send the second patch which filters out the offending
commands by default but now that I think more about it I think it
would be better to specifically blacklist the machine.  So, please
don't commit the first patch.  I'll re-post later along with updated
patch.

Thanks.

-- 
tejun
