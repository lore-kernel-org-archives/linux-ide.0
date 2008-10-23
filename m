From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: Add tx4939ide driver (v5)
Date: Thu, 23 Oct 2008 22:00:35 +0200
Message-ID: <200810232200.35932.bzolnier@gmail.com>
References: <20081020.212701.59651580.anemo@mba.ocn.ne.jp> <48FDFE89.5030501@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.191]:1076 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524AbYJWVt7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Oct 2008 17:49:59 -0400
Received: by gv-out-0910.google.com with SMTP id e6so111620gvc.37
        for <linux-ide@vger.kernel.org>; Thu, 23 Oct 2008 14:49:58 -0700 (PDT)
In-Reply-To: <48FDFE89.5030501@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org

On Tuesday 21 October 2008, Sergei Shtylyov wrote:

> > +		pr_err("%s: Error interrupt %#x (%s%s%s )\n",
> > +		       hwif->name, ctl,
> > +		       (ctl & TX4939IDE_INT_ADDRERR) ?
> > +		       " Address-Error" : "",
> > +		       (ctl & TX4939IDE_INT_DEVTIMING) ?
> > +		       " DEV-Timing" : "",
> > +		       (ctl & TX4939IDE_INT_BUSERR) ?
> 
>     Parens around & shouldn't be needed...

While the above remark is certainly correct we usually leave such parens
to ease the reading of the code and to match the other parts of the kernel...

[ No need to change it again, just a minor note... ]
