From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: implement BROKEN_HPA horkage and apply it to
 HDS724040KLSA80
Date: Wed, 08 Aug 2007 00:36:23 +0900
Message-ID: <46B89177.2040209@gmail.com>
References: <20070807054250.GQ13674@htj.dyndns.org> <20070807162529.1781b21c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:40583 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142AbXHGPg3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 11:36:29 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1424090rvb
        for <linux-ide@vger.kernel.org>; Tue, 07 Aug 2007 08:36:29 -0700 (PDT)
In-Reply-To: <20070807162529.1781b21c@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org, kelk1@comcast.net, lcapitulino@mandriva.com.br

Alan Cox wrote:
> On Tue, 7 Aug 2007 14:42:50 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> HDS724040KLSA80 reports that it supports HPA && LBA48 but craps itself
>> on READ_NATIVE_MAX_EXT.  Implement BROKEN_HPA horkage and apply it to
>> the drive.  If the horkage is set, all HPA operations are skipped.
> 
> I'd rather know what is going on here. A drive can legitimately
> support LBA48 and HPA and refuse READ_NATIVE_MAX_EXT.

READ_NATIVE_MAX_EXT is mandatory if HPA && LBA48, no?

> In addition just
> about every OS I know queries the HPA which means that something other
> than HPA support being broken is probably at the root. We thus want to
> find the real fix.
> 
> What do the actual traces look like ?
> 
> Does it crap out of it gets READ_NATIVE_MAX ?

Haven't tried that but the problem is that the drive times out
READ_NATIVE_MAX_EXT so it doesn't really matter whether the drive
succeeds READ_NATIVE_MAX or not.  For more detail, please read the
following thread.

  http://thread.gmane.org/gmane.linux.ide/21322

>> While at it, make HPA test a bit more reliable by also checking
>> ata_id_has_hpa().
> 
>>  
>> -			if (ata_id_hpa_enabled(dev->id))
>> +			if (!(dev->horkage & ATA_HORKAGE_BROKEN_HPA) &&
>> +			    ata_id_has_hpa(id) && ata_id_hpa_enabled(dev->id))
>>  				dev->n_sectors = ata_hpa_resize(dev);
> 
> A drive cannot set hpa_enabled without setting has_hpa so this does
> nothing and I've never seen a drive d what you try to cover here. I'd
> like to see actual evidence.

Well, it's what the ide driver does.  BTW, according to the spec, we
need to test bit 14 and 15 of word 87 before trusting any value the
device reports in words 85-87 and 120, which libata currently doesn't
do.  Are we leaving this out intentionally (for broken devices) or just
did we just miss it?

Thanks.

-- 
tejun
