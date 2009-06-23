From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH] ide-cd: Improve "weird block size" error message
Date: Tue, 23 Jun 2009 23:30:18 +0200
Message-ID: <200906232330.20519.elendil@planet.nl>
References: <200906222101.38586.elendil@planet.nl> <200906230951.24615.elendil@planet.nl> <20090623.035926.155211513.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpsmtpm-eml103.kpnxchange.com ([195.121.3.7]:49553 "EHLO
	CPSMTPM-EML103.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756227AbZFWVaT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 17:30:19 -0400
In-Reply-To: <20090623.035926.155211513.davem@davemloft.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: bzolnier@gmail.com, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 23 June 2009, David Miller wrote:
> ide-cd: Don't warn on bogus block size unless it actually matters.
>
> Frans Pop reported that his CDROM drive reports a blocksize of 2352,
> and this causes new warnings due to commit
> e8e7b9eb11c34ee18bde8b7011af41938d1ad667 ("ide-cd: fix oops when using
> growisofs").
>
> What we're trying to do is make sure that "blocklen >> SECTOR_BITS"
> is something the block layer won't choke on.
>
> And for Frans case "2352 >> SECTOR_BITS" is equal to
> "2048 >> SECTOR_BITS", and thats "4".

Pedantic correction: Frans' case

> So warning in this case gives no real benefit.
>
> Reported-by: Frans Pop <elendil@planet.nl>
> Signed-off-by: David S. Miller <davem@davemloft.net>

As expected, it's gone. Nice.

Tested-by: Frans Pop <elendil@planet.nl>
