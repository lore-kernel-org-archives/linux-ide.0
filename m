From: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: How does libata handles an 'ATA_ABORTED' error?
Date: Thu, 15 Dec 2011 12:01:14 +0100
Message-ID: <201112151201.15044.jbe@pengutronix.de>
References: <201112140948.03859.jbe@pengutronix.de> <4EE98AF4.7090509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34035 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728Ab1LOLCq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Dec 2011 06:02:46 -0500
In-Reply-To: <4EE98AF4.7090509@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Robert Hancock <hancockrwd@gmail.com>

Hi Robert,

Robert Hancock wrote:
> On 12/14/2011 02:48 AM, Juergen Beisert wrote:
> > I have a CF card running in true-ide mode connected to regular PC. This
> > CF card does wear leveling of its flash memory internally like every
> > other CF card. With one exception: When the CF's firmware detects a
> > broken NAND page while writing a sector, it moves around the remaining
> > (good) data to other pages. To do this job it must discard the already
> > transmitted sector data in its SRAM, because it needs this SRAM to move
> > around the other flash memory data.
> >
> > After the movement the firmware signals an 'ATA_ERR' in the status
> > register and an 'ATA_ABORTED' in the error register to force the host to
> > repeat to write the same data again (next time it will be successfull due
> > to internal wear leveling is already done).
> >
> > As we see data lost when the systems are running in production, I'm now
> > trying to find out if the libata/SCSI layer really repeats the sector
> > write for this case and does the expected (or required) things. But I'm
> > lost in these software layers and their error path.
> >
> > I found (in Documentation/DocBook/libata.tmpl):
> >
> > "This is indicated by UNC bit in the ERROR register.  ATA
> > devices reports UNC error only after certain number of
> > retries cannot recover the data, so there's nothing much
> > else to do other than notifying upper layer."
> >
> > which sounds to me as no repeat will happen for write errors, but
> > the 'ATA_UNC' bit is not used to signal the "wear leveling case" shown
> > above.
>
> That seems like incorrect behavior by the device, ABRT is normally used
> to indicate an invalid or unsupported command. UNC would likely be more
> appropriate. But I don't think it ultimately makes a difference in this
> case.

Okay.

> > As far as I understand the ATA errors are transformed to SCSI errors and
> > then handled in the SCSI layer. But the documentation tells me it is not
> > easy to always find an adequate SCSI error for an ATA error. So, I'm not
> > sure if for the "wear leveling case" the SCSI layer receives a "valuable"
> > error message.
>
>  From what I can see the SCSI error that gets returned in this case is
> just an "aborted command" error.
>
> > Does anybody can give me a hint, what really happens when the attached
> > drive signals an 'ATA_ABORTED'? Does the libata/SCSI give up in this
> > case, or will it repeat the command?
>
> I don't know that the SCSI or block layers really pay much attention to
> the error code in this case - I think it would always attempt some retries.

As far as I understand the problem of this kind of errors is for the multi 
sector write case. The framework does not know what sectors fails, so the 
question is: does it repeat the whole multi sector sequence or what else it 
does?

> Certainly any of these errors would result in error messages showing up
> in dmesg. Are you seeing any of this?

Are they enabled by default? Or more like debug messages? We see broken 
filesystems and data lost, but currently no related messages in the kernel's 
log. This could mean there are no such failures or the messages are not 
enabled.

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
