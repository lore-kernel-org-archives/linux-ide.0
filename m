From: thomas schorpp <thomas.schorpp@googlemail.com>
Subject: Re: HSM violations from ATA PACKET cmd ABRT errors in initial comms
 with   LG GH22 SATA DVDRW
Date: Wed, 20 Jan 2010 08:57:34 +0100
Message-ID: <4B56B76E.9030304@gmail.com>
References: <4B37C58D.2090200@gmail.com>	<4B37D50F.4010804@gmail.com>	<19257.17141.825766.63548@pilspetsen.it.uu.se> <19265.3552.13209.914969@pilspetsen.it.uu.se> <4B5671DA.7000904@gmail.com>
Reply-To: thomas.schorpp@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:44303 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682Ab0ATH5i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jan 2010 02:57:38 -0500
Received: by fxm25 with SMTP id 25so270915fxm.21
        for <linux-ide@vger.kernel.org>; Tue, 19 Jan 2010 23:57:36 -0800 (PST)
In-Reply-To: <4B5671DA.7000904@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello, Mikael.
> 
> On 01/04/2010 06:36 AM, Mikael Pettersson wrote:
>> I've looked at the available AC_ERR_ values and how they're treated by
>> libata-eh, and to avoid resets but allow for retries it seems that one
>> should use AC_ERR_OTHER, or possibly AC_ERR_DEV, or possibly no AC_ERR_
>> at all (i.e., zero). So please first try the patch below. If it doesn't
>> eliminate the reset loop, change the AC_ERR_OTHER to AC_ERR_DEV and try
>> again. And if that one still causes reset loops, try a plain 0.
>>
>> /Mikael
>>
>> --- linux-2.6.32/drivers/ata/sata_promise.c.~1~	2009-12-03 12:38:32.000000000 +0100
>> +++ linux-2.6.32/drivers/ata/sata_promise.c	2010-01-03 22:08:08.000000000 +0100
>> @@ -862,7 +862,7 @@ static void pdc_error_intr(struct ata_po
>>  	if (port_status & PDC_DRIVE_ERR)
>>  		ac_err_mask |= AC_ERR_DEV;
>>  	if (port_status & (PDC_OVERRUN_ERR | PDC_UNDERRUN_ERR))
>> -		ac_err_mask |= AC_ERR_HSM;
>> +		ac_err_mask |= AC_ERR_OTHER; /* or AC_ERR_DEV, or zero */
> 
> I think AC_ERR_OTHER can still be too much.  AC_ERR_* bits should only
> be set when the command failed for that reason.  Here, underrun is

Overruns from my port status log, not underruns?
port_status 0x20280000, 0x2020, (Data Transfer Overrun Error & Target Device Fault)? 

> expected, so not really an error condition.  But, for example, under
> or overrun for an ATA R/W command should trigger HSM failure.  I think
> the above error detection logic needs to be improved a bit.

Well I generally don't feel comfortable with any unknown state output EHs, too, 
but if ata spec conformant, we're fine, aren't we?

y
tom
