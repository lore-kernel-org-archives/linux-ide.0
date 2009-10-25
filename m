From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with SSD
Date: Sun, 25 Oct 2009 03:48:32 +0100
Message-ID: <200910250348.33308.elendil@planet.nl>
References: <200910212139.24675.bzolnier@gmail.com> <200910241328.40965.elendil@planet.nl> <20091024.043104.143081386.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpsmtpm-eml101.kpnxchange.com ([195.121.3.5]:60248 "EHLO
	CPSMTPM-EML101.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752571AbZJYCs3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Oct 2009 22:48:29 -0400
In-Reply-To: <20091024.043104.143081386.davem@davemloft.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: bzolnier@gmail.com, mpatocka@redhat.com, linux-ide@vger.kernel.org

On Saturday 24 October 2009, David Miller wrote:
> > On Thursday 22 October 2009, David Miller wrote:
> >> The most conservative thing to do is to set the flag as
> >> is done by mpatocka's patch but I'd like Frans to regression
> >> test that on his ultra5.
> >>
> >> Frans can you do that?
> >
> > Sure, if you send me the patch (or a link to it). May take a few days.
>
> It's here:
> http://patchwork.ozlabs.org/patch/36615/

Looks to work OK on my system. dmesg shows ide0 and ide1 are now 
serialized.

Cheers,
FJP
