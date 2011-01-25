From: Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: WDC WD20EARS and 4k sector size
Date: Tue, 25 Jan 2011 05:34:58 +0100
Message-ID: <20110125043458.GD24024@MAIL.13thfloor.at>
References: <20110125030410.GA24024@MAIL.13thfloor.at> <4D3E4FD6.2020902@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from MAIL.13thfloor.at ([213.145.232.33]:59347 "EHLO
	MAIL.13thfloor.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089Ab1AYEe7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jan 2011 23:34:59 -0500
Content-Disposition: inline
In-Reply-To: <4D3E4FD6.2020902@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: linux-ide@vger.kernel.org

On Mon, Jan 24, 2011 at 11:21:42PM -0500, Mark Lord wrote:
> On 11-01-24 10:04 PM, Herbert Poetzl wrote:

> > I recently bought the WDC WD20EARS-00MVWB0 because it
> > was really cheap for a drive with 64 MB cache, and I
> > wanted to try out a 4k sector size disk ...

> > Now the drive performs quite well, is rather silent
> > and doesn't use much power or produce much heat, but
> > at first I didn't find anything in Linux indicating
> > that this drive would actually use 4k sectors.

> > To shorten things, I asked around on IRC, had a chat
> > with some other folks, found a jumper description on
> > the WD site talking about an 'Advanced Format' jumper
> > and finally contacted WD in a lengthy email thread.

> My understanding about that jumper is that
> you DO NOT WANT THE JUMPER ON.

> Without the jumper, sector 0 is 4KB aligned,
> as is any sector multiple of 4.

> But WITH the jumper, sector 0 is no longer 4KB aligned..
> everything shifts by one (or seven) such that sector
> 63 ends up being the start of a 4KB low-level sector,
> instead of the more sensible sector 64.

> Right?

yes, that is what I found out and what got confirmed
by WD folks via E-mail, if you are using 4k aligned
partitions, DO NOT use the jumper, if you are using
DOS partitions starting at sector 63, this jumper
will improve the performance by shifting everything
by one 512 byte sector ...

why it is called 'Advanced Format' in the documentation
available from WD is beyond me.

best,
Herbert

> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
