From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] pata_legacy: export functionality to ide
Date: Sun, 3 Aug 2008 16:22:14 +0100
Message-ID: <20080803162214.394b13a1@lxorguk.ukuu.org.uk>
References: <20080715053356.GA18628@gollum.tnic>
	<200808021902.12191.bzolnier@gmail.com>
	<20080802183253.GA2239@gollum.tnic>
	<200808022046.16990.bzolnier@gmail.com>
	<20080803073756.GA8762@gollum.tnic>
	<20080803125907.67676948@lxorguk.ukuu.org.uk>
	<20080803143837.GA26672@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:49935 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756052AbYHCPjw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Aug 2008 11:39:52 -0400
In-Reply-To: <20080803143837.GA26672@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: petkovbb@googlemail.com, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, alan@redhat.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> conventions, it is still the best one considering the other possibilities:
> 
> a) code duplication: dumb idea, bloated kernel for no reason

I think you might want to start somewhere else if that worries you. Its
also a mostly bogus reasoning as almost nobody builds with both, in fact
you have to be pretty careful if you do that or it all falls over in a
heap.

For previous cases (eg ide timing) it has actually made more sense to
split the code. The moment you get future different behaviour between
libata and old IDE on any of these devices the sharing will just break
again (eg if one or the other drops chipset support for one of those
devices or adds one for another device)

> b) evil Kconfig SELECT pulling in core libata just so that ide might be calling
> a function or two.

That would be stunningly dumb. I happen to think we have developers whose
minds extent to adding libata-common.c and pulling in a single file if we
do that. Yes people have the past done stupid stuff like pulling all of
CONFIG_IDE in for a single USB device but that was because nobody noticed
and fixed it promptly not because it was a good idea.

Alan
