From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] speed up SATA
Date: Mon, 29 Mar 2004 15:13:35 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4068836F.2050503@pobox.com>
References: <4066021A.20308@pobox.com> <20040329113641.GE1453@openzaurus.ucw.cz> <Pine.LNX.4.58.0403291042370.19679@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49037 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263131AbUC2UNt
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Mar 2004 15:13:49 -0500
In-Reply-To: <Pine.LNX.4.58.0403291042370.19679@dlang.diginsite.com>
List-Id: linux-ide@vger.kernel.org
To: David Lang <david.lang@digitalinsight.com>
Cc: Pavel Machek <pavel@suse.cz>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

David Lang wrote:
> Pavel, when you say that 32MB would be 1 second is that due to the limits
> of the SATA bus or are you baseing this on a particular drive?
> 
> if you are basing it on a current single SATA drive (7200rpm 8MB cache,
> etc) consider that if you are writing to a solid state drive or to an
> array that presents itself as a single SATA drive then the transaction can
> happen MUCH faster.
> 
> if this is a limit of the SATA interface bitrate, consider that over the
> last several years EVERY interface has seen it's bitrate climb
> significantly, frequently with little (if any) fundamentalchange to the
> drivers nessasary to run things.

Sata-1 is 1.5Gbps, and Sata-2 is 3.0Gbps.  6.0Gbps is the next step 
people seem to be working on...

	Jeff




