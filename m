From: Borislav Petkov <bp@alien8.de>
Subject: Re: Possible bug in ide_cd_queue_pc() or ide_wait_stat() ?
Date: Wed, 28 Jul 2010 13:51:07 +0200
Message-ID: <20100728115107.GA1690@a1.tnic>
References: <4C500A82.2040805@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:52040 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134Ab0G1LvS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Jul 2010 07:51:18 -0400
Content-Disposition: inline
In-Reply-To: <4C500A82.2040805@citrix.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dominic Curran <dominic.curran@citrix.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

From: Dominic Curran <dominic.curran@citrix.com>
Date: Wed, Jul 28, 2010 at 11:46:26AM +0100

Hi Dominik,

> I have some TEAC DV-28E-V CDROM drives that after polling for status
> starts to timeout requests (the time it takes to do this varies
> between 5mins and 24hrs).

Which kernel is that? Can we see a complete dmesg? Which tool does the
polling (udev... )?

> The problem is that even when the requests timeout the ioctl
> CDROM_DRIVE_STATUS will receive a status of CDS_DISC_OK.

Can you add some more instrumentation code to ide_cdrom_drive_status()
to see which "return CDS_DISC_OK" is being hit since there are a couple
of them in that function.

Thanks.

-- 
Regards/Gruss,
Boris.
