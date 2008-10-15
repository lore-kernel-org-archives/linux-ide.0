From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_sil for 3512A chip on kernel 2.6.26.3
Date: Wed, 15 Oct 2008 16:06:02 +0900
Message-ID: <48F5965A.5000709@kernel.org>
References: <48E48BF2.1010403@gmail.com> <48E71DBC.5090301@kernel.org> <48F47924.9040504@gmail.com> <48F54E4C.1020704@kernel.org> <48F58FBE.909@gmail.com> <48F591CC.6090609@kernel.org> <48F595CA.5000807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54018 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400AbYJOHIF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Oct 2008 03:08:05 -0400
In-Reply-To: <48F595CA.5000807@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Damazy <damazy@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Damazy wrote:
> Tejun Heo wrote:
>> Damazy wrote:
>>> Error 190 occurred at disk power-on lifetime: 0 hours (0 days + 0 hours)
>>>   When the command that caused the error occurred, the device was active
>>> or idle.
>>
>> The time record seems screwed.
>>
>>>   After command completion occurred, registers were:
>>>   ER ST SC SN CL CH DH
>>>   -- -- -- -- -- -- --
>>>   84 51 3f 00 ee 1d e0  Error: ICRC, ABRT 63 sectors at LBA = 0x001dee00
>>> = 1961472
>>
>> But the recorded error is consistent with the kernel messages.  It
>> looks like you're suffering serious transmission problem over the SATA
>> cable.  Those transmission errors appear as timeouts or when the drive
>> detects it ABRTs w/ ICRC.  Please check cable, power and try to
>> connect the drive to other ports.
>>
>> Thanks.
>>
> 
> I'v already try several cable and external power supply, but with the
> same result.
> This sata chip have only two sata port. If I connect to other one,
> errors still appear.
> I don't know what can I do else.
> The only thing works fine is when I copy something from disk connected
> to my Intel 82801DB (ICH4).

I'm afraid there's nothing much can be done from the driver here.  Looks
like your drive's PHY is just bonkers or it just doesn't like talking to
the controller.  Can you try the drive on a different controller?

Thanks.

-- 
tejun
