From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: How does libata handles an 'ATA_ABORTED' error?
Date: Wed, 14 Dec 2011 23:51:48 -0600
Message-ID: <4EE98AF4.7090509@gmail.com>
References: <201112140948.03859.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f53.google.com ([209.85.216.53]:57969 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab1LOFvv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Dec 2011 00:51:51 -0500
Received: by qadb15 with SMTP id b15so1070850qad.19
        for <linux-ide@vger.kernel.org>; Wed, 14 Dec 2011 21:51:50 -0800 (PST)
In-Reply-To: <201112140948.03859.jbe@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Juergen Beisert <jbe@pengutronix.de>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 12/14/2011 02:48 AM, Juergen Beisert wrote:
> Hi list,
>
> I have a CF card running in true-ide mode connected to regular PC. This CF
> card does wear leveling of its flash memory internally like every other CF
> card. With one exception: When the CF's firmware detects a broken NAND page
> while writing a sector, it moves around the remaining (good) data to other
> pages. To do this job it must discard the already transmitted sector data in
> its SRAM, because it needs this SRAM to move around the other flash memory
> data.
>
> After the movement the firmware signals an 'ATA_ERR' in the status register
> and an 'ATA_ABORTED' in the error register to force the host to repeat to
> write the same data again (next time it will be successfull due to internal
> wear leveling is already done).
>
> As we see data lost when the systems are running in production, I'm now trying
> to find out if the libata/SCSI layer really repeats the sector write for this
> case and does the expected (or required) things. But I'm lost in these
> software layers and their error path.
>
> I found (in Documentation/DocBook/libata.tmpl):
>
> "This is indicated by UNC bit in the ERROR register.  ATA
> devices reports UNC error only after certain number of
> retries cannot recover the data, so there's nothing much
> else to do other than notifying upper layer."
>
> which sounds to me as no repeat will happen for write errors, but
> the 'ATA_UNC' bit is not used to signal the "wear leveling case" shown above.

That seems like incorrect behavior by the device, ABRT is normally used 
to indicate an invalid or unsupported command. UNC would likely be more 
appropriate. But I don't think it ultimately makes a difference in this 
case.

>
> As far as I understand the ATA errors are transformed to SCSI errors and then
> handled in the SCSI layer. But the documentation tells me it is not easy to
> always find an adequate SCSI error for an ATA error. So, I'm not sure if for
> the "wear leveling case" the SCSI layer receives a "valuable" error message.

 From what I can see the SCSI error that gets returned in this case is 
just an "aborted command" error.

>
> Does anybody can give me a hint, what really happens when the attached drive
> signals an 'ATA_ABORTED'? Does the libata/SCSI give up in this case, or will
> it repeat the command?

I don't know that the SCSI or block layers really pay much attention to 
the error code in this case - I think it would always attempt some retries.

Certainly any of these errors would result in error messages showing up 
in dmesg. Are you seeing any of this?
