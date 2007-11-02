From: Daniel Drake <dsd@gentoo.org>
Subject: Re: "Fix ATAPI transfer lengths" causes CD writing regression
Date: Fri, 02 Nov 2007 21:19:43 +0000
Message-ID: <472B946F.4030004@gentoo.org>
References: <47274A5F.6070409@gentoo.org>	<20071030153417.59b9182c@the-village.bc.nu>	<47276DCA.1000808@gentoo.org>	<20071030190153.373c9347@the-village.bc.nu>	<47278439.4030801@gentoo.org>	<20071031114958.210bd7cc@the-village.bc.nu>	<20071031115754.GK5059@kernel.dk>	<4729A0DF.20800@garzik.org>	<20071101105335.1f20bab3@the-village.bc.nu>	<4729B3EA.6040707@garzik.org> <20071101141501.3746cec2@the-village.bc.nu> <4729F1BB.20306@gentoo.org> <4729F8F1.4040103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp131.iad.emailsrvr.com ([207.97.245.131]:44362 "EHLO
	smtp131.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510AbXKBVT4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 17:19:56 -0400
In-Reply-To: <4729F8F1.4040103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Jens Axboe <jens.axboe@oracle.com>, linux list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Albert Lee <albertcc@tw.ibm.com>

Tejun Heo wrote:
> Yeap, the SG command is fine.  The drive is being weird tho.  The
> allocation length field says 10 bytes, so it should just have
> transferred 10 bytes without causing HSM violation.
> 
> Can you please apply the attached patch and report what the kernel says
> after triggering the error condition?

Thanks for looking at this, the kernel now says:

<4>ata2.00: HSM violation: eh_analyze_tf: BUSY|DRQ
<3>ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
<3>ata2.00: cmd a0/00:00:00:0a:00/00:00:00:00:00/a0 tag 0 cdb 0x5a data 
10 in
<4>         res 58/00:02:00:0a:00/00:00:00:00:00/a0 Emask 0x2 (HSM 
violation)
<3>ata2.00: status: { DRDY DRQ }
<6>ata2: soft resetting link
<6>ata2.00: configured for UDMA/33
<6>ata2: EH complete

Daniel
