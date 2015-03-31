From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 4/9] ide,ata: Rename ATA_IDX to ATA_SENSE
Date: Tue, 31 Mar 2015 13:07:18 -0400 (EDT)
Message-ID: <20150331.130718.2123579130252572770.davem@davemloft.net>
References: <1427471198-62676-1-git-send-email-hare@suse.de>
	<1427471198-62676-5-git-send-email-hare@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427471198-62676-5-git-send-email-hare@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: hare@suse.de
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Hannes Reinecke <hare@suse.de>
Date: Fri, 27 Mar 2015 16:46:33 +0100

> ATA-8 defines bit 1 as 'ATA_SENSE', not 'ATA_IDX'.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Acked-by: David S. Miller <davem@davemloft.net>
