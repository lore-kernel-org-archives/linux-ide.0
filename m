From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update IDE entry
Date: Fri, 24 Apr 2009 11:54:04 +0200
Message-ID: <200904241154.04860.bzolnier@gmail.com>
References: <200904232248.31735.bzolnier@gmail.com> <49F17390.7070003@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:40840 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613AbZDXKas (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Apr 2009 06:30:48 -0400
In-Reply-To: <49F17390.7070003@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 24 April 2009 10:08:48 Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > By a popular demand quilt tree was replaced by a git one.
> >
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> >  MAINTAINERS |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Index: b/MAINTAINERS
> > ===================================================================
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2743,7 +2743,7 @@ IDE SUBSYSTEM
> >  P:	Bartlomiej Zolnierkiewicz
> >  M:	bzolnier@gmail.com
> >  L:	linux-ide@vger.kernel.org
> > -T:	quilt kernel.org/pub/linux/kernel/people/bart/pata-2.6/
> > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bart/ide-2.6.git
> >   
> 
>   Does that mean that the patches that have been already accepeted into 
> the git tree, can't be updated afterwards (i.e. I have a habit of 
> sometimes sending several takes of the same patch)?

Yes, please just send incremental updates once the patch has been merged.

Thanks,
Bart
