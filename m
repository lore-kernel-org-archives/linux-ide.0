From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH RFC] sata_promise: make pdc_atapi_pkt() use values from
 qc->tf
Date: Mon, 26 Nov 2007 21:18:38 +0900
Message-ID: <474AB99E.3030109@gmail.com>
References: <200711261200.lAQC0vFd029485@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:16108 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754232AbXKZMSp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Nov 2007 07:18:45 -0500
Received: by rv-out-0910.google.com with SMTP id k20so501617rvb
        for <linux-ide@vger.kernel.org>; Mon, 26 Nov 2007 04:18:44 -0800 (PST)
In-Reply-To: <200711261200.lAQC0vFd029485@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

Hello,

Mikael Pettersson wrote:
>>  	buf[20] = (1 << 5) | ATA_REG_FEATURE;
>>  	buf[21] = feature;
>>  	buf[22] = (1 << 5) | ATA_REG_BYTEL;
>> -	buf[23] = nbytes & 0xFF;
>> +	buf[23] = qc->tf.lbam;
>>  	buf[24] = (1 << 5) | ATA_REG_BYTEH;
>> -	buf[25] = (nbytes >> 8) & 0xFF;
>> +	buf[25] = qc->tf.lbah;
> 
> The original code matches what Promise' own driver does, including
> the "set byte counter register to real transfer byte count" comment.
> It's certainly possible that if lbah/lbam don't match ->nbytes,
> the HW will go nuts. Their data sheets are very quiet about ATAPI.

Yeah, now core code sets the value properly and I just posted a patch to
massage transfer chunk size a bit so I was curious whether now
sata_promise can use the result of core layer instead.

> I can test your proposed change next weekend when I'm back to where
> my sata_promise test equipment is.

Thank you.

-- 
tejun
