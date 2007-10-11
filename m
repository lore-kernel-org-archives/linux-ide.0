From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: smartd causing SATA timeouts on sleeping drives
Date: Wed, 10 Oct 2007 22:46:12 -0400
Message-ID: <76366b180710101946u1be1c30dqaaa3cb8c7260a0c9@mail.gmail.com>
References: <76366b180710051838h11c63c38o9a4248309ff9ee7d@mail.gmail.com>
	 <4707ECF0.9030800@gmail.com>
	 <76366b180710072251i7af01faaqc18776d8f8f31ef9@mail.gmail.com>
	 <4709C8D6.3020008@gmail.com>
	 <76366b180710072332o159d2364i6fe5e0d5e28c0944@mail.gmail.com>
	 <Pine.LNX.4.63.0710101435340.4797@trinity.phys.uwm.edu>
	 <470D843B.3030405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:43185 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755677AbXJKCqN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Oct 2007 22:46:13 -0400
Received: by py-out-1112.google.com with SMTP id u77so750731pyb
        for <linux-ide@vger.kernel.org>; Wed, 10 Oct 2007 19:46:12 -0700 (PDT)
In-Reply-To: <470D843B.3030405@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Bruce Allen <ballen@gravity.phys.uwm.edu>, linux-ide@vger.kernel.org

On 10/10/07, Tejun Heo <htejun@gmail.com> wrote:
> Maybe what should be done is to track sleep mode in libata and issue
> SRST automatically if a command is issued to a sleeping drive.  I'll
> work on it.

Another tidbit of info.. I just went through the pain of tracking down
everything in my system (system apps as well as my own code)
responsible for waking up sleeping drives. My end goal was to make
sure sleeping drives stayed asleep to reduce power consumption and
wear due to unnecessary spin-ups. I'm sure distros targeting laptops
or embedded systems that use live disks go through this pain
frequently.

Would all SRST cmds sent from libata come from the ata_std_softreset()
call? Could something like SystemTap be used without modifying libata
to track all pids which cause that function to be called? If that
would work, it could be an easy way to do what I did manually. That
is, unless someone knows of an easier way that I'm overlooking.. :) I
might give that a try to see if it works well and document the result.

-Andrew
