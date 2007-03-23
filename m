From: David Miller <davem@davemloft.net>
Subject: Re: HPA patches
Date: Fri, 23 Mar 2007 12:22:32 -0700 (PDT)
Message-ID: <20070323.122232.85421062.davem@davemloft.net>
References: <20070323191321.5d00887a@lxorguk.ukuu.org.uk>
	<20070323112411.f6a8a762.randy.dunlap@oracle.com>
	<20070323200819.4e734f4f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:38919
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S933345AbXCWTWe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Mar 2007 15:22:34 -0400
In-Reply-To: <20070323200819.4e734f4f@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: randy.dunlap@oracle.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kyle@canonical.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Fri, 23 Mar 2007 20:08:19 +0000

> u64 is always unsigned long long (and its debug anyway)

It's plain "unsigned long" on sparc64 and some other 64-bit platforms.
