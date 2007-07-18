From: "Yasha Okshtein" <flyashi@gmail.com>
Subject: Re: Recommendations on user-space soft/hardreset
Date: Tue, 17 Jul 2007 17:34:05 -0700
Message-ID: <6b01c6170707171734l12af7fbdt43c28edd32776858@mail.gmail.com>
References: <6b01c6170707171723p4fdae403hf5b605fce4595b7@mail.gmail.com>
Reply-To: flyashi@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:2443 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755617AbXGRAeJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jul 2007 20:34:09 -0400
Received: by mu-out-0910.google.com with SMTP id i10so31686mue
        for <linux-ide@vger.kernel.org>; Tue, 17 Jul 2007 17:34:05 -0700 (PDT)
In-Reply-To: <6b01c6170707171723p4fdae403hf5b605fce4595b7@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello all,

I need to send soft and/or hard resets from userspace. As no such
method exists, I decided to write one. I wrote a hackish sysfs
interface; now I'm cleaning it up for official submission. My current
plan is:

- each driver, in ata_port_operations, specifies a soft_reset and
hard_reset functions, which take ata_port* as a parameter
- in ata_scsi_pass_through, check for HARDRESET and SRST, and call
respective driver's soft/hard reset function

Now here's where I'm not quite certain on how to proceed. Another
developer has recommended that the reset be performed from an error
context, so that pre/post reset get called automatically. However,
there's a few issues, one of which is, as I was told, that the user
process will resume before the reset is complete. Thus the user sends
SG_IO and gets an immediate response, before the reset is finished,
whereas running the reset command directly blocks the user process
until the drive returns.

So the question is: should the driver simply call prereset, optionally
hardreset, softreset, and postreset, or set up the error handler
context to do it?

Thanks,

 - Yasha
