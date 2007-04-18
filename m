From: Tejun Heo <htejun@gmail.com>
Subject: Re: Loud "pop" coming from hard drive on reboot
Date: Thu, 19 Apr 2007 00:25:13 +0900
Message-ID: <46263859.2060309@gmail.com>
References: <88SeR-5Sf-15@gated-at.bofh.it>	<88Sov-662-3@gated-at.bofh.it>	<88SHV-6uL-29@gated-at.bofh.it>	<8agVk-3wc-81@gated-at.bofh.it>	<8b3IR-4mE-25@gated-at.bofh.it>	<8b3SA-4z3-5@gated-at.bofh.it>	<8b42g-51N-15@gated-at.bofh.it>	<8bbdm-7iS-27@gated-at.bofh.it>	<E1He8dA-0000mw-LI@be1.lrz>	<46260981.1040109@gmail.com>	<20070418132904.3322ba5f@the-village.bc.nu>	<46261337.3010406@gmail.com>	<20070418140346.636879a1@the-village.bc.nu>	<46262C0E.9000103@rtr.ca> <20070418160627.7ab77c30@the-village.bc.nu> <46263650.3080705@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:18415 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992764AbXDRPZY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Apr 2007 11:25:24 -0400
Received: by wr-out-0506.google.com with SMTP id 76so183886wra
        for <linux-ide@vger.kernel.org>; Wed, 18 Apr 2007 08:25:23 -0700 (PDT)
In-Reply-To: <46263650.3080705@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, 7eggert@gmx.de, Chuck Ebbert <cebbert@redhat.com>, emisca <emisca.ml@gmail.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>

Mark Lord wrote:
> Alan Cox wrote:
>>> +        if (dev->needs_flush && ata_try_flush_cache(dev)) {
>>>              return ata_scsi_flush_xlat;
>>> +            dev->needs_flush = 0;
>>
>> Works better if you swap the dev-> and return lines
> 
> Heh, yeah, I noticed that!
> 
> Here it is, *tested* now, with another fix.
> 
> It would be nice if somebody who can hear the "pop" would also test this,
> as it will confirm that this is a complete fix for the problem.

You'll probably be able to here the "pop" on sleep-to-disk.

> My "pop" drives are busy elsewhere right now.
> 
> Tejun might use something like this, or do something better in libata-core,
> but it's still helpful to have confirmation that we're on the right track.

Yeap, I was thinking about more conservative check but this looks simple
and sweet.  :-)

-- 
tejun
