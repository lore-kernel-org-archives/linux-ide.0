From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Lay groundwork for ATA port multiplier support
Date: Wed, 10 Aug 2005 23:27:30 -0400
Message-ID: <42FAC5A2.4000507@pobox.com>
References: <42F7F352.2080307@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:8099 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932216AbVHKD1e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Aug 2005 23:27:34 -0400
In-Reply-To: <42F7F352.2080307@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Edward Falk <efalk@google.com>
Cc: linux-ide@vger.kernel.org, linux-kernel-daily-digest@lists.us.dell.com

Edward Falk wrote:
> This patch adds a few constants related to port multipliers to libata.h, 
> hdreg.h, and libata-core.c

In addition to my previous comment ("ata.h not hdreg.h"), grep for 
ATA_DEV_ATA and ATA_DEV_ATAPI in the code.

There are a few cases where you see code like

	if (class == ATA_DEV_ATA)
		...
	else
		...

which assume that only found, identified devices make it to that point 
in the code; ATA_DEV_NONE/UNKNOWN are guaranteed not to occur in that 
code path simply due to other code rules.

	Jeff


