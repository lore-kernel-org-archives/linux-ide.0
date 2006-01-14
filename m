From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [2.6 patch] Fix PDC202XX_FORCE kconfig selection
Date: Sat, 14 Jan 2006 18:47:31 +0100
Message-ID: <58cb370e0601140947medcb66flf6b7281976683765@mail.gmail.com>
References: <20060114152119.GN29663@stusta.de>
	 <1137255183.20915.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from uproxy.gmail.com ([66.249.92.207]:46352 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750727AbWANRrg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Jan 2006 12:47:36 -0500
Received: by uproxy.gmail.com with SMTP id s2so229053uge
        for <linux-ide@vger.kernel.org>; Sat, 14 Jan 2006 09:47:33 -0800 (PST)
In-Reply-To: <1137255183.20915.0.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, "Andrey J. Melnikoff" <temnota@kmv.ru>

On 1/14/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Sad, 2006-01-14 at 16:21 +0100, Adrian Bunk wrote:
> > Split PDC202XX_FORCE selection into two independ option and allow user
> > select it only for specific driver.
>
> Seems pointless. We should always grab the raid cards. The option itself
> is a mistake

Alan is right, these cards should always be grabbed in 2.6.x kernels.
This option is a leftover from earlier 2.4.x days when Promise binary
driver was available for using software RAID.

Could somebody submit a patch removing CONFIG_PDC202XX_FORCE?

Bartlomiej
