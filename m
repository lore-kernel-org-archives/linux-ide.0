From: Tejun Heo <htejun@gmail.com>
Subject: Re: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen on SATA
 hd
Date: Wed, 18 Apr 2007 02:01:51 +0900
Message-ID: <4624FD7F.4070200@gmail.com>
References: <a7108f870704150703p1f0da000k22f7b70605cec595@mail.gmail.com>	 <a7108f870704150708g741b7e2fmd52be8b53b358113@mail.gmail.com>	 <a7108f870704160745l4296fe8bt74e94d6c5bf8504e@mail.gmail.com> <a7108f870704160914g22b648bey39a9523a6d8a4800@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:9123 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031207AbXDQRB6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2007 13:01:58 -0400
Received: by nz-out-0506.google.com with SMTP id s1so1537861nze
        for <linux-ide@vger.kernel.org>; Tue, 17 Apr 2007 10:01:58 -0700 (PDT)
In-Reply-To: <a7108f870704160914g22b648bey39a9523a6d8a4800@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rodrigo Severo <rodrigo@fabricadeideias.com>
Cc: linux-ide@vger.kernel.org

Rodrigo Severo wrote:
> Now with kernel 2.6.21-rc6, addon board reattached and cables changed
> I still get messages like the following every 10 minutes or so under
> high load:
> 
> Apr 16 13:03:27 [kernel] ata1.00: exception Emask 0x0 SAct 0x0 SErr
> 0x0 action 0x2 frozen
> Apr 16 13:03:27 [kernel] ata1.00: cmd
> 35/00:00:91:fd:06/00:04:0b:00:00/e0 tag 0 cdb 0x0 data 524288 out
> Apr 16 13:03:27 [kernel]          res
> 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Apr 16 13:03:35 [kernel] ata1: port is slow to respond, please be
> patient (Status 0xd0)
> Apr 16 13:03:58 [kernel] ata1: port failed to respond (30 secs, Status
> 0xd0)
> Apr 16 13:03:58 [kernel] ata1: soft resetting port
> Apr 16 13:03:58 [kernel] ata1: SATA link up 1.5 Gbps (SStatus 113
> SControl 300)
> Apr 16 13:03:58 [kernel] ata1.00: configured for UDMA/133
> Apr 16 13:03:58 [kernel] ata1: EH complete
> Apr 16 13:03:58 [kernel] SCSI device sda: 781422768 512-byte hdwr
> sectors (400088 MB)
> Apr 16 13:03:58 [kernel] sda: Write Protect is off
> Apr 16 13:03:58 [kernel] SCSI device sda: write cache: enabled, read
> cache: enabled, doesn't support DPO or FUA
> 
> Is this expected behavior?

Certainly not.  Can you post the result of 'smartctl -d ata -a /dev/sdX'?

-- 
tejun
