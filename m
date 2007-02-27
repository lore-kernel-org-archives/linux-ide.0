From: Tejun Heo <htejun@gmail.com>
Subject: Re: Bug? ahci.c
Date: Wed, 28 Feb 2007 00:20:06 +0900
Message-ID: <45E44C26.2010207@gmail.com>
References: <45B0B7C6.3030206@qmul.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:48579 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932077AbXB0PUN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Feb 2007 10:20:13 -0500
Received: by an-out-0708.google.com with SMTP id b33so1149847ana
        for <linux-ide@vger.kernel.org>; Tue, 27 Feb 2007 07:20:12 -0800 (PST)
In-Reply-To: <45B0B7C6.3030206@qmul.ac.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Ray <j.ray@qmul.ac.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

James Ray wrote:
> Jeff, All,
> 	We have just started using some new machines with The Intel ESB2
> chipset in them (PCI Id: 8086:2681) for the SATA Controller.
> With any kernels above 2.6.15 (as far as I can tell from my testing at
> least) we are getting problems with them.
> 
> This is the output I have managed to collect from the server (Its hard
> to get much more since the system gets more and more unresponsive as
> these errors progress):
> <3>ata2.00: exception Emask 0x10 SAct 0x0 SErr 0x80002 action 0x2 frozen
> <3>ata2.00: (irq_stat 0x08000000, interface fatal error)
> <3>ata2.00: tag 0 cmd 0x35 Emask 0x10 stat 0x50 err 0x0 (ATA bus error)
> <6>ata2: soft resetting port
> <3>ata2: softreset failed (1st FIS failed)
> <4>ata2: softreset failed, retrying in 5 secs
> <6>ata2: hard resetting port
> <4>ata2: port is slow to respond, please be patient

Can you test 2.6.20.1 and report full dmesg?  Thanks.

-- 
tejun
