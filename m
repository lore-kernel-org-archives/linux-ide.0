From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with SSD
Date: Fri, 23 Oct 2009 16:44:29 +0200
Message-ID: <200910231644.29919.bzolnier@gmail.com>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com> <200910221144.04471.bzolnier@gmail.com> <Pine.LNX.4.64.0910231024240.324@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:33869 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbZJWOpT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2009 10:45:19 -0400
Received: by fxm18 with SMTP id 18so10367051fxm.37
        for <linux-ide@vger.kernel.org>; Fri, 23 Oct 2009 07:45:23 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0910231024240.324@hs20-bc2-1.build.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org, elendil@planet.nl

On Friday 23 October 2009 16:29:16 Mikulas Patocka wrote:
> > We are through this the second time and you're still not willing
> > neither to listen nor to read the code.  We always did serialization
> > for CMD646, we just used  hwif->chipset == ide_cmd646 (without using
> > IDE_HFLAG_SERIALIZE flag):
> 
> > Agreed, though I wonder whether we should also provide module parameter to
> > disable serializing on those chipsets for people not using SSDs...
> 
> Don't do it --- disks have cache and reading from the cache is as fast as 
> reading from SSD (or even faster), so if there is some speed-race in the 
> chip, there is a possibility that the data corruption happens with disks 
> too --- just with lower probability.
> 
> If we don't know why the chip corrupts data, we must treat it as always 
> corrupting data.

I actually suspect that it is device/chipset specific interaction and not
generic problem so adding a fallback option (w/ BIG FAT WARNING) seem to
make sense..  Especially since we have never serialized on CMD643 and your
patch will be adding performance regression without even verifying that
the issue also affects this chipset..

-- 
Bartlomiej Zolnierkiewicz
