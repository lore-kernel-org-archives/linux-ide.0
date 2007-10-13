From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.23-mm1
Date: Sat, 13 Oct 2007 14:41:50 -0400
Message-ID: <4711116E.7070300@garzik.org>
References: <20071011213126.cf92efb7.akpm@linux-foundation.org>	 <20071012013729.ada2127b.akpm@linux-foundation.org>	 <64bb37e0710130101y7fb8e4c0lf214fd821e8305ed@mail.gmail.com>	 <4710A407.3070000@garzik.org>	 <64bb37e0710130503haa66d6eu93e75ecdc78ac866@mail.gmail.com>	 <4710B7C5.5050403@garzik.org>	 <64bb37e0710130732p303547e3n54cfa9dac34c53b5@mail.gmail.com>	 <64bb37e0710130740u78613f83wbd4f43d073bbe13d@mail.gmail.com>	 <64bb37e0710130813le68c48dve36f8473b197b84b@mail.gmail.com>	 <47110500.8050503@garzik.org> <64bb37e0710131105m7c64fca0kb71f3955170e8bec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39325 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761711AbXJMSlx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Oct 2007 14:41:53 -0400
In-Reply-To: <64bb37e0710131105m7c64fca0kb71f3955170e8bec@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Torsten Kaiser <just.for.lkml@googlemail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>, Peer Chen <pchen@nvidia.com>

Torsten Kaiser wrote:
> On 10/13/07, Jeff Garzik <jeff@garzik.org> wrote:
>> Torsten Kaiser wrote:
>>> 3 boots, all worked. So I'm very sure that was the bug, but I will now
>>> do a little load testing...
>>>
>>> The only strange thing about 2.6.23-mm1 is, that it takes ~4 second
>>> more to boot.
>> So, you basically applied the attached patch?
>>
>> Yeah, absence of qc_defer for an NCQ-capable chip would do it.
> 
> Yes. The system seems to work correctly now.

Thanks for helping track this down.  Fix pushed out to libata-dev.git.

	Jeff



