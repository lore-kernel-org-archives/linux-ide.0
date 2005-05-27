From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] SATA NCQ support
Date: Fri, 27 May 2005 04:24:17 -0400
Message-ID: <4296D931.70203@pobox.com>
References: <20050527070353.GL1435@suse.de> <4296CAA8.9060307@pobox.com> <20050527073016.GO1435@suse.de> <4296CE3B.3040504@pobox.com> <20050527074712.GQ1435@suse.de> <20050527075621.GR1435@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:59101 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262018AbVE0IYT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 May 2005 04:24:19 -0400
In-Reply-To: <20050527075621.GR1435@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Actually, slight "problem" there as well... We need to translate the
> SCSI command prior to making this decision, as we may get both NCQ and
> non-NCQ commands from that path as well. For now I'll just make the
> distinction that fs based SCSI requests are the only NCQ candidates, ok?

that's fine.

	Jeff


