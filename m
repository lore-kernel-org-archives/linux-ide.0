From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.21-rc7-mm2 2/2] sata_promise: move port reset from
 error intr to EH prereset
Date: Wed, 02 May 2007 03:15:20 +0200
Message-ID: <4637E628.2030407@gmail.com>
References: <200705012029.l41KTmR5009121@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:25350 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030847AbXEBJRq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 May 2007 05:17:46 -0400
Received: by nz-out-0506.google.com with SMTP id o1so62590nzf
        for <linux-ide@vger.kernel.org>; Wed, 02 May 2007 02:17:46 -0700 (PDT)
In-Reply-To: <200705012029.l41KTmR5009121@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Mikael Pettersson wrote:
>> You really don't wanna schedule ATA_EH_SOFTRESET and freeze the port on
>> every error.  If you do that, ATAPI devices will be reset after each
>> CHECK CONDITION and it probably won't work properly.
> 
> Would that be hal polling to see if media has been inserted?

Yes, it can be hal.  It can be anything.  Raising CHECK CONDITION and
reporting the details via sense data is part of normal operations for
ATAPI devices.

>>  FWIW, libata EH
>> automatically issues softreset if the port is frozen (as that's the only
>> way to thaw the port), so setting EH_SOFTRESET is optional if you freeze
>> the port.
>>
>> Another problem is that EH may issue other commands to while trying to
>> recover - e.g. PACKET - REQUEST SENSE or READ LOG PAGE.  This only
>> happens if the port is ready for commands, IOW, !frozen.  Before, the
>> pdc_reset_port() used to be called on entry to EH if it's not frozen but
>> it's not after this patch.  Is this safe?
> 
> Oh dear. I assumed EH would only want to inspect the standard
> status registers, and that's why I wanted to delay the reset.
> If EH wants to talk to the device then it's a very bad idea to
> not have issued a pdc_reset_port() first.

Yeap, if port reset clears some registers, they need to be saved into
appropriate fields in ehi/c or qc.  If something isn't there, please let
me know.

Thanks.

-- 
tejun

