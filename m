From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 6/7] ide: pass number of ports to ide_host_{alloc,add}()
Date: Thu, 14 May 2009 21:51:15 +0200
Message-ID: <200905142151.15854.bzolnier@gmail.com>
References: <20090513205139.28638.87226.sendpatchset@localhost.localdomain> <20090513205222.28638.19386.sendpatchset@localhost.localdomain> <4A0C6A27.7010703@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:62381 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755216AbZENTq4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 May 2009 15:46:56 -0400
In-Reply-To: <4A0C6A27.7010703@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 14 May 2009 20:59:51 Sergei Shtylyov wrote:

> > @@ -467,7 +467,7 @@ icside_register_v6(struct icside_state *
> >  	struct ide_host *host;
> >  	unsigned int sel = 0;
> >  	int ret;
> > -	hw_regs_t hw[2], *hws[] = { &hw[0], NULL, NULL, NULL };
> > +	hw_regs_t hw[2], *hws[] = { &hw[0], NULL };
> 
>     I wonder if there's an old bug here since I'm not seeing when hws[1] is 
> set to non-NULL -- despite there are apparently two ports?
> 
>     Indeed, this bug seems to date back to the 'struct ide_host' 
> introduction, see this:
>  
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=48c3c1072651922ed153bcf0a33ea82cf20df390#patch1...

Care to send a fix?
