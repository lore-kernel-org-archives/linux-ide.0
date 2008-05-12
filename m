From: Martin Michlmayr <tbm@cyrius.com>
Subject: Re: sata_mv on Orion: mv_err_intr when shutting down
Date: Mon, 12 May 2008 17:46:09 +0200
Message-ID: <20080512154609.GI15866@deprecation.cyrius.com>
References: <20080512132611.GA15410@deprecation.cyrius.com> <48286499.9020202@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:3360 "EHLO sorrow.cyrius.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752582AbYELPqM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 May 2008 11:46:12 -0400
Content-Disposition: inline
In-Reply-To: <48286499.9020202@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, nico@cam.org, buytenh@wantstofly.org

* Mark Lord <liml@rtr.ca> [2008-05-12 11:39]:
> Nothing harmful -- the SATA link is reporting that something weird
> happened on the drive end: perhaps the drive was powered down or something?

It happens on shut down, so yes, the drive is being powered down at
this point.

> The code that triggers this was fixed up more after -rc1, so if you can
> still get messages like that with, say -rc2 or later, then please post them.

Cool.  I'll let you know in case the message doesn't go away with rc2.
-- 
Martin Michlmayr
http://www.cyrius.com/
