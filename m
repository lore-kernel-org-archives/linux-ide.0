From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.22-rc5] libata: kill the infamous abnormal status
 message
Date: Mon, 25 Jun 2007 13:42:45 +0100
Message-ID: <20070625134245.4aa71c53@the-village.bc.nu>
References: <467FB589.2060900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49507 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752035AbXFYMg5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jun 2007 08:36:57 -0400
In-Reply-To: <467FB589.2060900@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Mon, 25 Jun 2007 21:31:05 +0900
Tejun Heo <htejun@gmail.com> wrote:

> The infamous abnormal status message triggers on not so abnormal cases
> including empty port and even when it's being triggered on actual
> errors the info it provides is redundant and out of context - higher
> level functions will print the info in better safe later anyway.
> 
> Also, by being triggered all the time, it leads people to think that
> the abnormality is somehow related to all ATA and system problems
> they're experiencing and gives owners of healthy systems unfounded
> doubts about the integrity of the universe.  Make it a DPRINTK and
> save the universe.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>
