From: Andy Smith <andy@strugglers.net>
Subject: Re: NCQ-related READ/WRITE frozen ATA errors with Intel C220 and
 Intel s3610 SSDs
Date: Mon, 10 Aug 2015 17:49:02 +0000
Message-ID: <20150810174902.GZ4327@bitfolk.com>
References: <20150809042756.GX4243@bitfolk.com>
 <55C8C4A7.2050706@seoss.co.uk>
 <20150810163737.GA4243@bitfolk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bitfolk.com ([85.119.80.223]:37138 "EHLO mail.bitfolk.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932134AbbHJRtI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Aug 2015 13:49:08 -0400
Content-Disposition: inline
In-Reply-To: <20150810163737.GA4243@bitfolk.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Small <tim@seoss.co.uk>
Cc: linux-ide@vger.kernel.org

On Mon, Aug 10, 2015 at 04:37:38PM +0000, Andy Smith wrote:
> Offlist I had someone report that their entire batch of 3710 drives
> was suffering this same problem when plugged into Intel C220
> chipset; this being on a platform where they previously had other
> Intel drives including 3500 and 3700 without issue.

My mistake, their chipset is actually Intel C602. They were just
speculating that my C220 chipset may have the same issue as they are
seeing the same problems on 3610 and 3710 drives, but not on 3500
and 3700 for same hardware.

Do you think the next best thing to try is still a different SATA
controller?

Cheers,
Andy
