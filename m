From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: patch fix for intel sdd s3500 series on Sil3512 controller
Date: Mon, 24 Mar 2014 16:27:54 +0100
Message-ID: <2140283.ClKsmfFTvU@amdc1032>
References: <CAGRSmLtifL=hFBP1AUHB_va6ZvNfqXo8Bu=6XciH--jOEYVJjQ@mail.gmail.com>
 <20140324141558.31c169cf@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:30567 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754AbaCXP2O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Mar 2014 11:28:14 -0400
In-reply-to: <20140324141558.31c169cf@alan.etchedpixels.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: "David F." <df7729@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


+ linux-ide mailing list on Cc:

On Monday, March 24, 2014 02:15:58 PM One Thousand Gnomes wrote:
> On Sat, 22 Mar 2014 16:32:54 -0700
> "David F." <df7729@gmail.com> wrote:
> 
> > Hi,
> > 
> > It appears if nIEN is set all polling type IO fails.   After an
> > attempt, future non-polled communications also fails.  This patch
> > allows it to work.  Not sure if any spin lock protection would be
> > needed or the system already handles the device existence for the
> > generated irq with polling enabled.  handler already ignored irq if
> > queued command was polling type.
> 
> Does it behave plugged into a different controller without the hacks ?
> 
> Alan

