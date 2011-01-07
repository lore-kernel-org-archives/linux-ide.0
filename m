From: Tejun Heo <tj@kernel.org>
Subject: Re: AHCI support Port Multiplier problem.
Date: Fri, 7 Jan 2011 16:25:37 -0500
Message-ID: <20110107212537.GH7355@mtj.dyndns.org>
References: <134052.7990.qm@web74212.mail.tp2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40027 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab1AGVZl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Jan 2011 16:25:41 -0500
Received: by vws16 with SMTP id 16so7290082vws.19
        for <linux-ide@vger.kernel.org>; Fri, 07 Jan 2011 13:25:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <134052.7990.qm@web74212.mail.tp2.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Luo Dislo <dislo_b_j@yahoo.com.tw>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello,

On Fri, Jan 07, 2011 at 10:55:14AM +0800, Luo Dislo wrote:
> I am using AHCI driver, when CONFIG_SATA_PMP is set and the ahci
> driver DOES NOT have AHCI_HFLAG_NO_PMP. Libata sends Software Reset
> with PMP=0xF, trying to detect if Port Multiplier connected to the
> port. Unfortunately, if I plugged in general Hard drive, my
> controller failed to identify the hard drive.
> 
> What I observed was that libata always sent Software Reset with
> PMP=0xF and I guessed expecting signature is 0x96690101. I think
> libata should give up if the device does not return the Port
> Multiplier signature at the first time and take the signature value
> from device as the real device connnecting to the port now.
>
> What we said "support" PMP does not mean the port can only connnect
> to Port Multiplier. It might connect with hard drive or ATAPI
> device.

Which controller is this?  Can you please post the output of "lspci
-nn"?  SB600 had this problem and needed workaround but later SBs
fixed it.  Looks like someone else screwed up similarly.

Thanks.

-- 
tejun
