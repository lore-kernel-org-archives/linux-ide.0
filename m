From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git patches] libata fixes
Date: Sun, 24 Feb 2008 18:40:25 +0100
Message-ID: <200802241840.25452.bzolnier@gmail.com>
References: <20080224053508.GA17530@havoc.gtf.org> <200802241821.15052.bzolnier@gmail.com> <20080224170735.7fed8ab6@core>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:34478 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbYBXR1N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Feb 2008 12:27:13 -0500
Received: by ug-out-1314.google.com with SMTP id z38so472989ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 24 Feb 2008 09:27:12 -0800 (PST)
In-Reply-To: <20080224170735.7fed8ab6@core>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Sunday 24 February 2008, Alan Cox wrote:
> > From the patch description it can't be told whether the patch itself is
> > correct and only the patch description is bogus...
> 
> zero length PRD misparsing. If I remember rightly old IDE never generates
> 64K PRD slots because other hardware can't handle it either (CS5520/30
> etc)

OK, that would explain it.

Thanks,
Bart
