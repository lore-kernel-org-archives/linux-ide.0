From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sata 4726 Testing
Date: Tue, 08 Jan 2008 12:54:03 +0900
Message-ID: <4782F3DB.6000906@gmail.com>
References: <4769A17A.8070806@shaw.ca> <4769F974.2020905@gmail.com> <476D16E2.1050909@shaw.ca> <47824F69.6080007@gmail.com> <4782A79E.5000607@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.178]:1230 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754106AbYAHDyL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jan 2008 22:54:11 -0500
Received: by ro-out-1112.google.com with SMTP id p4so2208922roc.5
        for <linux-ide@vger.kernel.org>; Mon, 07 Jan 2008 19:54:10 -0800 (PST)
In-Reply-To: <4782A79E.5000607@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Ryder <tireman@shaw.ca>
Cc: linux-ide@vger.kernel.org

Hello,

Andrew Ryder wrote:
> Yes the issue is still there. I have also tried it with 2.6.24-rc6-git4.
> 
> BootLog1.txt
> 2.6.24-rc6-git4: machine booting up, drive array on before machine is
> powered on, drive array is configured as one large disk (RAID-1).
> 
> Bootlog2.txt
> Same kernel as #1, system has been up for a day or two, drive array was
> turned off after the boot failure in #1 and I turned it on again to see
> if it made any difference.
> 
> Bootlog3.txt
> Booted system, drive array already on, kernel 2.6.24-rc6 and the drive
> array was configured as one large disk (RAID-1).
> 
> Bootlog4.txt
> Same as #3, but drive array was configured in JBOD mode.
> 
> If you have any not too dangerous fixes you want to test, let me know. I
> can give them a try on my hardware here.

Hmmmm... This is weird.  I have two reports on addonics reporting the
same problem now.

In boot log 1 and 3, the first fan-out port (ata1.00) is down while on 2
and 4, the link is up.  Was there any hardware configuration change?
4726 is known to malfunction if the first port isn't occupied.

Thanks.

-- 
tejun
