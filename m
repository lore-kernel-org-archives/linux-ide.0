From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 1/2] pata_legacy: export functionality to ide
Date: Sun, 3 Aug 2008 16:38:37 +0200
Message-ID: <20080803143837.GA26672@gollum.tnic>
References: <20080715053356.GA18628@gollum.tnic> <200808021902.12191.bzolnier@gmail.com> <20080802183253.GA2239@gollum.tnic> <200808022046.16990.bzolnier@gmail.com> <20080803073756.GA8762@gollum.tnic> <20080803125907.67676948@lxorguk.ukuu.org.uk>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:21240 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756094AbYHCOis (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Aug 2008 10:38:48 -0400
Received: by fg-out-1718.google.com with SMTP id 19so830811fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 03 Aug 2008 07:38:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080803125907.67676948@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: petkovbb@googlemail.com, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, alan@redhat.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sun, Aug 03, 2008 at 12:59:07PM +0100, Alan Cox wrote:
> On Sun, 3 Aug 2008 09:37:56 +0200
> Borislav Petkov <petkovbb@googlemail.com> wrote:
> 
> > Ok, here's a definitely better solution:
> 
> Please don't stuff large important pieces of code in header files where
> they will be overlooked

What do you mean by "overlooked"? If you're looking for the function defintion,
any sensible code indexing tool will point you to the right place.

And linux/ata.h already contains several c one liners/helpers. What is the
difference between the two new functions and the ones already present there?
Although the solution i propose is not adhering to some header/c file
conventions, it is still the best one considering the other possibilities:

a) code duplication: dumb idea, bloated kernel for no reason

b) evil Kconfig SELECT pulling in core libata just so that ide might be calling
a function or two.

[.. ]


-- 
Regards/Gruss,
    Boris.
