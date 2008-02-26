From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/6] IDE: new series of Coding Style Fixes
Date: Tue, 26 Feb 2008 22:01:39 +0100
Message-ID: <200802262201.39770.bzolnier@gmail.com>
References: <20080223183812.5af6d36d@paolo-desktop> <200802241738.57839.bzolnier@gmail.com> <4d8e3fd30802241012k3794882fm7f35a86b9481016f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:24008 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764609AbYBZWXg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Feb 2008 17:23:36 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1257907nfb.21
        for <linux-ide@vger.kernel.org>; Tue, 26 Feb 2008 14:23:35 -0800 (PST)
In-Reply-To: <4d8e3fd30802241012k3794882fm7f35a86b9481016f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

On Sunday 24 February 2008, Paolo Ciarrocchi wrote:

[...]

> >  >  drivers/ide/ide-floppy.c     |    4 +-
> >  >  drivers/ide/legacy/ali14xx.c |   11 +++--
> >  >  drivers/ide/legacy/hd.c      |   79 ++++++++++++++++++------------------
> >  >  drivers/ide/pci/cmd640.c     |   90 +++++++++++++++++++++---------------------
> >  >  drivers/ide/pci/it8213.c     |    9 ++--
> >  >  drivers/ide/pci/opti621.c    |   50 ++++++++++++------------
> >  >  6 files changed, 122 insertions(+), 121 deletions(-)
> >
> >  I applied all the rest (some with minor fixes).
> 
> Good. Where can I look to see the end result of our work?

the "usual" place:

http://www.kernel.org/pub/linux/kernel/people/bart/pata-2.6/

[ or "tomorrow's" linux-next ]

Thanks,
Bart
