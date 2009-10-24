From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with
 SSD
Date: Sat, 24 Oct 2009 04:31:04 -0700 (PDT)
Message-ID: <20091024.043104.143081386.davem@davemloft.net>
References: <200910212139.24675.bzolnier@gmail.com>
	<20091021.174155.44894825.davem@davemloft.net>
	<200910241328.40965.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:57519
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753140AbZJXLal (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Oct 2009 07:30:41 -0400
In-Reply-To: <200910241328.40965.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: elendil@planet.nl
Cc: bzolnier@gmail.com, mpatocka@redhat.com, linux-ide@vger.kernel.org

From: Frans Pop <elendil@planet.nl>
Date: Sat, 24 Oct 2009 13:28:39 +0200

> On Thursday 22 October 2009, David Miller wrote:
>> The most conservative thing to do is to set the flag as
>> is done by mpatocka's patch but I'd like Frans to regression
>> test that on his ultra5.
>>
>> Frans can you do that?
> 
> Sure, if you send me the patch (or a link to it). May take a few days.

It's here:

http://patchwork.ozlabs.org/patch/36615/

Also, all pending IDE patches can always be found at:

http://patchwork.ozlabs.org/project/linux-ide/list/

> Also, is it still needed given the whole discussion that happened after 
> this mail?

Yes, I still fully intend to apply mpatocka's patch, as-is.
