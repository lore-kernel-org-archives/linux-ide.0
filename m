From: Tejun Heo <htejun@gmail.com>
Subject: Re: FW: LIBATA issue with SATA drive
Date: Fri, 19 Oct 2007 14:05:53 +0900
Message-ID: <47183B31.4080002@gmail.com>
References: <AF1760336DB49F43983B755855C2A46702AF744B@troe2k1.cs.myharris.net>	 <4716DC7D.6050007@gmail.com>	 <64bb37e0710181152j7d070258w9b9eeb59cf1f0a1d@mail.gmail.com>	 <471804CA.9040103@gmail.com> <64bb37e0710182151j6992cde3u4f9ae60aa70e22eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:56137 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181AbXJSFGN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Oct 2007 01:06:13 -0400
Received: by rv-out-0910.google.com with SMTP id k20so361692rvb
        for <linux-ide@vger.kernel.org>; Thu, 18 Oct 2007 22:06:13 -0700 (PDT)
In-Reply-To: <64bb37e0710182151j6992cde3u4f9ae60aa70e22eb@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Torsten Kaiser <just.for.lkml@googlemail.com>
Cc: "Ip, Clarence" <CIP@harris.com>, linux-ide@vger.kernel.org, jens.axboe@oracle.com

Torsten Kaiser wrote:
> On 10/19/07, Tejun Heo <htejun@gmail.com> wrote:
>> Torsten Kaiser wrote:
>>> I'm currently using 2.6.23-mm1 and 16 boots where all good.
>>> (Apart from the unrelated failure with sata_nv and swncq...)
>> I see, a different issue then.  It's just weird to see similar issues
>> popping up now after allterm the time sata_sil24 has been around.
> 
> Just remebered another thing about sata_sil24 that popped up with 2.6.23-mm1.
> With this kernel version (comparing to 2.6.23-rc8-mm1) the port
> probing time goes up from ~0.5 seconds per port/drive to ~2 seconds.
> Also the SControl changed:
> 
> 2.6.23-rc8-mm1:
> [    4.110000] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> 2.6.23-mm1:
> [    5.930000] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> 
> But except for increased delay during boot no errors can seen, the
> drives work normally.

Yeah, PARTIAL / SLUMBER mode restriction is lifted.  Dunno whether 
that's related to the increased delay tho.  Will investigate.

-- 
tejun
