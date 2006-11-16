From: "Ben Gardner" <gardner.ben@gmail.com>
Subject: Re: 2.6.19-rc5: Geode GX IDE and compact flash issues
Date: Wed, 15 Nov 2006 23:07:44 -0600
Message-ID: <808c8e9d0611152107x56c9f63ct44d737d88e2fe3ff@mail.gmail.com>
References: <808c8e9d0611151421k64c22a73p1c51e39cc4b5480@mail.gmail.com>
	 <20061115234241.011205b9@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.233]:1357 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161834AbWKPFHp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Nov 2006 00:07:45 -0500
Received: by wx-out-0506.google.com with SMTP id s7so470658wxc
        for <linux-ide@vger.kernel.org>; Wed, 15 Nov 2006 21:07:44 -0800 (PST)
In-Reply-To: <20061115234241.011205b9@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, Jordan Crouse <jordan.crouse@amd.com>

Thanks for the response.

> > [   26.689644] ata2: port is slow to respond, please be patient (Status 0xff)
>
> And get stuck because the 2.6.18 code doesn't consider 0xFF as no device
> and just skip it.

Out of curiosity, is a status of 0xff supposed to mean that there
isn't a device present?

> If you aren't using the CS5535 driver in drivers/ata then don't compile
> it in and all will be well. As to the crash - is that the IDE or the new
> libata driver which crashes on you ?

Ah. It looks like I had both PATA and IDE configured.  Oops.

I tried PATA/CS5535 only and that behaves the same as IDE/CS5535 - ie,
can't find the root filesystem + 40s wait. The kernel panics when it
can't find the root filesystem, so I couldn't capture the kernel logs.
 I might have to configure a serial console or something...

So, it doesn't look like this problem has anything to do with the core
ATA stuff.

I'll try the generic PATA driver, and If that doesn't work, I'll go
back to the generic IDE driver.

Thanks,
Ben
