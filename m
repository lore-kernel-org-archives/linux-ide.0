From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/n] libata-core.c conversion to new debugging scheme,
 part 1 (25% done)
Date: Sun, 11 Jun 2006 23:48:37 -0400
Message-ID: <448CE415.6070901@pobox.com>
References: <20060531054633.GA4875@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:897 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750790AbWFLDsk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jun 2006 23:48:40 -0400
In-Reply-To: <20060531054633.GA4875@zmei.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-ide@vger.kernel.org

Borislav Petkov wrote:
> This patch converts the first 25% of libata-core.c to the new debugging scheme.
> 
> Signed-off-by: <petkov@uni-muenster.de>

After I hand-applied a lot of this, and looked at the result, I would 
request further updates:

1) The message level order is a bit off.  Following the original 
Becker-designed strategy (netif.txt), the ATA_MSG_xxx bits should be 
ordered in order of verbosity, where that order is passed to 
ata_msg_init() from the user.

This implies that that ATA_MSG_ERR (the most important) should be 0x1, 
_WARN should be 0x2, PROBE(?), DRV(?), and so on.

2) rediff and resend this "part 1" patch against the latest 
libata-dev.git#upstream, which looked mostly OK

	Jeff


