From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] (pata-2.6 fix queue) cmd64x: add/fix enablebits
Date: Fri, 23 Feb 2007 21:10:54 +0100
Message-ID: <200702232110.54176.bzolnier@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702200009.38168.bzolnier@gmail.com> <45DB0593.8060500@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:17088 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932658AbXBWUFA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Feb 2007 15:05:00 -0500
Received: by ug-out-1314.google.com with SMTP id 44so462350uga
        for <linux-ide@vger.kernel.org>; Fri, 23 Feb 2007 12:04:59 -0800 (PST)
In-Reply-To: <45DB0593.8060500@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


On Tuesday 20 February 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>The IDE core looks at the wrong bit when checking if the secondary channel is
> >>enabled on PCI0646 -- CFR bit 8 is read-ahead disable, bit 3 is the correct one.
> 
> > I guess that you meant CNTRL here?
> 
>     Yeah, and bit 7. :-<

fixed, thanks
