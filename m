From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Don't use UDMA on VIA UDMA33 controller with Transcend
 SSD
Date: Wed, 18 Nov 2009 09:32:33 -0800 (PST)
Message-ID: <20091118.093233.83428970.davem@davemloft.net>
References: <20091117.043002.224755438.davem@davemloft.net>
	<Pine.LNX.4.64.0911181151140.5068@hs20-bc2-1.build.redhat.com>
	<20091118172258.59894130@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:45488
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757667AbZKRRcQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Nov 2009 12:32:16 -0500
In-Reply-To: <20091118172258.59894130@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: mpatocka@redhat.com, linux-ide@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 18 Nov 2009 17:22:58 +0000

>> Transcend makes various versions of their SSDs and all begin with TS. You 
>> can assume that Transcend SSDs with different capacity or format won't 
>> work too because they likely use the same controller. The naming is this:
> 
> You don't want to assume that because then you will never find out if
> there is no problem.

Agreed.

And if Alan's patch for the ATA layer is going to use an exact string
match, which it is, and we should do the same in the IDE layer to be
consistent.
