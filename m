From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [RFC][DOC] writing IDE driver guidelines
Date: Sun, 16 May 2004 21:26:05 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200405162126.05428.bzolnier@elka.pw.edu.pl>
References: <200405151923.50343.bzolnier@elka.pw.edu.pl> <200405151958.03322.bzolnier@elka.pw.edu.pl> <40A69848.9020304@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:37851 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264796AbUEPTYn
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 May 2004 15:24:43 -0400
In-Reply-To: <40A69848.9020304@pobox.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Marc Singer <elf@buici.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 16 of May 2004 00:23, Jeff Garzik wrote:

> >>>- define ide_default_irq(), ide_init_default_irq()
> >>>  and ide_default_io_base() to (0)
> >>
> >>Maybe provide generic definitions, so that new arches don't even
> >>have to care about this?
> >
> > Please explain.
>
> Your document appears to imply that each new arch should define the
> above three symbols.
>
> My suggestion is to devise a method by which new arches don't have to
> care about those symbols at all, unless required to do so by the
> underlying hardware.

OK will work on this

