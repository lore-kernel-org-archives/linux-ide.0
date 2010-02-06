From: Tejun Heo <htejun@gmail.com>
Subject: Re: [kekcsibe@gmail.com: PROBLEM: Pioneer DVD-RW DVR-112D does not
 work since linux 2.6.29]
Date: Sat, 06 Feb 2010 09:33:28 +0900
Message-ID: <4B6CB8D8.8090304@gmail.com>
References: <20100129044834.GB25869@liondog.tnic> <4B633A49.8000700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:59973 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab0BFIMO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Feb 2010 03:12:14 -0500
Received: by pxi12 with SMTP id 12so5193229pxi.33
        for <linux-ide@vger.kernel.org>; Sat, 06 Feb 2010 00:12:14 -0800 (PST)
In-Reply-To: <4B633A49.8000700@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: kekcsibe@gmail.com, Borislav Petkov <petkovbb@googlemail.com>, linux-ide <linux-ide@vger.kernel.org>

Hello,

On 01/30/2010 04:43 AM, Robert Hancock wrote:
> kazimir:~# mount /cdrom
> sr 1:0:0:0: [sr0] Result: hostbyte=0x00 driverbyte=0x08
> sr 1:0:0:0: [sr0] Sense Key : 0x5 [current]
> sr 1:0:0:0: [sr0] <<vendor>> ASC=0xa8 ASCQ=0x1ASC=0xa8 ASCQ=0x1
> sr 1:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 10 00 00 02 00
> end_request: I/O error, dev sr0, sector 64
> Buffer I/O error on device sr0, logical block 8
> 
> The kernel tried to read some sectors off the disk (command 0x28) and
> the drive returned an error. ASC of 0xa8 is a vendor-specific error
> code, so only Pioneer can likely say what that error means.
> 
> You're sure that 2.6.22 is still able to successfully access this drive?
> Any unusual dmesg output there?

One thing which could affect this is the change in the isofs code.
Locating the anchor blocks for isofs involves some guesswork and that
part has changed somewhat during past several releases.  Different
kernel versions would request different sequence of blocks.  It could
be that access to certain sectors is confusing the drive.

Thanks.

-- 
tejun
