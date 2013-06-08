From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: AHCI bug: a lockup in ahci_interrupt with fbs enabled pmp
Date: Sat, 8 Jun 2013 05:59:27 +0000
Message-ID: <43EB3AB3EEFE8D43B525F4D2EAF507E1085BB1FA@SCYBEXDAG04.amd.com>
References: <CAASYz_TkwEvVeKhcSedAfdxdGmRLnONnSrmhnHNAE2nfy3AABg@mail.gmail.com>
 <20130606214748.GL5045@htj.dyndns.org>
 <43EB3AB3EEFE8D43B525F4D2EAF507E1085BAD21@SCYBEXDAG04.amd.com>
 <20130607225639.GH14781@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [207.46.163.27] ([207.46.163.27]:40245 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750911Ab3FHGA5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jun 2013 02:00:57 -0400
In-Reply-To: <20130607225639.GH14781@mtj.dyndns.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Yu Liu <liuyu.ac@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "Huang, Shane" <Shane.Huang@amd.com>

Tejun,

> ata_link_sactive() asks whether there are commands in progress.  I
> don't think that fits in there.  Can't it just bounce to EH for actual
> error handling?  Why is the link online check necessary?

I tried hard to recall why I put ata_link_online() check there, at
last I find it was suggested by you in 2009 when you reviewed v2 :-)

http://marc.info/?l=linux-ide&m=125170571525422&w=2

Need I submit a patch to remove online check or you will handle it?

Thanks,
Shane


