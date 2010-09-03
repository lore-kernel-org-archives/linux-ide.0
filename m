From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: WARNINGs because of ide-proc handling
Date: Fri, 3 Sep 2010 16:21:38 +0200
Message-ID: <201009031621.38693.bzolnier@gmail.com>
References: <20100902212839.GA20070@pengutronix.de> <20100903055328.GA11991@pengutronix.de> <20100903.053437.68134749.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43303 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494Ab0ICOWP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Sep 2010 10:22:15 -0400
Received: by bwz11 with SMTP id 11so1537749bwz.19
        for <linux-ide@vger.kernel.org>; Fri, 03 Sep 2010 07:22:14 -0700 (PDT)
In-Reply-To: <20100903.053437.68134749.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: w.sang@pengutronix.de, linux-ide@vger.kernel.org

On Friday 03 September 2010 02:34:37 pm David Miller wrote:
> From: Wolfram Sang <w.sang@pengutronix.de>
> Date: Fri, 3 Sep 2010 07:53:28 +0200
> 
> > 
> >> Thanks for your analysis and suggested patch, I'll take a look at this.
> > 
> > Thanks for your help. If we can't find something, I'll just do a bisect this
> > weekend.
> 
> Frankly, at this point, I'm beginning suspect that the procfs stuff
> simply never warned at some point in the past and that the IDE
> code has had this problem for a while.

JFYI deprecated procfs stuff has been long gone from atang tree..

Thanks.
--
Bartlomiej Zolnierkiewicz
