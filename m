From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 7/8] ide: make legacy IDE VLB modules check for the "probe" kernel params
Date: Wed, 14 Feb 2007 12:07:27 +0100
Message-ID: <200702141207.27483.bzolnier@gmail.com>
References: <20070214015603.4619.41923.sendpatchset@localhost.localdomain> <20070214015712.4619.78705.sendpatchset@localhost.localdomain> <20070214105329.3cc6ec27@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:19445 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbXBNLBs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Feb 2007 06:01:48 -0500
Received: by ug-out-1314.google.com with SMTP id 44so144695uga
        for <linux-ide@vger.kernel.org>; Wed, 14 Feb 2007 03:01:44 -0800 (PST)
In-Reply-To: <20070214105329.3cc6ec27@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org


On Wednesday 14 February 2007 11:53, Alan wrote:
> On Wed, 14 Feb 2007 02:57:12 +0100
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > [PATCH] ide: make legacy IDE VLB modules check for the "probe" kernel params
> > 
> > Legacy IDE VLB host drivers didn't check for "probe" options when compiled
> > as modules, which was obviously wrong as we don't want module to poke at
> > random I/O ports by simply loading it.  Fix it by adding "probe" module param
> > to legacy IDE VLB host drivers and obsolete old "ide0=dtc2278", "ide0=ht6560b",
> > "ide0=qd65xx", "ide0=ali14xx", "ide0=umc8672" IDE driver options.
> 
> No point obsoleting the old ones. By the time being obsolete turns into
> being anything like "gone", the hardware won't exist. It just causes

We don't have stable rules for kernel parameters.

In theory they can be gone as soon as in 2.6.22 if patch hits 2.6.21
(not that I intend to do this).

> questions, confusion, noise and hassle, leave the old options be and make
> the module options work too.

I'll make warnings more verbose, i.e.

'please use "ali14xx.probe" boot option instead of obsoleted "ide0=probe"'

which should greatly help to avoid questions/confusion/noise/hassle.

Bart
