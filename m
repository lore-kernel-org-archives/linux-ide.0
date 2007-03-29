From: "Fabio Comolli" <fabio.comolli@gmail.com>
Subject: Re: [2/5] 2.6.21-rc5: known regressions
Date: Thu, 29 Mar 2007 21:02:52 +0200
Message-ID: <b637ec0b0703291202x472c7c7eq5aa2f4d4646e67af@mail.gmail.com>
References: <Pine.LNX.4.64.0703251559560.6730@woody.linux-foundation.org>
	 <20070327015936.GZ16477@stusta.de> <460AC616.3050207@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.248]:9527 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030609AbXC2TCy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Mar 2007 15:02:54 -0400
Received: by an-out-0708.google.com with SMTP id b33so260748ana
        for <linux-ide@vger.kernel.org>; Thu, 29 Mar 2007 12:02:53 -0700 (PDT)
In-Reply-To: <460AC616.3050207@free.fr>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

Hi.

> > This email lists some known regressions in Linus' tree compared to 2.6.20.
> ...
> > Subject    : libata: PATA UDMA/100 configured as UDMA/33
> > References : http://lkml.org/lkml/2007/2/20/294
> >              http://www.mail-archive.com/linux-ide@vger.kernel.org/msg04115.html
> >              http://bugzilla.kernel.org/show_bug.cgi?id=8133
> >              http://bugzilla.kernel.org/show_bug.cgi?id=8164
> >              http://lkml.org/lkml/2007/3/21/330
> > Submitter  : Fabio Comolli <fabio.comolli@gmail.com>
> >              Plamen Petrov <plamen.petrov@tk.ru.acad.bg>
> >              Laurent Riffard <laurent.riffard@free.fr>
> >              Lukas Hejtmanek <xhejtman@mail.muni.cz>
> > Handled-By : Tejun Heo <htejun@gmail.com>
> > Patch      : http://thread.gmane.org/gmane.linux.ide/17444
> > Status     : patch available
>

Fixed for me (ata_piix) with today's GIT (Tejun's patch got applied).
Regards,
Fabio
