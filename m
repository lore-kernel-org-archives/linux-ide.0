From: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH] Don't use UDMA on VIA UDMA33 controller with Transcend
 SSD
Date: Wed, 18 Nov 2009 12:46:37 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0911181245330.5068@hs20-bc2-1.build.redhat.com>
References: <20091117.043002.224755438.davem@davemloft.net>
 <Pine.LNX.4.64.0911181151140.5068@hs20-bc2-1.build.redhat.com>
 <20091118172258.59894130@lxorguk.ukuu.org.uk> <20091118.093233.83428970.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34236 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758075AbZKRRqk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Nov 2009 12:46:40 -0500
In-Reply-To: <20091118.093233.83428970.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org



On Wed, 18 Nov 2009, David Miller wrote:

> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Date: Wed, 18 Nov 2009 17:22:58 +0000
> 
> >> Transcend makes various versions of their SSDs and all begin with TS. You 
> >> can assume that Transcend SSDs with different capacity or format won't 
> >> work too because they likely use the same controller. The naming is this:
> > 
> > You don't want to assume that because then you will never find out if
> > there is no problem.
> 
> Agreed.
> 
> And if Alan's patch for the ATA layer is going to use an exact string
> match, which it is, and we should do the same in the IDE layer to be
> consistent.

And what will you do with 16G or 32G versions of the same device? You 
really think they use different controllers and are not affected?

Mikulas
