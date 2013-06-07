From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: AHCI bug: a lockup in ahci_interrupt with fbs enabled pmp
Date: Fri, 7 Jun 2013 04:29:47 +0000
Message-ID: <43EB3AB3EEFE8D43B525F4D2EAF507E1085BAD21@SCYBEXDAG04.amd.com>
References: <CAASYz_TkwEvVeKhcSedAfdxdGmRLnONnSrmhnHNAE2nfy3AABg@mail.gmail.com>
 <20130606214748.GL5045@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:57159
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750898Ab3FGE35 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Jun 2013 00:29:57 -0400
In-Reply-To: <20130606214748.GL5045@htj.dyndns.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Yu Liu <liuyu.ac@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "Huang, Shane" <Shane.Huang@amd.com>

> Yeah, it's a bug.  ata_link_online() can't be called from interrupt
> handlers.  Shane?  Can you please look into it?  What's the purpose
> of ata_link_online() in ahci_error_intr()?

ata_link_online() was used to check that pmp link is active...
which should be replaced by ata_link_active()?


Thanks,
Shane


