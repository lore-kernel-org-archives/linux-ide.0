From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: QNAP TS-419: sata_mv fails to initialise with "can't set global
 reset"
Date: Tue, 02 Jun 2015 15:38:43 +0200
Message-ID: <556DB1E3.3060304@free-electrons.com>
References: <1433068534.5748.276.camel@debian.org>	 <20150601025050.GB11354@lunn.ch> <1433192857.5748.288.camel@debian.org>	 <20150601210702.GN22739@lunn.ch> <1433229292.5748.291.camel@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:58474 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753657AbbFBNip (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Jun 2015 09:38:45 -0400
In-Reply-To: <1433229292.5748.291.camel@debian.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ian Campbell <ijc@debian.org>, Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org

On 02/06/2015 09:14, Ian Campbell wrote:
> On Mon, 2015-06-01 at 23:07 +0200, Andrew Lunn wrote:
>> On Mon, Jun 01, 2015 at 10:07:37PM +0100, Ian Campbell wrote:
>>> On Mon, 2015-06-01 at 04:50 +0200, Andrew Lunn wrote:
>>>> You might also want to try 
>>>>
>>>> http://comments.gmane.org/gmane.linux.ports.arm.kernel/416589
>>>>
>>>> In particular the first patch.
>>>
>>> That did the trick, thanks!
>>
>> Great.
>>
>> A tested-by: for that patch will help grease the path into the kernel.
> 
> I think it's already been applied to Gregory's tree, but I replied with
> a T-b anyway.

Yes and it was already pull in the arm-soc tree.

However thanks for testing it.

Gregory

> 
> Thanks again,
> Ian.
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
