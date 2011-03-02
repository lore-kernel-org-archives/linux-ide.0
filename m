From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: libata default FUA support
Date: Tue, 01 Mar 2011 18:54:05 -0600
Message-ID: <4D6D952D.8030609@gmail.com>
References: <20110301203313.GA1656@gentoo.trippels.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:41182 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757226Ab1CBAyJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Mar 2011 19:54:09 -0500
Received: by qyk7 with SMTP id 7so3821936qyk.19
        for <linux-ide@vger.kernel.org>; Tue, 01 Mar 2011 16:54:08 -0800 (PST)
In-Reply-To: <20110301203313.GA1656@gentoo.trippels.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On 03/01/2011 02:33 PM, Markus Trippelsdorf wrote:
> FUA support is currently switched off by default in
> drivers/ata/libata-core.c.
> Given that many modern drives do support FUA now, wouldn't it make sense
> to switch it on without setting a (undocumented) kernel/module
> parameter?

I believe I proposed this some time ago. Essentially all modern drives 
should support FUA now, since it's part of the definition of the NCQ 
(FPDMA) read/write commands. However, as I recall one of the objections 
to enabling it was that since it's just a bit in a command, there's a 
possibility that some drives may ignore it by accident or design, which 
is less likely with an explicit cache flush command. I'm not very 
inclined to agree myself (if you go down that road of pre-emptively 
predicting drive implementer stupidity, where do you stop?) but that's 
what was raised.

Another complication is that NCQ can be disabled at runtime either by 
user request or by error-handling fallback, and not all drives that 
support NCQ also support the FUA versions of the non-NCQ read/write 
commands, so changes in NCQ enable status may also need to result in 
changes in FUA support status on the block device.

I believe the way the block layer uses it, basically it only saves the 
overhead of one transaction to the drive. It might be significant on 
some workloads (especially on high IOPS drives like SSDs) but it's 
likely not a huge deal.
