From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: PATCH: (Test) it8212 driver for 2.6.9rc3
Date: Fri, 1 Oct 2004 00:01:27 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200410010001.27607.bzolnier@elka.pw.edu.pl>
References: <20040930184535.GA31197@devserv.devel.redhat.com> <200409302245.18866.bzolnier@elka.pw.edu.pl> <20040930213500.GC2175@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:23502 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S269535AbUI3WDo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Sep 2004 18:03:44 -0400
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:49805 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S101106AbUI3WDl (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 1 other);
	Fri, 1 Oct 2004 00:03:41 +0200
Received: from chello084010012196.chello.pl ([84.10.12.196]:64401 "EHLO
	[192.168.123.164]" ident: "NO-IDENT-SERVICE[2]" smtp-auth: "bzolnier"
	TLS-CIPHER: <none> TLS-PEER-CN1: <none>) by mion.elka.pw.edu.pl
	with ESMTP id S51397AbUI3V72 (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 2 others);
	Thu, 30 Sep 2004 23:59:28 +0200
In-Reply-To: <20040930213500.GC2175@devserv.devel.redhat.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thursday 30 September 2004 23:35, Alan Cox wrote:
> On Thu, Sep 30, 2004 at 10:45:18PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > - merge+describe needed IDE core changes
> 
> Happily. I'm of the opinion the "ident whacking" callback isnt justified,
> only one driver has a need for it and that driver can do it in the iops hook.

ok, you are right

> > - fix coding style and whitespace damage
> 
> Yeah
> 
> > - kill useless DECLARE_ITE_DEV macro
> 
> I'd prefer to keep it (there are likely to be some related devices from
> the databook)

you can add it when needed

> > - add __init to it8212_ide_init()
> 
> Good point - will fix

thanks
