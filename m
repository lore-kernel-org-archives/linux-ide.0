From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata errors with smartctl on 2.6.24, WD3200AAKS and nVidia
 AHCI
Date: Wed, 14 May 2008 16:29:18 +0900
Message-ID: <482A94CE.5060705@gmail.com>
References: <200804092130.07149.tvrtko@ursulin.net> <200804150721.17337.tvrtko@ursulin.net> <482A7C2C.6040302@gmail.com> <200805140758.53407.tvrtko@ursulin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:53839 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342AbYENH31 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 May 2008 03:29:27 -0400
Received: by wa-out-1112.google.com with SMTP id j37so4621560waf.23
        for <linux-ide@vger.kernel.org>; Wed, 14 May 2008 00:29:27 -0700 (PDT)
In-Reply-To: <200805140758.53407.tvrtko@ursulin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Tvrtko A. Ursulin" <tvrtko@ursulin.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Bruce Allen <ballen@gravity.phys.uwm.edu>

Tvrtko A. Ursulin wrote:
> On Wednesday 14 May 2008 06:44:12 Tejun Heo wrote:
>> Tvrtko A. Ursulin wrote:
>>> On Tuesday 15 April 2008 04:10:57 Tejun Heo wrote:
>>>> Tvrtko A. Ursulin wrote:
>>>>> On Sunday 13 April 2008 04:11:15 Tejun Heo wrote:
>>>>>> Is auto spindown configured for the drive?
>>>>> I don't think so - it's a 3.5" drive with no special PM features - but
>>>>> how to tell?
>>>> Hmm... Can you please post the result of "smartctl --version" and
>>>> "smartctl -a > out 2>&1" and dmesg after the smartctl command?
>>> Yep, pasted and attached below. dmesg is 67k, hope list is happy with
>>> that.
>> Thanks for the data.  Nothing really stands out tho.  It looks like the
>> drive just doesn't like SMART commands 0xda and 0xd1.  0xda being a
>> mandatory non-data command, it failing due to driver problem is unlikely.
>>
>> Can you please post the result of "hdparm -I /dev/sda" and "lspci -nn"?
> 
> Of course:
> 
> root@sol:~# hdparm -I /dev/sda
> 
> /dev/sda:
> 
> ATA device, with non-removable media
>         Model Number:       WDC WD3200AAKS-00VYA0
>         Serial Number:      WD-WCARW0059893
>         Firmware Revision:  12.01B02

> 00:0e.0 SATA controller [0106]: nVidia Corporation GeForce 7100/nForce 630i [10de:07f4] (rev a2)

Hmmm.. WD3200 w/ nv ahci.  WD3200 having trouble with smart commands is 
unlikely.  Is it possible for you try different drive on the controller 
and see whether smartctl works on it?

Thanks.

-- 
tejun
