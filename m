From: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH] Don't use UDMA on VIA UDMA33 controller with Transcend
 SSD
Date: Wed, 18 Nov 2009 13:04:27 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0911181303261.20509@hs20-bc2-1.build.redhat.com>
References: <20091118172258.59894130@lxorguk.ukuu.org.uk>
 <20091118.093233.83428970.davem@davemloft.net>
 <Pine.LNX.4.64.0911181245330.5068@hs20-bc2-1.build.redhat.com>
 <20091118.095346.231454962.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:13248 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755851AbZKRSEb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Nov 2009 13:04:31 -0500
In-Reply-To: <20091118.095346.231454962.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

On Wed, 18 Nov 2009, David Miller wrote:

> From: Mikulas Patocka <mpatocka@redhat.com>
> Date: Wed, 18 Nov 2009 12:46:37 -0500 (EST)
> 
> > And what will you do with 16G or 32G versions of the same device? You 
> > really think they use different controllers and are not affected?
> 
> Firmware changes often.

So use the firmware revision field to match it.

Mikulas
