From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-2.6] AHCI: fix fatal error int handling
Date: Thu, 10 Mar 2005 00:45:07 -0500
Message-ID: <422FDEE3.5090306@pobox.com>
References: <20050309205714.DBED014FA3@lns1032.lss.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4261 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261710AbVCJFpW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Mar 2005 00:45:22 -0500
In-Reply-To: <20050309205714.DBED014FA3@lns1032.lss.emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brett Russ <russb@emc.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Brett Russ wrote:
> I noticed that the AHCI CI (cmd issue) reg wasn't getting cleared
> after error ints resulting in no further commands being successfully
> issued to the port.  This patch fixes.  All that's really needed is
> the 1's complement but I also removed the disabling/enabling of the
> FIS_RX b/c this isn't spec'd as necessary when handling error ints.
> 
> Signed-off-by: Brett Russ <russb@emc.com>

Thanks, applied.


