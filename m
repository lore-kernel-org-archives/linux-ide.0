From: Michael Schierl <schierlm@gmx.de>
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against
 stable kernel
Date: Tue, 16 May 2006 17:14:18 +0200
Message-ID: <4469EC4A.30908@gmx.de>
References: <20060512132437.GB4219@htj.dyndns.org> <e4coc8$onk$1@sea.gmane.org> <4469E8CF.9030506@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:25511 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932080AbWEPPOU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2006 11:14:20 -0400
In-Reply-To: <4469E8CF.9030506@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Jeff Garzik schrieb:
> Michael Schierl wrote:
> 
>> On Fri, 12 May 2006 22:24:37 +0900, Tejun Heo wrote:
>>
>>> ahci:        new EH, irq-pio, NCQ, hotplug
>>
>> Should suspend-to-RAM work now on AHCI?
> 
> It probably still needs Hannes' AHCI patch, and possibly the SATA ACPI
> patches too.

hmm. ok. Hannes' patch was the one in http://lkml.org/lkml/2006/3/6/47 ?

I never found a kernel where I could apply that one and still compile
without errors :(

I am no C guru, so I had no success to fix this patch without even
knowing where to apply against... (and I don't know anything about
kernel programming or even ACHI low-level programming).

Is there a newer version available of that patch somewhere?

And - what SATA ACPI patches?

I have quite alot of patches related to sata and/or acpi (collected from
different mailing lists) here on hard disk but don't know which ones are
broken, outdated, etc. Most only apply on a 2.6.15 or 2.6.14-rc kernel...

If more recent patches are only available via git, I'd need some good
GIT tutorial first...

TIA, and sorry for stealing your time,

Michael
