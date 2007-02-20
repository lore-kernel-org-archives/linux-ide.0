From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.20-mm2
Date: Tue, 20 Feb 2007 16:46:57 -0500
Message-ID: <45DB6C51.1080202@garzik.org>
References: <20070217215146.30e7ffa3.akpm@linux-foundation.org> <6bffcb0e0702190345p33f4832epec92656fff087f57@mail.gmail.com> <200702200104.57200.rjw@sisk.pl> <200702202216.03744.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47959 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030459AbXBTVrF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Feb 2007 16:47:05 -0500
In-Reply-To: <200702202216.03744.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-kernel@vger.kernel.org, Neil Brown <neilb@suse.de>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

Rafael J. Wysocki wrote:
> FWIW, with CONFIG_PREEMPT unset (CONFIG_PREEMPT_VOLUNTARY is set instead), I'm
> unable to reproduce this problem on the box on which it is readily reproducible with
> CONFIG_PREEMPT set.

I'm not surprised...  I routinely tell people to turn it off, when 
debugging a problem.

	Jeff



