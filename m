From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [2/2] 2.6.22-git: known regressions
Date: Thu, 19 Jul 2007 21:18:43 +0200
Message-ID: <6bffcb0e0707191218j7ecc0fa4re2a2ae7c82c95668@mail.gmail.com>
References: <469F9125.8040502@googlemail.com> <469F92AF.10405@googlemail.com>
	 <200707192127.07238.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:5760 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763360AbXGSTSo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jul 2007 15:18:44 -0400
Received: by wa-out-1112.google.com with SMTP id v27so739190wah
        for <linux-ide@vger.kernel.org>; Thu, 19 Jul 2007 12:18:43 -0700 (PDT)
In-Reply-To: <200707192127.07238.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@ozlabs.org

On 19/07/07, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> On Thursday 19 July 2007, Michal Piotrowski wrote:
>
> > IDE
> >
> > Subject         : compile error if CONFIG_BLOCK not enabled related to linux/ide.h include
> > References      : http://lkml.org/lkml/2007/7/18/11
> > Last known good : ?
> > Submitter       : Kumar Gala <galak@kernel.crashing.org>
> > Caused-By       : ?
> > Handled-By      : Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Status          : unknown
>
> Not a 2.6.22-git regression (CONFIG_BLOCK was added on September 2006) and
> Kumar should have a fix really soon - could be removed from the list IMO.

Ok, I removed it.

>
> Thanks,
> Bart
>

Regards,
Michal

-- 
LOG
http://www.stardust.webpages.pl/log/
