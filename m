From: Tejun Heo <htejun@gmail.com>
Subject: Re: CF as IDE on ICH6M using libata
Date: Sat, 08 Sep 2007 16:10:20 +0900
Message-ID: <46E24ADC.2000500@gmail.com>
References: <6f9550040709020542h530f0bfap5b01fb4ff0c00f25@mail.gmail.com>	 <46DAB5DD.80807@gmail.com> <46DEE72B.2060702@rtr.ca> <6f9550040709051503k5b0a07b1x3e21bae3667ce17@mail.gmail.com> <46E03DF6.8090405@gmail.com> <46E1545A.5000404@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.228]:33942 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460AbXIHRHI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 13:07:08 -0400
Received: by qb-out-0506.google.com with SMTP id e11so714240qbe
        for <linux-ide@vger.kernel.org>; Sat, 08 Sep 2007 10:07:07 -0700 (PDT)
In-Reply-To: <46E1545A.5000404@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Eddie Hung <eddie.hung@gmail.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Tejun Heo wrote:
>> Eddie Hung wrote:
>>> However, I think we can conclude that ICH6M (which on the X41, has a
>>> SATA-PATA bridge to connect a PATA drive) does not seem to support
>>> MWDMA
>>
>> It isn't clear whether the fault is at the driver or the CF device.
> 
> It's probably the bridge chip --> we've run through that one before
> just recently (early summer?) on this list.  A particular bridge that
> doesn't work at all with MWDMA.

Hmmm... How do we solve this situation?  Till now, we've been
blacklisting the device IDs but it doesn't work for broken bridges.
Maybe we should default to not using MWDMA by default?

-- 
tejun

