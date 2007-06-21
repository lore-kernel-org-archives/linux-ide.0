From: Tejun Heo <htejun@gmail.com>
Subject: Re: CF flash IDE failure to attach with 2.6.20+
Date: Thu, 21 Jun 2007 12:02:27 +0900
Message-ID: <4679EA43.4040002@gmail.com>
References: <11172839.post@talk.nabble.com>	<46766BD3.4040702@gmail.com> <20070618125742.28a0bc57@the-village.bc.nu> <46770edc.101d640a.4fdf.4eae@mx.google.com> <46776306.5030300@gmail.com> <4679cefc.06d7720a.0280.ffff9cce@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:7240 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758920AbXFUDCb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jun 2007 23:02:31 -0400
Received: by wa-out-1112.google.com with SMTP id v27so154077wah
        for <linux-ide@vger.kernel.org>; Wed, 20 Jun 2007 20:02:31 -0700 (PDT)
In-Reply-To: <4679cefc.06d7720a.0280.ffff9cce@mx.google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Hall <andrew.a.hall@gmail.com>
Cc: 'Alan Cox' <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, 'Jeff Garzik' <jeff@garzik.org>

Andrew Hall wrote:
>> I suppose you were using ata_piix too in older kernel, right?  Can you
>> post the boot dmesg of 2.6.19?  We used to ignore mwdma mode before and
>> enabled it at some point after that.  That may be the cause here.
>>
>> Also, please try the attached patch on top of 2.6.20.
> 
> Sorry guys, I've actually got it wrong. The hardware that I have been
> testing on has a different chipset: Intel ICH8, to what I was using
> previously with success with 2.6.19 (this was ICH4 based hardware) - so the
> driver is actually different now. 
> 
> Tejun, your patch for 2.6.20 failed with the same errors.
> 
> For completeness I have tested the newer ICH8 hardware with everything from
> 2.6.15 through to 2.6.21.5 using the ata_piix drivers and it (the Compact
> Flash) fails in all kernels. Here is the (relevant) dmesg from 2.6.21.5
> showing the CF being disabled:

Does piix driver work?  If so, can you post boot dmesg and the result of
'hdparm -I /dev/hdX'?

-- 
tejun
