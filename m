From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: [PATCH v2] ahci: implement aggressive SATA device sleep support
Date: Fri, 24 Aug 2012 15:18:21 +0000
Message-ID: <43EB3AB3EEFE8D43B525F4D2EAF507E107E1A44C@SCYBEXDAG03.amd.com>
References: <1345761072-2123-1-git-send-email-shane.huang@amd.com>
 <503647B3.6050706@pobox.com>
 <43EB3AB3EEFE8D43B525F4D2EAF507E107E1A41A@SCYBEXDAG03.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:52181
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755629Ab2HXPSe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Aug 2012 11:18:34 -0400
In-Reply-To: <43EB3AB3EEFE8D43B525F4D2EAF507E107E1A41A@SCYBEXDAG03.amd.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Aaron Lu <aaron.lwe@gmail.com>, "Huang, Shane" <Shane.Huang@amd.com>

> OK, I will define ATA_ID_FEATURE_SUPP to replace all the 78.

Oh, I find you were talking about sata_settings information...
I also agree with you and will take your suggestion in v3.


Thanks,
Shane

