From: Rolf Offermanns <roffermanns@sysgo.com>
Subject: Re: Linux hangs during IDE initialization at boot for 30 sec
Date: Fri, 4 Feb 2005 11:22:09 +0100
Message-ID: <200502041122.09390.roffermanns@sysgo.com>
References: <200502011257.40059.brade@informatik.uni-muenchen.de> <200502031358.16827.roffermanns@sysgo.com> <1107469032.2363.44.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from [62.8.134.5] ([62.8.134.5]:23240 "EHLO mailgate2.sysgo.com")
	by vger.kernel.org with ESMTP id S261660AbVBDKWM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Feb 2005 05:22:12 -0500
In-Reply-To: <1107469032.2363.44.camel@gaston>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: list linux-ide <linux-ide@vger.kernel.org>

On Thursday 03 February 2005 23:17, Benjamin Herrenschmidt wrote:
>
> Do not register interfaces that you know aren't populated...
>
> One thing is, the wait code does explicitely check for a value of 0xff
> and exists in this case (assuming this means no HW at all is wired
> there). So for some reason, you interface is returning something else,
> it would be interesting to "see" what value you are getting.
It's 0xff like you guessed in the first reply. As soon, as I connect a drive 
(no need to turn it on actually), everything is fine.

-Rolf
-- 
Rolf Offermanns <roffermanns@sysgo.com>
SYSGO AG     Tel.: +49-6136-9948-0
Am Pfaffenstein 14   Fax: +49-6136-9948-10
55270 Klein-Winternheim  http://www.sysgo.com

