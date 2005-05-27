From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Playing with SATA NCQ
Date: Fri, 27 May 2005 04:23:32 -0400
Message-ID: <4296D904.4070406@pobox.com>
References: <20050526140058.GR1419@suse.de> <4295F87B.9070106@pobox.com> <20050527072046.GN1435@suse.de> <4296CC5C.5000807@pobox.com> <20050527073307.GP1435@suse.de> <4296D16F.9030805@pobox.com> <20050527080014.GS1435@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:57565 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261990AbVE0IXi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 May 2005 04:23:38 -0400
In-Reply-To: <20050527080014.GS1435@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Ok, lets get that fixed then... Would you like just a single
> ap->queue_depth and a ATA_DFLAG_NCQ_IN_FLIGHT type flag instead?

works for me

	Jeff


