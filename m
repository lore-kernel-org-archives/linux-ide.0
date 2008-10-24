From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] TXx9: Add TX4938 ATA support (v2)
Date: Fri, 24 Oct 2008 22:52:25 +0200
Message-ID: <200810242252.25327.bzolnier@gmail.com>
References: <20081023.011646.51867355.anemo@mba.ocn.ne.jp> <200810232206.50973.bzolnier@gmail.com> <4900F8DE.4070203@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:41012 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905AbYJXUy2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Oct 2008 16:54:28 -0400
Received: by nf-out-0910.google.com with SMTP id d3so460197nfc.21
        for <linux-ide@vger.kernel.org>; Fri, 24 Oct 2008 13:54:26 -0700 (PDT)
In-Reply-To: <4900F8DE.4070203@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org

On Friday 24 October 2008, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>> From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> >>> Subject: [PATCH] TXx9: Add TX4938 ATA support (v3)
> >>>       
> >>> Add a helper routine to register tx4938ide driver and use it on
> >>> RBTX4938 board.
> >>>       
> >>> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> >>>       
> >>     The patch already had my
> >>
> >> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> >>     
> >
> > applied
> >   
> 
>    Hm, I thought that one was for Ralf...

Ralf ACK-ed the change and was fine with it going through ide tree.

Anyway it really doesn't matter through whose tree such patches are
going in as long as people are fine with them.

No need to add some more rigid kernel bureaucracy...
