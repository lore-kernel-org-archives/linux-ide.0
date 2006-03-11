From: Tejun Heo <htejun@gmail.com>
Subject: Re: gigabyte iRam not seen by linux
Date: Sun, 12 Mar 2006 01:33:23 +0900
Message-ID: <4412FBD3.2040604@gmail.com>
References: <20060310013604.1acac722.pegasus@nerv.eu.org>	 <4411BCB6.5080108@gmail.com> <44122FBD.9000909@tw.ibm.com>	 <20060311034630.4c12cf83.pegasus@nerv.eu.org>	 <20060311033143.GA12866@htj.dyndns.org>	 <20060311092013.487c1263.pegasus@nerv.eu.org>	 <20060311085843.GA9067@htj.dyndns.org> <311601c90603110812t1f853d2ep333a2299fbb0d6b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.207]:57459 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751284AbWCKQdm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Mar 2006 11:33:42 -0500
Received: by xproxy.gmail.com with SMTP id i30so116396wxd
        for <linux-ide@vger.kernel.org>; Sat, 11 Mar 2006 08:33:41 -0800 (PST)
In-Reply-To: <311601c90603110812t1f853d2ep333a2299fbb0d6b2@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: Jure Pe??ar <pegasus@nerv.eu.org>, linux-ide@vger.kernel.org, albertl@mail.com, jgarzik@pobox.com

Eric D. Mudama wrote:
> On 3/11/06, Tejun Heo <htejun@gmail.com> wrote:
> 
>>Hello, again.
>>
>>It's reporting 0x00 for FEATURE when it should report 0x01 (indicates
>>diagnostic passed).
> 
> 
> Um, do you mean the error register?  Either way, yea, it would appear
> that the device is reporting that it failed its own internal
> diagnostics.

Yeap, I did mean the error register. To deal with iRam, it seems that we 
just have to ignore the diagnostic code. I wonder how the diagnostic 
code would look like on ata_piix.

-- 
tejun
