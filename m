From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: implement BROKEN_HPA horkage and apply it to
 HDS724040KLSA80
Date: Wed, 08 Aug 2007 01:53:49 +0900
Message-ID: <46B8A39D.50401@gmail.com>
References: <20070807054250.GQ13674@htj.dyndns.org>	<20070807162529.1781b21c@the-village.bc.nu>	<46B89177.2040209@gmail.com> <20070807175340.0439b055@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:27059 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbXHGQx5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 12:53:57 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1440867rvb
        for <linux-ide@vger.kernel.org>; Tue, 07 Aug 2007 09:53:56 -0700 (PDT)
In-Reply-To: <20070807175340.0439b055@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org, kelk1@comcast.net, lcapitulino@mandriva.com.br

Alan Cox wrote:
>>> I'd rather know what is going on here. A drive can legitimately
>>> support LBA48 and HPA and refuse READ_NATIVE_MAX_EXT.
>> READ_NATIVE_MAX_EXT is mandatory if HPA && LBA48, no?
>
> No - and we hit this specific case in old IDE with some Maxtor drives.

Hmmm... Looking up the spec...  This is from ATA8-ACS 4.11.1.

  A device that implements the Host Protected Area feature set and
  supports the 48-bit Address feature set shall implement the following
  additional set of commands:
      a) READ NATIVE MAX ADDRESS EXT
      b) SET MAX ADDRESS EXT
  Devices supporting this feature set shall set IDENTIFY DEVICE data
  word 82 bit 10 to one.

Did older specs specify it differently?

>> Haven't tried that but the problem is that the drive times out
>> READ_NATIVE_MAX_EXT so it doesn't really matter whether the drive
>> succeeds READ_NATIVE_MAX or not.  For more detail, please read the
>> following thread.
>>
>>   http://thread.gmane.org/gmane.linux.ide/21322
>
> Thanks will do:
>
>> device reports in words 85-87 and 120, which libata currently doesn't
>> do.  Are we leaving this out intentionally (for broken devices) or just
>> did we just miss it?
>
> We missed it. I assume the drive in the blacklist sets it correctly
> however ?

Yes, it does.

-- 
tejun
