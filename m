From: Tejun Heo <htejun@gmail.com>
Subject: Re: errors on shutdown with PMP
Date: Sat, 28 Jul 2007 16:33:03 +0900
Message-ID: <46AAF12F.9020301@gmail.com>
References: <200707272153.l6RLrE5r007622@outgoing-alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:6640 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbXG1HdI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Jul 2007 03:33:08 -0400
Received: by rv-out-0910.google.com with SMTP id k20so167510rvb
        for <linux-ide@vger.kernel.org>; Sat, 28 Jul 2007 00:33:08 -0700 (PDT)
In-Reply-To: <200707272153.l6RLrE5r007622@outgoing-alum.mit.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Bejarano <beej@alum.mit.edu>
Cc: linux-ide@vger.kernel.org

Hello, Marc.

Marc Bejarano wrote:
> hi, tejun.  i've been using your libata-tj-2.6.22-rc6-20070702 kernel on
> a centos 4 machine for a while with some 3124's and 3726's.  up until
> today, i hadn't seen any issues.
> 
> while trying to shut the machine down, this happened:
> ===
> Jul 27 14:58:44 dell shutdown: shutting down for system halt
> Jul 27 14:59:15 dell kernel: ata8.00: exception Emask 0x0 SAct 0x1 SErr
> 0x0 action 0x2 frozen
> Jul 27 14:59:15 dell kernel: ata8.00: cmd
> 61/10:00:a7:0a:00/00:00:00:00:00/40 tag 0 cdb 0x0 data 8192 out
> Jul 27 14:59:15 dell kernel:          res
> 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)

Device times out write.

> Jul 27 14:59:15 dell kernel: ata8.15: hard resetting link
> Jul 27 14:59:17 dell kernel: ata8.15: SATA link up 3.0 Gbps (SStatus 123
> SControl 0)
> Jul 27 14:59:17 dell kernel: ata8.00: hard resetting link
> Jul 27 14:59:27 dell kernel: ata8.00: softreset failed (timeout)
> Jul 27 14:59:27 dell kernel: ata8.00: hard resetting link
> Jul 27 14:59:28 dell kernel: ata8.00: COMRESET failed (errno=-5)
> Jul 27 14:59:28 dell kernel: ata8.00: reset failed, giving up
> Jul 27 14:59:28 dell kernel: ata8.15: hard resetting link
> Jul 27 14:59:38 dell kernel: ata8.15: softreset failed (timeout)
> Jul 27 14:59:38 dell kernel: ata8.15: hard resetting link
> Jul 27 14:59:40 dell kernel: ata8.15: SATA link up 3.0 Gbps (SStatus 123
> SControl 0)
> Jul 27 14:59:40 dell kernel: ata8.00: hard resetting link
> Jul 27 14:59:50 dell kernel: ata8.00: softreset failed (timeout)
> Jul 27 14:59:50 dell kernel: ata8.00: hard resetting link
> Jul 27 14:59:51 dell kernel: ata8.00: COMRESET failed (errno=-5)
> Jul 27 14:59:51 dell kernel: ata8.00: reset failed, giving up
> Jul 27 14:59:51 dell kernel: ata8.15: hard resetting link
> Jul 27 15:00:01 dell kernel: ata8.15: softreset failed (timeout)
> Jul 27 15:00:01 dell kernel: ata8.15: hard resetting link
> Jul 27 15:00:03 dell kernel: ata8.15: SATA link up 3.0 Gbps (SStatus 123
> SControl 0)
> Jul 27 15:00:03 dell kernel: ata8.00: hard resetting link
> Jul 27 15:00:13 dell kernel: ata8.00: softreset failed (timeout)
> Jul 27 15:00:13 dell kernel: ata8.00: hard resetting link
> Jul 27 15:00:14 dell kernel: ata8.00: COMRESET failed (errno=-5)
> Jul 27 15:00:14 dell kernel: ata8.00: reset failed, giving up
> Jul 27 15:00:14 dell kernel: ata8.00: failed to recover link after 3
> tries, disabling
> Jul 27 15:00:14 dell kernel: ata8.00: disabled

And then never comes back.

Please post the result of 'smartctl -a /dev/sdX' where sdX is the device
which went offline.

-- 
tejun
