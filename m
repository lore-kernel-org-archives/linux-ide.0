From: Tejun Heo <htejun@gmail.com>
Subject: Re: help with PMP failures
Date: Wed, 18 Nov 2009 13:03:00 +0900
Message-ID: <4B0371F4.9060703@gmail.com>
References: <20091116184242.GA22250@merlins.org> <20091116184853.GA23126@merlins.org> <4B0238EC.6060803@kernel.org> <20091117173955.GA19029@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:53775 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816AbZKREDB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Nov 2009 23:03:01 -0500
Received: by gxk26 with SMTP id 26so733143gxk.1
        for <linux-ide@vger.kernel.org>; Tue, 17 Nov 2009 20:03:07 -0800 (PST)
In-Reply-To: <20091117173955.GA19029@merlins.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc MERLIN <marc@merlins.org>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Hello,

11/18/2009 02:39 AM, Marc MERLIN wrote:
>> This is the actual failure.  Your 6.02 drive reported media error
>> which combined with the controller errata caused port wide failure.
>  
> Ah, I see, so it should be the one for me to focus on.
> If it hadn't had an error, everything wouldn't have gone down the toilet,
> next, right?

Yes, that's my guess.

> scsi 6:2:0:0: Direct-Access     ATA      Hitachi HDS72101 GKAO PQ: 0 ANSI: 5
> sd 6:2:0:0: [sdj] 1953525168 512-byte hardware sectors: (1.00 TB/931 GiB)
>
> If it's a media error, shouldn't it show up in the smart counters?

Does smartctl -a output shows any logged errors?

> I can't really move it to another PMP port but I have indeed had failures
> that required not just a reboot of my server but an actual power cycle
> of the drive.

Yeah, some old drives do that after abruptly aborted while executing
commands.  :-(

> Ok, so this all sounds like it's a bit fragile due to hardware issues :)
> 
> I now have to figure out if /dev/sdj has a bad sector or not.
> 
> Last time I had this happen, though I did run 
> dd if=/dev/drive of=/dev/null bs=1M
> for my 5 drives, and it ran clean.
> 
> If I had a bad sector, shouldn't it show up in Current_Pending_Sector
> and shouldn't reading the entire drive with dd fail?

I'm not sure which smart counter would be affected.  It also depends
on the firmware implementation and read errors might happen one time
but not on the next trial (if the drive for some reason didn't move
the failed sector elsewhere) or maybe the drive is continuously
developing bad sectors.

Thanks.

-- 
tejun
