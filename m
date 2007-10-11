From: Tejun Heo <htejun@gmail.com>
Subject: Re: smartd causing SATA timeouts on sleeping drives
Date: Thu, 11 Oct 2007 12:06:50 +0900
Message-ID: <470D934A.9050207@gmail.com>
References: <76366b180710051838h11c63c38o9a4248309ff9ee7d@mail.gmail.com>	 <4707ECF0.9030800@gmail.com>	 <76366b180710072251i7af01faaqc18776d8f8f31ef9@mail.gmail.com>	 <4709C8D6.3020008@gmail.com>	 <76366b180710072332o159d2364i6fe5e0d5e28c0944@mail.gmail.com>	 <Pine.LNX.4.63.0710101435340.4797@trinity.phys.uwm.edu>	 <470D843B.3030405@gmail.com> <76366b180710101946u1be1c30dqaaa3cb8c7260a0c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:54131 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235AbXJKDG5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Oct 2007 23:06:57 -0400
Received: by rv-out-0910.google.com with SMTP id k20so365783rvb
        for <linux-ide@vger.kernel.org>; Wed, 10 Oct 2007 20:06:56 -0700 (PDT)
In-Reply-To: <76366b180710101946u1be1c30dqaaa3cb8c7260a0c9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Paprocki <andrew@ishiboo.com>
Cc: Bruce Allen <ballen@gravity.phys.uwm.edu>, linux-ide@vger.kernel.org

Andrew Paprocki wrote:
> On 10/10/07, Tejun Heo <htejun@gmail.com> wrote:
>> Maybe what should be done is to track sleep mode in libata and issue
>> SRST automatically if a command is issued to a sleeping drive.  I'll
>> work on it.
> 
> Another tidbit of info.. I just went through the pain of tracking down
> everything in my system (system apps as well as my own code)
> responsible for waking up sleeping drives. My end goal was to make
> sure sleeping drives stayed asleep to reduce power consumption and
> wear due to unnecessary spin-ups. I'm sure distros targeting laptops
> or embedded systems that use live disks go through this pain
> frequently.
> 
> Would all SRST cmds sent from libata come from the ata_std_softreset()
> call? Could something like SystemTap be used without modifying libata
> to track all pids which cause that function to be called? If that
> would work, it could be an easy way to do what I did manually. That
> is, unless someone knows of an easier way that I'm overlooking.. :) I
> might give that a try to see if it works well and document the result.

All resets come from ata_eh_reset() and you can attach probes to it but
the problem is that you can't identify the cause this way.  libata EH
thread would always be the issuing thread.  I think the best way to
track this is to use blktrace and look at which processes issue what
requests.

-- 
tejun
