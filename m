From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: [PATCH] libata: replace sata_settings with devslp_timing
Date: Wed, 26 Dec 2012 02:29:14 +0000
Message-ID: <43EB3AB3EEFE8D43B525F4D2EAF507E107F3F0FC@SCYBEXDAG04.amd.com>
References: <1355757539-4529-1-git-send-email-shane.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [216.32.181.184] ([216.32.181.184]:37829 "EHLO
	ch1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752807Ab2LZCaO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Dec 2012 21:30:14 -0500
In-Reply-To: <1355757539-4529-1-git-send-email-shane.huang@amd.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, "kou1.ono@gmail.com" <kou1.ono@gmail.com>, Tom Rini <tom.rini@gmail.com>, "jlee@suse.com" <jlee@suse.com>, "Huang, Shane" <Shane.Huang@amd.com>

Jeff,

> NCQ capability was used to check availability of SATA Settings page
> from Identify Device Data Log, which contains DevSlp timing variables.
> It does not work on some HDDs and leads to error messages.
> 
> IDENTIFY word 78 bit 5(Hardware Feature Control) can't work either
> because it is only the sufficient condition of Identify Device data
> log, not the necessary condition.
> 
> This patch replaced ata_device->sata_settings with ->devslp_timing
> to only save DevSlp timing variables(8 bytes), instead of the whole
> SATA Settings page(512 bytes).
> 
> Reported-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Shane Huang <shane.huang@amd.com>
> Cc: stable@kernel.org

Happy holidays!

Do you have comments to this patch? It also fixed bugzilla #51881
reported and verified by Kouichi.

Please also help to apply it into the stable tree.

Thanks,
Shane


