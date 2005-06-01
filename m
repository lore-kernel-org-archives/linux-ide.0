From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] AHCI PCI MSI support, update 1
Date: Wed, 01 Jun 2005 01:46:27 -0400
Message-ID: <429D4BB3.6080903@pobox.com>
References: <429C8978.4060601@pobox.com> <20050601054422.GA1441@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:32133 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261277AbVFAFqg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Jun 2005 01:46:36 -0400
In-Reply-To: <20050601054422.GA1441@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Jens Axboe wrote:
> System boots and works fine (typing this message here), MSI is enabled.
> I double checked with an added printk :-)

Any chance you could post a full /proc/interrupts output for this box?


> So that's at least one ACK for you. Now running NCQ and MSI enabled
> ahci, I'm not sure SATA gets any better!

<grin>

Thanks,

	Jeff


