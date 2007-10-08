From: Tejun Heo <htejun@gmail.com>
Subject: Re: sil24 PMP works with ST3500641AS but not HDS721010KLA330 (mostly
 solved)
Date: Mon, 08 Oct 2007 10:06:00 +0900
Message-ID: <47098278.2040106@gmail.com>
References: <20071002170445.GB2902@merlins.org> <20071007172238.GL2068@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:64157 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754878AbXJHBGH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Oct 2007 21:06:07 -0400
Received: by rv-out-0910.google.com with SMTP id k20so622547rvb
        for <linux-ide@vger.kernel.org>; Sun, 07 Oct 2007 18:06:06 -0700 (PDT)
In-Reply-To: <20071007172238.GL2068@merlins.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc MERLIN <marc@merlins.org>
Cc: linux-ide@vger.kernel.org

Marc MERLIN wrote:
> It took many days of moving things around and trying, and I think I finally
> got to something that works.

Great.

>> PM: Adding info for No Bus:usbdev2.1
>> ata3: SATA link down (SStatus 0 SControl 0)
>> ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
>> ata4.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
>> ata4.00: hard resetting link
>> ata4.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> ata4.01: hard resetting link
>> ata4.01: softreset failed (timeout)
>> ata4.01: hard resetting link
>> ata4.01: COMRESET failed (errno=-5)
>> ata4.01: reset failed, giving up
>> ata4.15: hard resetting link
>> ata4.15: softreset failed (timeout)
>> ata4.15: hard resetting link
>> ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
>> ata4.00: hard resetting link
>> ata4.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> ata4.01: hard resetting link
>> ata4.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> ata4.02: hard resetting link
>> ata4.02: softreset failed (timeout)
>> ata4.02: hard resetting link
>> ata4.02: COMRESET failed (errno=-5)
>> ata4.02: reset failed, giving up
>> ata4.15: hard resetting link
>> ata4.15: softreset failed (timeout)
>> ata4.15: hard resetting link
>> ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
>> ata4.00: hard resetting link
>> ata4.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> ata4.01: hard resetting link
>> ata4.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> ata4.02: hard resetting link
>> ata4.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> ata4.03: hard resetting link
>> ata4.03: softreset failed (timeout)
>> ata4.03: hard resetting link
>> ata4.03: COMRESET failed (errno=-5)
>> ata4.03: reset failed, giving up

This is a known problem.  While spinning each drive up, reset fails and
unsure of controller state, libata resets whole controller each time.  I
missed it because my array is usually up all the time.  I'll look into it.

Thanks.

-- 
tejun
