From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream] libata: don't set IORDY for reset
Date: Thu, 11 Jun 2009 10:15:11 +0100
Message-ID: <20090611101511.32c5034c@lxorguk.ukuu.org.uk>
References: <4A30663D.9050008@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58462 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753526AbZFKJQA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Jun 2009 05:16:00 -0400
In-Reply-To: <4A30663D.9050008@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, gnoutchd@union.edu, constantine.gavrilov@gmail.com

On Thu, 11 Jun 2009 11:04:45 +0900
Tejun Heo <tj@kernel.org> wrote:

> Before issuing reset, libata configures xfermode to PIO0 which makes
> some drivers turn on IORDY which may cause the controller to lock up
> if the port is not occupied.  IORDY isn't necessary at this point
> anyway.  Make ata_pio_need_iordy() return zero if it's being called
> for reset.

Ewww

Acked-by: Alan Cox <alan.cox@linux.intel.com>

