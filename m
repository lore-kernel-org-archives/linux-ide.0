From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Don't use UDMA on VIA UDMA33 controller with Transcend
 SSD
Date: Tue, 17 Nov 2009 04:30:02 -0800 (PST)
Message-ID: <20091117.043002.224755438.davem@davemloft.net>
References: <Pine.LNX.4.64.0910260731460.21316@hs20-bc2-1.build.redhat.com>
	<20091026121804.3789c4c0@lxorguk.ukuu.org.uk>
	<Pine.LNX.4.64.0911042021530.19963@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:42910
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752097AbZKQM3p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Nov 2009 07:29:45 -0500
In-Reply-To: <Pine.LNX.4.64.0911042021530.19963@hs20-bc2-1.build.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mpatocka@redhat.com
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 4 Nov 2009 20:25:21 -0500 (EST)

> Don't use UDMA on VIA UDMA33 controller with Transcend SSD
> 
> The computer locks up if Transcend SSD runs in any of UDMA modes.
> It doesn't lockup with different brand SSD, so this is specific to Transcend.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Mikulas, I'm happy to apply this if you match on the full
ID string, not just "TS".

Please update your patch and I'll push it upstream.

Thank you.
