From: "Rodrigo Severo" <rodrigo@fabricadeideias.com>
Subject: Re: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen on SATA hd
Date: Tue, 17 Apr 2007 14:56:12 -0300
Message-ID: <a7108f870704171056p300ae211x9cf5b4f2020c74a6@mail.gmail.com>
References: <a7108f870704150703p1f0da000k22f7b70605cec595@mail.gmail.com>
	 <a7108f870704150708g741b7e2fmd52be8b53b358113@mail.gmail.com>
	 <a7108f870704160745l4296fe8bt74e94d6c5bf8504e@mail.gmail.com>
	 <a7108f870704160914g22b648bey39a9523a6d8a4800@mail.gmail.com>
	 <4624FD7F.4070200@gmail.com>
	 <a7108f870704171030i6076a147lc4580ee720ba3e82@mail.gmail.com>
	 <462507B4.2010404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.239]:17081 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031221AbXDQR4O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2007 13:56:14 -0400
Received: by qb-out-0506.google.com with SMTP id z1so3154332qbc
        for <linux-ide@vger.kernel.org>; Tue, 17 Apr 2007 10:56:13 -0700 (PDT)
In-Reply-To: <462507B4.2010404@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On 4/17/07, Tejun Heo <htejun@gmail.com> wrote:
> Rodrigo Severo wrote:
> > Please let me know if there is anything else I can do to help debug this
> > issue.
> >
> > I can put the ULi M5281/M5283 back for tests.
>
> ULi SATA is a fairly standard controller and the driver doesn't do much
> other than feeding IO addresses to generic ATA layer, so there's nothing
> much to go wrong there.  It might be a genuine hardware problem on the
> controller side or driver missing some undocumented magic tweaks.  I
> think the former is more likely.
>
> Occasional errors should be okay.  libata EH can recover most conditions
> and there won't be any data integrity problem.  Too long timeout (30s)
> can be a problem tho.
>
> Unfortunately, I don't think we have much to go on here.  Both SError
> register and SMART log aren't reporting anything useful.  :-(

I have another ULi M5281/M5283 at home. I can bring it to work and try
to reproduce this issue. Interested?

BTW lspci mentions a M5281 but the chipset is marked M5283. Is this ok?


Regards,

Rodrigo Severo
