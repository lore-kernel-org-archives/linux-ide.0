From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_legacy: Fix missing methods and add cable types
Date: Fri, 02 Mar 2007 18:12:26 -0500
Message-ID: <45E8AF5A.30902@garzik.org>
References: <20070301174852.6bd60580@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54558 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992717AbXCBXM2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Mar 2007 18:12:28 -0500
In-Reply-To: <20070301174852.6bd60580@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan wrote:
> Several method sets lacked freeze/resume methods. Fix this and while we
> are at it force the cable to 40wire
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

For this, pata_sc1200 and pata_sl82c105:  applied the missing-hook 
portion of the patch, and dropped the ->cable_detect portion pending resend.

Please resend the cable_detect patches one this other stuff lands (will 
push tonight).  I would suggest doing two patches:

	1) add ->cable_detect hook
	2) use ->cable_detect in PATA drivers

There is no need to split up the same change across multiple drivers. 
It is the same logical change, and people doing git-bisect won't be left 
with a broken configuration, so a single update-drivers patch makes more 
sense.  And, hopefully, is less work for you.

	Jeff



