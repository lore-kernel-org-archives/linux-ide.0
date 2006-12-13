From: Tejun Heo <htejun@gmail.com>
Subject: Re: [COORDINATE] INIC-1620TA/1622TA2/1623TA2 SATA controllers from
 initio
Date: Wed, 13 Dec 2006 10:44:47 +0900
Message-ID: <457F5B0F.9040201@gmail.com>
References: <43D646C2.6040104@gmail.com>	<ekn6pj$9dt$1@sea.gmane.org>	<20061201134818.3071445f@localhost.localdomain>	<20061201172042.GA6369@kiste.smurf.noris.de>	<7827233.post@talk.nabble.com> <20061212120332.4457768d@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:18613 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964882AbWLMBoz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Dec 2006 20:44:55 -0500
Received: by nz-out-0506.google.com with SMTP id s1so8228nze
        for <linux-ide@vger.kernel.org>; Tue, 12 Dec 2006 17:44:55 -0800 (PST)
In-Reply-To: <20061212120332.4457768d@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Leigh <nabble@theanthonys.net>, linux-ide@vger.kernel.org

Hi,

Alan wrote:
>>
>> How did this go?  I doubt I'm the only one who fell afoul of the "has linux
>> drivers" implication on initio's website...
>>
>> I know its early days, but any idea when this might be ready for production?
> 
> I sent Tejun the data book but we've yet to succeed in cloning him or
> getting him a time machine. 
> 
> I had a look at it. The chip is a little weird so it'll take someone a
> while to write a driver for it and they'll need the hardware handy.

The chip really is weird.  For some reason, I can't do ATA PIO from mmio
TF but can do so using BAR{0,2}.  It does have sff-compliant BAR0-3 but
no BMDMA at BAR4.  And it can't do more than 256 sects at a time.  Ah...
also, SRST nor phy reset via SControl doesn't give valid device
signature.  Only hardreset via IDMA_CTRL works.  Bah...

Anyways, I'm getting there.  My 1622 is happily transferring 76M file
without problem in and out of a seagate harddrive using pio mode.  So,
please standby.

-- 
tejun
