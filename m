From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [2/3] 2.6.22-rc4: known regressions v2
Date: Sat, 9 Jun 2007 21:47:59 +0200
Message-ID: <200706092147.59551.bzolnier@gmail.com>
References: <466ADBE4.5090707@googlemail.com> <466AE609.1030605@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:36948 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758422AbXFITdg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Jun 2007 15:33:36 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1189783ugf
        for <linux-ide@vger.kernel.org>; Sat, 09 Jun 2007 12:33:35 -0700 (PDT)
In-Reply-To: <466AE609.1030605@googlemail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, Ben Collins <bcollins@ubuntu.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Robert de Rooy <robert.de.rooy@gmail.com>, Gregor Jasny <gjasny@googlemail.com>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, Mark Lord <mlord@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, Mikael Pettersson <mikpe@it.uu.se>

On Saturday 09 June 2007, Michal Piotrowski wrote:

> IDE
> 
> Subject    : libata and legacy ide pcmcia failure
> References : http://lkml.org/lkml/2007/5/17/305
> Submitter  : Robert de Rooy <robert.de.rooy@gmail.com>
> Handled-By : Mark Lord <mlord@pobox.com>
> Status     : problem is being debugged

Not a regression, this device has never worked with Linux.

Bart
