From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: PROBLEM: When hibernating or resuming, ide driver locks the
	computer with 100% cpu utilization (2.6.28.7)
Date: Fri, 27 Mar 2009 09:29:05 +0100
Message-ID: <20090327082905.GA17813@liondog.tnic>
References: <225533.5222.qm@web32101.mail.mud.yahoo.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:47928 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbZC0I3N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Mar 2009 04:29:13 -0400
Received: by bwz17 with SMTP id 17so881478bwz.37
        for <linux-ide@vger.kernel.org>; Fri, 27 Mar 2009 01:29:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <225533.5222.qm@web32101.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pedro R <eusou15@yahoo.com>
Cc: linux-ide@vger.kernel.org

Hi,

On Thu, Mar 26, 2009 at 08:00:45PM -0700, Pedro R wrote:
> 
> The following is a description of a bug in the linux kernel, according to the REPORTING-BUGS file.
> 
> 
> [1.] One line description: When hibernating or resuming, ide driver locks the computer with 100% cpu utilization (2.6.28.7)
> 
> 
> 
> [2.] Full description: Bug is 100% reproducible on suspend, appears to be quite random when resuming. 
> 
> After removing a previously inserted CD / DVD from the drive, any attempt to hibernate locks up the computer. 
> After the line "suspending console: use no_console_suspend ..." the following 2 lines loop infinitely:
> 
> ide: status error = 0x04 {DriveReady SeekComplete DataRequest Error}
> hdc: failed opcode = 0x059

can you please clafify the exact order of how things happen: do you
remove the CD after having hibernated the machine or during? What
are the exact steps/their order, you do to trigger the bug? Can you
also send me the whole dmesg output of a suspend/resume cycle? In case
you can't catch the whole output due to the logs being swamped with the
messages above, try setting log_buf_len kernel cmdline parameter to a
higher value like 10M, for example.

Thanks.

-- 
Regards/Gruss,
    Boris.
