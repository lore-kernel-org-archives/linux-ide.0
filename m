From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Playing with SATA NCQ
Date: Fri, 27 May 2005 18:16:47 -0400
Message-ID: <42979C4F.8020007@pobox.com>
References: <20050526140058.GR1419@suse.de> <429793C8.8090007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:34273 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262631AbVE0WQx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 May 2005 18:16:53 -0400
In-Reply-To: <429793C8.8090007@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Thonke <iogl64nx@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Michael Thonke wrote:
> Hello Jens,
> 
> I tried to play with your patch on ICH6R and ICH7R chipset also on
> Sil3124R Controller
> with 2xSamsung HD160JJ SATAII drives. But the performance gain stay out..
> anything special to set to get it working? I used a vanilla-kernel
> 2.6.12-rc5-git2 for it.

SiI 3124 driver needs to be updated to support NCQ.

	Jeff



