From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with SSD
Date: Fri, 23 Oct 2009 17:03:33 +0200
Message-ID: <200910231703.33206.bzolnier@gmail.com>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com> <200910231644.29919.bzolnier@gmail.com> <Pine.LNX.4.64.0910231050330.3007@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:53807 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbZJWPEe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2009 11:04:34 -0400
Received: by bwz27 with SMTP id 27so955216bwz.21
        for <linux-ide@vger.kernel.org>; Fri, 23 Oct 2009 08:04:38 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0910231050330.3007@hs20-bc2-1.build.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org, elendil@planet.nl

On Friday 23 October 2009 16:55:59 Mikulas Patocka wrote:
> 
> On Fri, 23 Oct 2009, Bartlomiej Zolnierkiewicz wrote:
> 
> > On Friday 23 October 2009 16:29:16 Mikulas Patocka wrote:
> > > > We are through this the second time and you're still not willing
> > > > neither to listen nor to read the code.  We always did serialization
> > > > for CMD646, we just used  hwif->chipset == ide_cmd646 (without using
> > > > IDE_HFLAG_SERIALIZE flag):
> > > 
> > > > Agreed, though I wonder whether we should also provide module parameter to
> > > > disable serializing on those chipsets for people not using SSDs...
> > > 
> > > Don't do it --- disks have cache and reading from the cache is as fast as 
> > > reading from SSD (or even faster), so if there is some speed-race in the 
> > > chip, there is a possibility that the data corruption happens with disks 
> > > too --- just with lower probability.
> > > 
> > > If we don't know why the chip corrupts data, we must treat it as always 
> > > corrupting data.
> > 
> > I actually suspect that it is device/chipset specific interaction and not
> > generic problem so adding a fallback option (w/ BIG FAT WARNING) seem to
> > make sense..
> 
> So, why was it serialized before? I assume that either someone noticed the 
> corruption or someone read some datasheet noting the corruption or someone 
> reverse engineered some other driver and saw the serialization.

Serialization is usually needed in case of chipset not handling concurrent
data transfers on both ports.  Unfortunately I don't know details for CMD646.

> > Especially since we have never serialized on CMD643 and your patch will 
> > be adding performance regression without even verifying that the issue 
> > also affects this chipset..
> 
> Do you have this chip? If you were IDE maintainer, did you collect cards 
> with IDE chips?

I recall having CMD648 and CMD649 cards somewhere, however not earlier
chipsets.

-- 
Bartlomiej Zolnierkiewicz
