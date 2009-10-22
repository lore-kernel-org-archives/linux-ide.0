From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with
 SSD
Date: Wed, 21 Oct 2009 17:41:55 -0700 (PDT)
Message-ID: <20091021.174155.44894825.davem@davemloft.net>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com>
	<200910212139.24675.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:48346
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753354AbZJVAlc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Oct 2009 20:41:32 -0400
In-Reply-To: <200910212139.24675.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: mpatocka@redhat.com, linux-ide@vger.kernel.org, elendil@planet.nl

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Wed, 21 Oct 2009 21:39:24 +0200

> Seems like SSD (simply by being faster) triggers some race condition that
> hardware has tolerated in the past and since we used to always serialize
> operation for CMD646 before:

Yes, and technically we only did the synchronization for one
of the two chips mpatocka is adding the serialize setting to.

> commit e01698aed04811b9a9c4f8d54b73cb182757063d           
> Author: David S. Miller <davem@davemloft.net>             
> Date:   Sun Jun 21 22:48:03 2009 -0700
> 
>     ide cmd64x: Remove serialize setting.
> 
> it went undetected until now..

Right, and see also:

commit 6b5cde3629701258004b94cde75dd1089b556b02
Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date:   Mon Dec 29 20:27:32 2008 +0100

    cmd64x: set IDE_HFLAG_SERIALIZE explictly for CMD646

Which is how we got there.

The most conservative thing to do is to set the flag as
is done by mpatocka's patch but I'd like Frans to regression
test that on his ultra5.

Frans can you do that?

Thanks.
