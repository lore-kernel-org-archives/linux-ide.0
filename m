From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: IDE kernel traces in 2.6.9 - Bad IRQ ?
Date: Sun, 31 Oct 2004 06:13:03 -0500
Message-ID: <4184C8BF.5080602@pobox.com>
References: <418421E9.6000809@ipom.com> <4184C60C.9010407@ipom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26093 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261578AbUJaLNQ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 31 Oct 2004 06:13:16 -0500
In-Reply-To: <4184C60C.9010407@ipom.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Dibowitz <phil@ipom.com>
Cc: linux-ide@vger.kernel.org

Phil Dibowitz wrote:
> Phil Dibowitz wrote:
> 
>> I just upgraded my computer, compiled a new kernel appropriately, and 
>> I'm getting a ton of kernel issues surrounding the IDE driver. I tried 
>> a generic debian kernel as well, but same issue. Here are the 
>> tracebacks I get during boot:
>>
>> Oct 30 15:56:19 rider kernel: ide0 at 0xefe0-0xefe7,0xefae on irq 5
>> Oct 30 15:56:19 rider kernel: hda: max request size: 128KiB
> 
> 
> So, it turns out if I change the IDE Configuration in my BIOS to be 
> "Compatible mode" instead of "Enhanced Mode", this is fixed completely. 
> All my drives work flawelessly.
> 
> Any idea what, if any, features I'm missing, or how to make linux work 
> with "enhanced mode" ?


Sounds like you're not using CONFIG_SCSI_SATA for your SATA?

	Jeff


