From: Tejun Heo <htejun@gmail.com>
Subject: Re: Issuing a vendor specific ATA cmd on SATA Disk via ATA Pass Thru
Date: Fri, 30 Nov 2007 10:18:45 +0900
Message-ID: <474F64F5.9070205@gmail.com>
References: <004d01c83273$68ded140$6539a8c0@usish.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:18823 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932238AbXK3BSw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 20:18:52 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1758452rvb
        for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2007 17:18:51 -0800 (PST)
In-Reply-To: <004d01c83273$68ded140$6539a8c0@usish.com.cn>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sam song <sam_song@usish.com>
Cc: linux-ide@vger.kernel.org

sam song wrote:
> Hi,
> 
> I am convinced that the SATA Disk does support one vendor specific ATA
> command and got the whole bus trace via Trainer.
> However, I cannot implement that in the real cases with either HBA or SATA
> Controller like ICH5/7 via ATA Pass Thru.
> So I wonder whether there is one possible setup including HW and SW
> supporting the ATA command via ATA Pass directly and no need to understand
> the command meaning itself.
> 
> Here is one result I got.
> 
> [<unknown opcode>: 85 0b 06 00 01 00 00 00 00 00 00 00 00 e0 fd 00 ]
>   scsi_status=0x2, host_status=0x0, driver_status=0x8
>   info=0x1  duration=270111 milliseconds
>   status=0x2: sense_key=0x7 asc=0x1 ascq=0x0

That sense key is data protect.  I don't think any code in ATA
passthrough code path can raise that sense key.  What did you exactly
do?  Can you post the source code?

-- 
tejun
