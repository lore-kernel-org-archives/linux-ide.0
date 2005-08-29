From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [RFH][PATCH] CS5535 driver
Date: Mon, 29 Aug 2005 18:32:27 +0200
Message-ID: <20050829163227.GA29221@midnight.suse.cz>
References: <58cb370e0508290848457748dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:10926 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751106AbVH2QcW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Aug 2005 12:32:22 -0400
Content-Disposition: inline
In-Reply-To: <58cb370e0508290848457748dc@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jens Altmann <jens.altmann@amd.com>, Wolfgang Zuleger <wolfgang.zuleger@gmx.de>, Alexander Kiausch <alex.kiausch@t-online.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Mon, Aug 29, 2005 at 05:48:26PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> Alan Cox has sent me this driver recently.  It needs a little bit of
> work to become
> acceptable into mainline kernel and as I don't have neither the hardware nor the
> time to work on it now, I'm posting it to you and linux-ide ML with a remaining
> TODO list (original patch attached to the mail). :-)
> 
> I hope that somebody will work on it so that it can be merged soon.
> 
> * cs5535_tuneproc() needs to be fixed to not abuse ->tuneproc interface
>   (which is exported to user-space), all DMA tuning should be done through
>   ->speedproc interface only
> * cs5535_set_drive() needs to use ide_rate_filter() to limit values passed
>   from the user-space
> * cs5535_set_drive() needs to set drive's speed unconditionally otherwise
>   drive may not be setup correctly after resume
> * cs5535_set_drive() shouldn't change drive->current_speed
> * cable detection needs to be in separate function (for hotplug - later)
> * driver lacks device side cable detection [ see eighty_ninty_three() ]

That, as far as I know, only works on mainboards with a capacitor
installed. If there is host cable detection, it doesn't work reliably.


-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
