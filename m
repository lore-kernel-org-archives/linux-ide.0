From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: [PATCH RESEND] ahci: implement aggressive SATA device sleep
 support
Date: Sun, 19 Aug 2012 15:48:13 +0000
Message-ID: <43EB3AB3EEFE8D43B525F4D2EAF507E107E16A3C@SCYBEXDAG03.amd.com>
References: <1344361476-2154-1-git-send-email-shane.huang@amd.com>
 <502E8507.8060806@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:37667
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753364Ab2HSPs1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Aug 2012 11:48:27 -0400
In-Reply-To: <502E8507.8060806@pobox.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Aaron Lu <aaron.lwe@gmail.com>, "Huang, Shane" <Shane.Huang@amd.com>

Hi Jeff,

Thanks for your feedback.

> * for the !sleep case, don't writel() if the devslp value is unchanged

You are right, I will fix it in v2 together with some other improvements.

> * if we are disabling sleep -- a valid case where host & device both 
> support it, but policy denies it -- do we need to stop the ahci engine 
> as is done in the enabling case?

The spec said that software shall only set DITO, MDAT, DETO when
PxCMD.ST is cleared to 0. While disabling case doesn't need stop
engine because the above requirement is unnecessary for ADSE.
Please tell me if you have concern.


Regards
Shane

