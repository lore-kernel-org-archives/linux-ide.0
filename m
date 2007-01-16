From: Tejun Heo <htejun@gmail.com>
Subject: Re: ICH7m problem using libata
Date: Tue, 16 Jan 2007 20:42:23 +0900
Message-ID: <45ACBA1F.6030007@gmail.com>
References: <1165253799.16504.37.camel@laundromat.jangutter.com>	 <200701100817.28738.matthew4196@gmail.com> <45AB0F07.5020705@gmail.com>	 <200701160958.33561.matthew4196@gmail.com>  <45AC933B.1000201@gmail.com> <1168947105.14636.11.camel@laundromat.jangutter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:14379 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbXAPLmd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Jan 2007 06:42:33 -0500
Received: by wr-out-0506.google.com with SMTP id i20so150011wra
        for <linux-ide@vger.kernel.org>; Tue, 16 Jan 2007 03:42:33 -0800 (PST)
In-Reply-To: <1168947105.14636.11.camel@laundromat.jangutter.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Gutter <jangutter@gmail.com>
Cc: Matthew Stapleton <matthew4196@gmail.com>, linux-ide@vger.kernel.org

Jan Gutter wrote:
> On Tue, 2007-01-16 at 17:56 +0900, Tejun Heo wrote:
>> Matthew Stapleton wrote:
>>> Tejun Heo wrote:
>>>> Does the problem still persist?
> 
> Sorry for the delayed reply: Holidays attacked before I could apply the
> patch. 
> 
>> I got confused between your report and Jan's.  Yours (not so sure about
>> Jan's) seems to be drive firmware bug which hald was successful to
>> undiscover.  Does hald clear CDO_USE_FFLAGS using ioctl
>> CDROM_CLEAR_OPTIONS?  The failed commands seem to be from cdrom
>> open_for_data().  Considering general quality of ATAPI devices, I
>> wouldn't be too surprised if some device fails after hours of repeated
>> poll sequence containing READ_TOC and ALLOW_MEDIUM_REMOVAL.
> 
> Hmmm. I think I might have slightly different symptoms: Heavy disk use
> definitely causes the bug to appear more frequently. Compiling often
> causes it to kick in after about 15 minutes. I also get slightly
> different error messages.
> 
> With the latest patch set (2.6.19-gentoo-r4 + cocktail) the resets still
> occur, but at least the drive doesn't go down to PIO so soon anymore.
> I'll keep watching it for the rest of the day. Attached dmesg of the
> first hour or so. (If Evolution borks this mail, I'll resort to telnet and 
> SMTP ;-)
> 
> Thanks for the feedback, and hope the sucker gets nailed.

Can you try 2.6.20-rc5?  It has better error reporting and will tell us
which SCSI command is timing out.

-- 
tejun
