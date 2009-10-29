From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with
 SSD
Date: Thu, 29 Oct 2009 03:02:26 -0700 (PDT)
Message-ID: <20091029.030226.237971377.davem@davemloft.net>
References: <200910241328.40965.elendil@planet.nl>
	<20091024.043104.143081386.davem@davemloft.net>
	<200910250348.33308.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:54814
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753584AbZJ2KCD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Oct 2009 06:02:03 -0400
In-Reply-To: <200910250348.33308.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: elendil@planet.nl
Cc: bzolnier@gmail.com, mpatocka@redhat.com, linux-ide@vger.kernel.org

From: Frans Pop <elendil@planet.nl>
Date: Sun, 25 Oct 2009 03:48:32 +0100

> On Saturday 24 October 2009, David Miller wrote:
>> > On Thursday 22 October 2009, David Miller wrote:
>> >> The most conservative thing to do is to set the flag as
>> >> is done by mpatocka's patch but I'd like Frans to regression
>> >> test that on his ultra5.
>> >>
>> >> Frans can you do that?
>> >
>> > Sure, if you send me the patch (or a link to it). May take a few days.
>>
>> It's here:
>> http://patchwork.ozlabs.org/patch/36615/
> 
> Looks to work OK on my system. dmesg shows ide0 and ide1 are now 
> serialized.

Thanks a lot for testing Frans, I've applied Mikulas's patch
to ide-2.6
