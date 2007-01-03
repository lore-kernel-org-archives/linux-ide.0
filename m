From: Douglas Gilbert <dougg@torque.net>
Subject: Re: [PATCH 2.6.20-rc3] fix broken retval test in sr_block_ioctl
Date: Tue, 02 Jan 2007 22:36:26 -0500
Message-ID: <459B24BA.2030604@torque.net>
References: <200701021724.39613.liml@rtr.ca> <200701021730.07356.liml@rtr.ca> <459ADEB1.7080505@pobox.com> <459AE23B.1020904@rtr.ca> <459AE6DB.1020001@rtr.ca>
Reply-To: dougg@torque.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:48577 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961AbXACDgn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Jan 2007 22:36:43 -0500
In-Reply-To: <459AE6DB.1020001@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Mark Lord wrote:
> Mark Lord wrote:
>> Jeff Garzik wrote:
>>> Mark Lord wrote:
>> ..
>>>> Allow ATA_12 / ATA_16 passthru commands to be issued for ATAPI devices
> ..
>> Mmmm.. yes, the "BLANK" opcode is indeed the same as ATA_12.
> 
> Yup, BLANK is commonly used with CD-RW software (cdrecord, k3b, ..),
> so we cannot translate ATA_12 for ATAPI CD devices.

I can also confirm that.

I have been around the same loop with Luben Tuikov's
SATL in his aic94xx driver.

There is also a SATL in firmware in the LSI Fusion MPT
SAS HBAs. As I don't have a SATAPI cd/dvd drive I'm
unable to find out what their firmware does in this situation.

I have also pointed out the BLANK/ATA_12 clash to the
editor of the SAT-2 draft (and he wasn't aware of it).

> How about a hack to the upper layer (scsi, or block??) to allow ATA_16
> even when the max_cmd_len is 12 ??  In reality, the command length is
> unimportant in that case, so it's more a matter of tastefulness than
> anything.

Yes, ATA_16 obviously needs to be let through to the SATL
(whether it is in libata or lower) even though the sr driver
might try and cap SCSI cdb length to 12 bytes.


BTW To test this fetch sg3_utils-1.22 and sg_sat_identifier
can be used to send an IDENTIFIER PACKET DEVICE via a ATA_16
(or ATA_12 for that matter).

Doug Gilbert

