From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with SSD
Date: Sat, 24 Oct 2009 13:28:39 +0200
Message-ID: <200910241328.40965.elendil@planet.nl>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com> <200910212139.24675.bzolnier@gmail.com> <20091021.174155.44894825.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpsmtpm-eml103.kpnxchange.com ([195.121.3.7]:58717 "EHLO
	CPSMTPM-EML103.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753139AbZJXL2i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Oct 2009 07:28:38 -0400
In-Reply-To: <20091021.174155.44894825.davem@davemloft.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: bzolnier@gmail.com, mpatocka@redhat.com, linux-ide@vger.kernel.org

On Thursday 22 October 2009, David Miller wrote:
> The most conservative thing to do is to set the flag as
> is done by mpatocka's patch but I'd like Frans to regression
> test that on his ultra5.
>
> Frans can you do that?

Sure, if you send me the patch (or a link to it). May take a few days.

Also, is it still needed given the whole discussion that happened after 
this mail?

Cheers,
FJP
