From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/5] libata: Implement disk shock protection support
Date: Sun, 03 Aug 2008 12:19:56 +0900
Message-ID: <489523DC.2090903@gmail.com>
References: <87prp1kvyy.fsf@denkblock.local>	<20080726062142.29070.10413.stgit@denkblock.local>	<4892B8FE.1070400@gmail.com> <20080801233459.11e9b254@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:19168 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbYHCDUf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Aug 2008 23:20:35 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1083224waf.23
        for <linux-ide@vger.kernel.org>; Sat, 02 Aug 2008 20:20:34 -0700 (PDT)
In-Reply-To: <20080801233459.11e9b254@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Elias Oltmanns <eo@nebensachen.de>, Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Pavel Machek <pavel@ucw.cz>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Alan Cox wrote:
>> However, SATA or not, there simply isn't a way to abort commands in ATA.
>>  Issuing random command while other commands are in progress simply is
>> state machine violation and there will be many interesting results
>> including complete system lockup (ATA controller dying while holding the
>> PCI bus).  The only reliable way to abort in-flight commands are by
>> issuing hardreset.  However, ATA reset protocol is not designed for
>> quick recovery.  The machine is gonna hit the ground hard way before the
>> reset protocol is complete.
> 
> Actually you cau can issue idle immediate on older ATA devices. I am not
> clear if that was stuck back into the current accelerometer friendly
> drives or not. Would need to check with IBLenovo

Was that something intentional or was it a happy accident?  There can be
bus ownership problem on PATA and on SATA this is much more state logic
on both sides of the cable and I think things like that would be more
difficult to work accidentally.

Thanks.

-- 
tejun
