From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata errors with smartctl on 2.6.24, WD3200AAKS and nVidia
 AHCI
Date: Wed, 14 May 2008 14:44:12 +0900
Message-ID: <482A7C2C.6040302@gmail.com>
References: <200804092130.07149.tvrtko@ursulin.net> <200804130834.14257.tvrtko@ursulin.net> <48041CC1.1030909@gmail.com> <200804150721.17337.tvrtko@ursulin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:15887 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbYENFoU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 May 2008 01:44:20 -0400
Received: by wa-out-1112.google.com with SMTP id j37so4572303waf.23
        for <linux-ide@vger.kernel.org>; Tue, 13 May 2008 22:44:19 -0700 (PDT)
In-Reply-To: <200804150721.17337.tvrtko@ursulin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Tvrtko A. Ursulin" <tvrtko@ursulin.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Bruce Allen <ballen@gravity.phys.uwm.edu>

Tvrtko A. Ursulin wrote:
> On Tuesday 15 April 2008 04:10:57 Tejun Heo wrote:
>> Tvrtko A. Ursulin wrote:
>>> On Sunday 13 April 2008 04:11:15 Tejun Heo wrote:
>>>> Is auto spindown configured for the drive?
>>> I don't think so - it's a 3.5" drive with no special PM features - but
>>> how to tell?
>> Hmm... Can you please post the result of "smartctl --version" and
>> "smartctl -a > out 2>&1" and dmesg after the smartctl command?
> 
> Yep, pasted and attached below. dmesg is 67k, hope list is happy with that.

Thanks for the data.  Nothing really stands out tho.  It looks like the 
drive just doesn't like SMART commands 0xda and 0xd1.  0xda being a 
mandatory non-data command, it failing due to driver problem is unlikely.

Can you please post the result of "hdparm -I /dev/sda" and "lspci -nn"?

Bruce, WDC WD3200AAKS-00VYA0, 12.01B02 is timing out SMART commands 0xda 
and 0xd1 and the reported data seems all wrong.  Does it ring a bell? 
The original thread can be read from the following URL.

   http://thread.gmane.org/gmane.linux.ide/30459

Thanks.

-- 
tejun
