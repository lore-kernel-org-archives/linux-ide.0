From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: [PATCH] libata: check SATA_SETTINGS log with HW Feature Ctrl
Date: Tue, 11 Dec 2012 09:25:56 +0000
Message-ID: <43EB3AB3EEFE8D43B525F4D2EAF507E107F2FA7F@SCYBEXDAG04.amd.com>
References: <1353185081-11349-1-git-send-email-shane.huang@amd.com>
 <50BC77DA.1060401@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [213.199.154.209] ([213.199.154.209]:28405 "EHLO
	am1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751660Ab2LKJ1Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Dec 2012 04:27:16 -0500
In-Reply-To: <50BC77DA.1060401@pobox.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, "Huang, Shane" <Shane.Huang@amd.com>

Jeff,

> > This patch is not tested on SATA HDD with DevSlp supported.
> >
> > Reported-by: Borislav Petkov <bp@amd64.org>
> > Signed-off-by: Shane Huang <shane.huang@amd.com>
> > ---
> >   drivers/ata/libata-core.c |    3 +--
> >   include/linux/ata.h       |    1 +
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> applied

Please suspend this patch because I just received two new
DevSlp drives but found word 78 bit 5 is _not_ set.

I'm checking with the drive vendor whether he gave me
the wrong information. If bit 5 is not the necessary and
sufficient condition, I will implement another patch to
replace ata_device->sata_settings into ->devslp_timing.

Thanks,
Shane

