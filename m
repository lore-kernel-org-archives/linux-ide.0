From: Johnny Luong <johnny.linux-ide@compfazed.com>
Subject: Re: unable to use cdrom/dvd drive after some usage
Date: Mon, 21 Jan 2008 00:38:06 -0800
Message-ID: <20080121083806.GA28080@www>
References: <20080115044608.GA13420@www>
 <20080115113406.10d691e3@lxorguk.ukuu.org.uk> <47945166.4060907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpauth.rollernet.us ([208.11.75.5]:58100 "EHLO
	smtpauth.rollernet.us" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758033AbYAUIa2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 03:30:28 -0500
Received: from smtpauth.rollernet.us (localhost.localdomain [127.0.0.1])
	by smtpauth.rollernet.us (Postfix) with ESMTP id C09A2594099
	for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 00:30:27 -0800 (PST)
Received: from www.compfazed.com (cpe-66-75-83-220.socal.res.rr.com
 [66.75.83.220]) 	by smtpauth.rollernet.us (Postfix) with ESMTP 	for
 <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 00:30:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <47945166.4060907@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Mon, Jan 21, 2008 at 05:01:42PM +0900, Tejun Heo wrote:
> Alan Cox wrote:
> > On Mon, 14 Jan 2008 20:46:08 -0800
> > Johnny Luong <johnny.linux-ide@compfazed.com> wrote:
> > 
> >> Hi,
> >>
> >> If possible, I would like to know if its worthwhile simply just to get another
> >> SATA drive / different controller / cable rather than trying to figure out
> >> this PATA drive on SATA/PATA controller...  see attached for bug report and
> >> config file.  I'm not on this email list so if you can CC that would be 
> >> appreciated.
> > 
> > I don't think so. Wine seems to have fed the drive a command that upset
> > it to the point it needed power cycling. That may also however be a
> > drive/controller that don't know how to clear data stuck after a wrong
> > transfer length from an application. In that case 2.6.24-rc6 (or 2.6.24
> > once out) may actually fix the problem.
> > 
> > If it doesn't then we need to look at it further and find out what is
> > going on to crash the drive.
> 
> Another possibility is that the drive requires DEVICE RESET to clear its
> FIFO or whatever.  I'm working on DEVICE RESET.  Will post patch soon.
> Johnny, please hold on to the hardware for testing.
> 
> Thanks.
> 
> -- 
> tejun

Since it may be a software issue, I've simply kept the drive in place.
I did upgrade to 2.6.24-rc8 a couple of days ago though and haven't 
seen that strange HSM error.  

Thanks for the help,
-Johnny
