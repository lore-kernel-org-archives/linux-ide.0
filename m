From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] various IDE patches/cleanups
Date: Tue, 3 Feb 2004 20:41:09 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200402032041.09696.bzolnier@elka.pw.edu.pl>
References: <20040103152802.6e27f5c5.davmac@ozonline.com.au> <200401061213.39843.bzolnier@elka.pw.edu.pl> <20040130142725.1a408f9e.davmac@ozonline.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:53247 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266139AbUBCThB
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Feb 2004 14:37:01 -0500
In-Reply-To: <20040130142725.1a408f9e.davmac@ozonline.com.au>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Davin McCall <davmac@ozonline.com.au>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Friday 30 of January 2004 04:27, you wrote:
> I've been doing some hacking on the IDE layer, just to fix a few issues I
> noticed going through the code. Due to the complex nature of the code I'm
> bound to have missed some things and perhaps misunderstood others.
> Nevertheless I'm posting these patches in the hope that they can be tested
> on other machines, rejected, or even accepted.
>
> Comments and criticisms are welcome.

Thanks!  I'm slowly reading through them (yeah, code is really complex).
Patch 3rd and 5th seems okay, 2nd and 4th need some more checking/thinking.

> The first patch, below, is already included in the -mm tree. The further
> patches are appearing here for the first time.

It was pushed to Linus and merged.

--bart

