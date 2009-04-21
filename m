From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 4/6] PalmLD IDE
Date: Tue, 21 Apr 2009 16:52:34 +0200
Message-ID: <200904211652.34576.marek.vasut@gmail.com>
References: <200904210205.59971.marek.vasut@gmail.com> <20090421152735.39486f55@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:37819 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbZDUOwa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Apr 2009 10:52:30 -0400
Received: by fxm2 with SMTP id 2so2565185fxm.37
        for <linux-ide@vger.kernel.org>; Tue, 21 Apr 2009 07:52:29 -0700 (PDT)
In-Reply-To: <20090421152735.39486f55@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Jeff Garzik <jgarzik@pobox.com>, linux-arm-kernel@lists.arm.linux.org.uk, Eric Miao <eric.y.miao@gmail.com>, linux-ide@vger.kernel.org

On Tuesday 21 of April 2009 16:27:35 Alan Cox wrote:
> Questions:
>
> + ATA_FLAG_NO_ATAPI
>
> Is this a case of the controller cannot handle ATAPI in which case the
> flag is correct, or you can't conceive of a user finding a way to add an
> ATAPI device (but it would work as usually happens with basic PIO
> hardware) in which case it isn't.

http://www.palm.com/us/support/contact/environment/disassem_inst_Lifedrive.pdf , 
see slide 10 and 15 for yourself, I think noone would want to solder anything 
into that device ;-)

>
> +	/* we'd better wait for drive's ready signal here
> +	  (if we knew where it will come from) */
> +	msleep(300);
>
> Our probe code should already be waiting for ready signals  ?

The drive asserts some GPIO when it becomes ready, dunno which one though so 
we just wait here.
>
>
> The only other question is a general architectural one as to whether it
> would be better to set up the GPIO etc and create a pata_platform
> platform device (possibly tweaking pata_platform flags to allow the
> caller to indicate generic pio with mode setting by set features command)

I already explained this to Eric, there isn't any other obscure hardware I 
think. Or if this is concerning something else, I'll recheck later.
>
> Alan

Thanks
Marek
