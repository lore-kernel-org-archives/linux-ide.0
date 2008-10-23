From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git pull] IDE updates #4
Date: Thu, 23 Oct 2008 23:13:59 +0200
Message-ID: <200810232314.00711.bzolnier@gmail.com>
References: <200810212100.52985.bzolnier@gmail.com> <48FE2AF5.2010603@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.186]:6727 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931AbYJWVuM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Oct 2008 17:50:12 -0400
Received: by gv-out-0910.google.com with SMTP id e6so111672gvc.37
        for <linux-ide@vger.kernel.org>; Thu, 23 Oct 2008 14:50:11 -0700 (PDT)
In-Reply-To: <48FE2AF5.2010603@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Tuesday 21 October 2008, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Remove needless/confusing subdirs from drivers/ide/.
> 
>     I dunno, they didn't confuse me...
> 
> > Linus, please pull from:
> 
> > master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git/
> 
> > to receive the following updates:
> 
> >  rename drivers/ide/{pci => }/generic.c (100%)
> 
>     Not even pci-generic.c?

or even ide-pci-generic.c

Fixed in #5.
