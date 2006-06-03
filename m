From: Tom Wirschell <lkml@wirschell.nl>
Subject: Re: Oops when creating software RAID device (2.6.16.14).
Date: Sat, 3 Jun 2006 20:03:25 +0200
Message-ID: <20060603200325.6bdf5c6e@localhost>
References: <20060602233544.11d46664@localhost>
	<20060602163350.04066047.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from basillia.speedxs.net ([83.98.255.13]:451 "EHLO
	basillia.speedxs.net") by vger.kernel.org with ESMTP
	id S1751746AbWFCSDa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Jun 2006 14:03:30 -0400
In-Reply-To: <20060602163350.04066047.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org

On 02 Jun 2006, Andrew Morton wrote:
> 
> ata_pio_task() oopsed.  Added linux-ide to CC.
> 
> ISTR others hitting this recently.

I upgraded to 2.6.17-rc5-mm2 and dispite a small BUG being reported at
boot by the Marvell SATA driver I was able to create the array and use
it. I'm still testing this setup, but so far it seems to work nicely.

I'll send the maintainer of the Marvell SATA driver the BUG message.

Thanks again.

Kind regards,

Tom Wirschell
I'm not subscribed to LKML or linux-ide, so please CC me in any replies.
-- 
A small child once asked me why people cant be nicer and just love one
another. I pondered this for but a moment and I then, of course, ate
the small child. He was very tangy and did NOT taste like chicken.
	- Lenore 2 -
