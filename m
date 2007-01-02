From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 2.6.20-rc3] fix broken retval test in sr_block_ioctl
Date: Tue, 02 Jan 2007 18:12:27 -0500
Message-ID: <459AE6DB.1020001@rtr.ca>
References: <200701021724.39613.liml@rtr.ca> <200701021730.07356.liml@rtr.ca> <459ADEB1.7080505@pobox.com> <459AE23B.1020904@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3674 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964963AbXABXM0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Jan 2007 18:12:26 -0500
In-Reply-To: <459AE23B.1020904@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Douglas Gilbert <dougg@torque.net>

Mark Lord wrote:
> Jeff Garzik wrote:
>> Mark Lord wrote:
> ..
>>> Allow ATA_12 / ATA_16 passthru commands to be issued for ATAPI devices
..
> Mmmm.. yes, the "BLANK" opcode is indeed the same as ATA_12.

Yup, BLANK is commonly used with CD-RW software (cdrecord, k3b, ..),
so we cannot translate ATA_12 for ATAPI CD devices.

How about a hack to the upper layer (scsi, or block??) to allow ATA_16
even when the max_cmd_len is 12 ??  In reality, the command length is
unimportant in that case, so it's more a matter of tastefulness than anything.

???
