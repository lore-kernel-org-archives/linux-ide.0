From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream-fixes] ahci: fix module refcount breakage introduced
 by libahci split
Date: Tue, 21 Sep 2010 10:17:13 +0200
Message-ID: <4C986A09.3080808@gmail.com>
References: <201009162256.04765.pedrogfrancisco@gmail.com> <47010.148.87.67.141.1284674336.squirrel@www.xenotime.net> <4C933A8F.2080305@gmail.com> <1284892106.2650.4.camel@sundae-v2> <4C9602E4.4090007@gmail.com> <1284974726.11757.9.camel@sundae-v2> <4C9729D7.70500@gmail.com>  <4C972C60.8010506@gmail.com> <1285015465.26023.10.camel@sundae-v2> <4C97DB80.4060403@gmail.com> <4C97DBE2.8070707@gmail.com> <4C984D44.1080109@msgid.tls.msk.ru> <4C985DFC.7020203@gmail.com> <4C985F88.1010501@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47380 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756346Ab0IUIPk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Sep 2010 04:15:40 -0400
In-Reply-To: <4C985F88.1010501@msgid.tls.msk.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Jeff Garzik <jeff@garzik.org>, Pedro Francisco <pedrogfrancisco@gmail.com>, linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 09/21/2010 09:32 AM, Michael Tokarev wrote:
> 21.09.2010 11:25, Tejun Heo wrote:
>> libata depends on scsi_host_template for module reference counting and
>> sht's should be owned by each low level driver.  During libahci split,
>> the sht was left with libahci.ko leaving the actual low level drivers
>> not reference counted.  This made ahci and ahci_platform always
>> unloadable even while they're being actively used.
>>
>> Fix it by defining AHCI_SHT() macro in ahci.h and defining a sht for
>> each low level ahci driver.
>>
>> stable: only applicable to 2.6.35.
>>
>> Signed-off-by: Tejun Heo <tj@kernel.org>
>> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
>> Cc: stable@kernel.org
>> ---
>> Michael, thanks a lot for spotting it and bearing with me.
> Um.  All thanks goes to Pedro Francisco please, not to me -
> I just verified your patch on my system, it was Pedro who spotted
> and reported this.  You may add my
> 
>  Tested-Off-By: Michael Tokarev <mjt@tls.msk.ru>
> 
> , but not Reported-by... please ;)

Oh, right.  Jeff, can you please adjust tags to

  Reported-by: Pedro Francisco <pedrogfrancisco@gmail.com>
  Tested-by: Michael Tokarev <mjt@tls.msk.ru>

Thanks.

-- 
tejun
