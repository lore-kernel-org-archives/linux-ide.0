From: "Byron Bradley" <byron.bbradley@gmail.com>
Subject: Re: Sata-MV, Intergated Sata Device Support
Date: Tue, 4 Mar 2008 18:42:19 +0000
Message-ID: <57e2b00803041042k67f7b1c6ge8da83efaf1aa9f6@mail.gmail.com>
References: <1176673884.5109.30.camel@Desktop> <47C35203.20402@garzik.org>
	 <47C3585D.8070701@rtr.ca> <47C35A85.3020307@garzik.org>
	 <alpine.DEB.0.99.0802260024400.22022@ubuntu-saeed.il.marvell.com>
	 <47C43655.1050907@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:16654 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762482AbYCDSmU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Mar 2008 13:42:20 -0500
Received: by rv-out-0910.google.com with SMTP id k20so595205rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 04 Mar 2008 10:42:19 -0800 (PST)
In-Reply-To: <47C43655.1050907@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: saeed <saeed@marvell.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, jon@ngndg.com, LKML <linux-kernel@vger.kernel.org>

On Tue, Feb 26, 2008 at 3:55 PM, Mark Lord <liml@rtr.ca> wrote:
> saeed wrote:
>  >
>  > On Mon, 25 Feb 2008, Jeff Garzik wrote:
>  >
>  >>> ...
>  >>>
>  >>> Saeed:  isn't this what your SOC patches already implemented for us?
>  >>> As near as I can tell, sata_mv now already has support for the 60x1C0.
>  >> Saeed's stuff didn't support PCI though, and Jon Li is definitely talking
>  >> about PCI...
>  > yes, my patch added support for the SoC sata like in the 5182, and this
>  > is what Jon Li was concerned about. he mentioneded the 60x1C0 pci device
>  > just to suggest to use it's code for the SoC sata as it is very similar.
>  ..
>
>  I don't think I understand your english there.
>
>  Does the current sata_mv driver work as-is with the chipset this person wants?
>  If not, then exactly what has to change to make it work?

Jon Li was one of the people who started porting Linux to the Marvell
Orion 88F5182 before Marvell did it. sata_mv does now work on the
device Jon was talking about. When this was sent I think we were
unsure whether it could work over PCI or just the system bus which
probably confused things a little.

Cheers,

-- 
Byron Bradley
