From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/2] fix libata-sff and pata_cmd64x to not crash on
 boot on parisc
Date: Mon, 18 Apr 2011 13:14:51 -0700 (PDT)
Message-ID: <20110418.131451.116389641.davem@davemloft.net>
References: <1303152147.7167.12.camel@mulgrave.site>
	<20110418205203.56bbdb14@lxorguk.ukuu.org.uk>
	<1303157287.7167.26.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1303157287.7167.26.camel@mulgrave.site>
Sender: linux-parisc-owner@vger.kernel.org
To: James.Bottomley@HansenPartnership.com
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, linux-parisc@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Mon, 18 Apr 2011 15:08:07 -0500

> On Mon, 2011-04-18 at 20:52 +0100, Alan Cox wrote:
>> On Mon, 18 Apr 2011 13:42:27 -0500
>> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
>> 
>> > currently libata-sff is completely ignoring the enabled/disabled status
>> > of the interfaces. 
>> 
>> Yes - it makes some machines work rather better because the BIOSes
>> sometimes mess up the registers. It wad a *deliberate* decision not to
>> port it over and as a result stuff works that failed before. Windows
>> drivers clearly ignore the bits in many cases.
> 
> Well your deliberate decision is crashing my box on boot.  That makes
> this a regression from the IDE cmd64x driver. I hear indirectly there's
> a similar problem on sparc.

Yep, similar problems exist on sparc64, bus errors.
