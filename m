From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Don't use UDMA on VIA UDMA33 controller with Transcend
 SSD
Date: Wed, 18 Nov 2009 09:53:46 -0800 (PST)
Message-ID: <20091118.095346.231454962.davem@davemloft.net>
References: <20091118172258.59894130@lxorguk.ukuu.org.uk>
	<20091118.093233.83428970.davem@davemloft.net>
	<Pine.LNX.4.64.0911181245330.5068@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:51858
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758140AbZKRRxa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Nov 2009 12:53:30 -0500
In-Reply-To: <Pine.LNX.4.64.0911181245330.5068@hs20-bc2-1.build.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mpatocka@redhat.com
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 18 Nov 2009 12:46:37 -0500 (EST)

> And what will you do with 16G or 32G versions of the same device? You 
> really think they use different controllers and are not affected?

Firmware changes often.
