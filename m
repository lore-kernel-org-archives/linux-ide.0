From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] drivers/ide/ide-tape.c: remove double kfree
Date: Mon, 30 Jun 2008 22:45:00 +0200
Message-ID: <200806302245.00200.bzolnier@gmail.com>
References: <1214692474.8254.22.camel@localhost.localdomain> <20080629162644.GA10023@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:36947 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331AbYF3VGp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jun 2008 17:06:45 -0400
Received: by mu-out-0910.google.com with SMTP id w8so659558mue.1
        for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2008 14:06:44 -0700 (PDT)
In-Reply-To: <20080629162644.GA10023@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Darren Jenkins <darrenrjenkins@gmail.com>, kernel Janitors <kernel-janitors@lists.osdl.org>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, gadio@netvision.net.il

On Sunday 29 June 2008, Borislav Petkov wrote:
> Hi Bart,
> 
> in case you haven't picked that one up already...
> 
> On Sun, Jun 29, 2008 at 08:34:34AM +1000, Darren Jenkins" wrote:
> > G'day people,
> > 
> > 
> > Coverity CID: 2336 USE_AFTER_FREE
> > 
> > drivers/ide/ide-tape.c ide_tape_kfree_buffer() double free's a pointer
> > (hint freed by an alias in first outer loop).
> > This patch simply removes the superfluous kfree().
> > 
> > 
> > 
> > Signed-off-by: Darren Jenkins <darrenrjenkins@gmailcom>
> Acked-by: Borislav Petkov <petkovbb@gmail.com>

applied
