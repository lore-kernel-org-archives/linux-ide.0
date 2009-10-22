From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with SSD
Date: Thu, 22 Oct 2009 13:15:59 +0200
Message-ID: <200910221316.00054.bzolnier@gmail.com>
References: <200910212139.24675.bzolnier@gmail.com> <200910221144.04471.bzolnier@gmail.com> <20091022.040049.83738097.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:45828 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754337AbZJVLQy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Oct 2009 07:16:54 -0400
Received: by fxm18 with SMTP id 18so9040418fxm.37
        for <linux-ide@vger.kernel.org>; Thu, 22 Oct 2009 04:16:58 -0700 (PDT)
In-Reply-To: <20091022.040049.83738097.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: mpatocka@redhat.com, linux-ide@vger.kernel.org, elendil@planet.nl

On Thursday 22 October 2009 13:00:49 David Miller wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date: Thu, 22 Oct 2009 11:44:04 +0200
> 
> > We always did serialization for CMD646, we just used hwif->chipset
> > == ide_cmd646 (without using IDE_HFLAG_SERIALIZE flag):
> 
> I fully acknowledge that we always serialized, sorry for not
> being explicit.
> 
> I was just showing where the serialize IRQ flag got added
> (and again, it was a correct change).

What for?  The only patch changing behavior was yours and it seems
your luck is much worse than mine when it comes to unexpected side
effects.. ;)
