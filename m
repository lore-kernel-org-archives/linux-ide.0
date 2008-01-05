From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RESEND PATCH 02/10] ide-floppy: move ide-floppy struct and macro defs into its own header. While at it
Date: Sat, 5 Jan 2008 14:15:16 +0100
Message-ID: <200801051415.16775.bzolnier@gmail.com>
References: <1199366409-26016-1-git-send-email-bbpetkov@yahoo.de> <200801042349.09964.bzolnier@gmail.com> <20080105124501.GA5704@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:39846 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277AbYAENYb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Jan 2008 08:24:31 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2907256ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 05 Jan 2008 05:24:30 -0800 (PST)
In-Reply-To: <20080105124501.GA5704@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bbpetkov@yahoo.de
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Saturday 05 January 2008, Borislav Petkov wrote:
> On Fri, Jan 04, 2008 at 11:49:09PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Hi,
> Hi Bart,
> 
> > Hmm, contrary to ide-cd.c case there doesn't seem to be a need currently for
> > moving code out of ide-floppy.c (and this patch series doesn't change that).
> ?, you mean this patch series _does_ change that, meaning it moves the struct

I mean that even with this patch series applied there is no need to for header
file since ide-floppy will still be the only user of it.

> defs into a header file. Do i get this correctly that we don't need the header
> file and the struct defs should remain in the .c file?

Yes.

> > Besides it would be better to just remove some structs like it has been done
> > with i.e. struct atapi_capabilities_page in ide-cd.c case [1] because:
> 
> [...]
> 
> > typedefs are evil (exceptions are rare) and should die :)
> > 
> 
> i'm redoing them right now against ide-2.6.git and will post when ready. By the

ide-2.6.git is for syncing with Linus, the development tree is kept in quilt
tree and is merged by Andrew to -mm.  Please get the quilt patch series from:

http://www.kernel.org/pub/linux/kernel/people/bart/pata-2.6/

or use the latest 2.6.24-rc6-mm1 kernel (should have most of IDE patches).

> way, i have done some more cleanups in the meantime. Should i include them into
> this series or send them later?

Include! :)

Thanks,
Bart

PS I still have to comment on patches #5/6/8/9.
