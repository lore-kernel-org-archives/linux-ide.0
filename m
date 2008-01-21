From: Tejun Heo <htejun@gmail.com>
Subject: Re: unable to use cdrom/dvd drive after some usage
Date: Mon, 21 Jan 2008 17:01:42 +0900
Message-ID: <47945166.4060907@gmail.com>
References: <20080115044608.GA13420@www> <20080115113406.10d691e3@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:64189 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757684AbYAUIBs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 03:01:48 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3548830wah.23
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 00:01:48 -0800 (PST)
In-Reply-To: <20080115113406.10d691e3@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Johnny Luong <johnny.linux-ide@compfazed.com>, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Mon, 14 Jan 2008 20:46:08 -0800
> Johnny Luong <johnny.linux-ide@compfazed.com> wrote:
> 
>> Hi,
>>
>> If possible, I would like to know if its worthwhile simply just to get another
>> SATA drive / different controller / cable rather than trying to figure out
>> this PATA drive on SATA/PATA controller...  see attached for bug report and
>> config file.  I'm not on this email list so if you can CC that would be 
>> appreciated.
> 
> I don't think so. Wine seems to have fed the drive a command that upset
> it to the point it needed power cycling. That may also however be a
> drive/controller that don't know how to clear data stuck after a wrong
> transfer length from an application. In that case 2.6.24-rc6 (or 2.6.24
> once out) may actually fix the problem.
> 
> If it doesn't then we need to look at it further and find out what is
> going on to crash the drive.

Another possibility is that the drive requires DEVICE RESET to clear its
FIFO or whatever.  I'm working on DEVICE RESET.  Will post patch soon.
Johnny, please hold on to the hardware for testing.

Thanks.

-- 
tejun
