From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 08/12] libata: implement ata_timing_cycle2mode() and use
 it in libata-acpi and pata_acpi
Date: Tue, 06 Nov 2007 20:09:06 +0900
Message-ID: <47304B52.3010807@gmail.com>
References: <1194327550227-git-send-email-htejun@gmail.com>	<11943275513901-git-send-email-htejun@gmail.com> <20071106105912.1526c770@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:55606 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756185AbXKFLJO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Nov 2007 06:09:14 -0500
Received: by py-out-1112.google.com with SMTP id u77so3653189pyb
        for <linux-ide@vger.kernel.org>; Tue, 06 Nov 2007 03:09:13 -0800 (PST)
In-Reply-To: <20071106105912.1526c770@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Alan Cox wrote:
>> +	/* PIO */
>> +	mode = ata_timing_cycle2mode(ATA_SHIFT_PIO, gtm->drive[unit].pio);
>> +	xfer_mask |= ata_xfer_mode2mask(mode);
> 
> No check v 0xFF
> 
>> + *	ata_timing_cycle2mode - find xfer mode for the specified cycle duration
>> + *	@xfer_shift: ATA_SHIFT_* value for transfer type to examine.
>> + *	@cycle: cycle duration in ns
>> + *
>> + *	Return matching xfer mode for @cycle.  The returned mode is of
>> + *	the transfer type specified by @xfer_shift.  If @cycle is too
>> + *	slow for @xfer_shift, 0xff is returned.  If @cycle is faster
>> + *	than the fastest known mode, the fasted m
> 
> Can return 0xFF

The check is implicit in ata_xfer_mode2mask(), 0xff translates to
xfermask 0, vice-versa.  0xff is internally a valid value indicating no
mode.

Thanks.

-- 
tejun
