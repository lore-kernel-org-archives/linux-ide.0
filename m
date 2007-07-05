From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata1: soft resetting port
Date: Thu, 05 Jul 2007 11:21:05 +0900
Message-ID: <468C5591.1040202@gmail.com>
References: <1182260902.14805.60.camel@localhost>	 <4689EF48.8090506@gmail.com> <1183545657.22999.15.camel@localhost>	 <468BE06D.4010507@gmail.com> <1183576924.4697.36.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757516AbXGECVW@vger.kernel.org>
In-Reply-To: <1183576924.4697.36.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Linux-ide <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Soeren Sonnenburg wrote:
>>> pci_express 0000:00:1c.2:pcie03: resuming
>>> sr 0:0:0:0: resuming
>>> sd 2:0:1:0: resuming
>>> sd 2:0:1:0: [sda] Starting disk
>>> ata1.00: configured for UDMA/33
>>> ata3.01: revalidation failed (errno=-2)
>>> ata3: failed to recover some devices, retrying in 5 secs
>>> ata3.01: configured for UDMA/133
>> Hmmm... That's NODEV_HINT being triggered after resume.  Probably the
>> device isn't ready to respond yet at that point.  How reproducible is
>> the problem?
> 
> quite reproducible:
> 
> $ dmesg | grep 'revalidation failed' | wc -l
> 4

Hmmm... Thanks.  I think the best we can do is 1. don't wait for disk
revalidation during resume 2. retry faster.  Just in case, please post
the result of "hdparm -I /dev/sdX" where sdX is the device at ata3.01.

-- 
tejun
