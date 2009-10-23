From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with
 SSD
Date: Thu, 22 Oct 2009 18:30:05 -0700 (PDT)
Message-ID: <20091022.183005.22538787.davem@davemloft.net>
References: <200910212139.24675.bzolnier@gmail.com>
	<20091021.174155.44894825.davem@davemloft.net>
	<20091022145613.2b7c8c08@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:57964
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751161AbZJWB3m (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Oct 2009 21:29:42 -0400
In-Reply-To: <20091022145613.2b7c8c08@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: bzolnier@gmail.com, mpatocka@redhat.com, linux-ide@vger.kernel.org, elendil@planet.nl

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 22 Oct 2009 14:56:13 +0100

> I doubt there is any hardware bug with the SSD. Some CMD64x hardware
> certainly has errata and as the data sheets were published your starting
> point would be the data sheets for the various chip versions. Does the
> sparc use the same off the shelf part as the PC people or does it have
> different glue or chip versions (eg as a macro cell in something else ?)

The sparc machines use the standard cmd64x chips without any special
glue logic.
