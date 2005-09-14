From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Problem: ICH6 SATA + ACPI resume
Date: Wed, 14 Sep 2005 08:55:21 -0400
Message-ID: <43281DB9.2050105@pobox.com>
References: <8ce7994605091319243ea4156c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:44205 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965168AbVINMzb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Sep 2005 08:55:31 -0400
In-Reply-To: <8ce7994605091319243ea4156c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: fiorix@gmail.com
Cc: linux-ide@vger.kernel.org

Alexandre Fiori wrote:
> Hello,
> 
> I'm facing a weird problem with SATA and ACPI. I was using linux 
> 2.6.12.5 <http://2.6.12.5> and now 2.6.13.1 <http://2.6.13.1>, and the 
> problem persists.
> If I use the ATA "Generic PCI IDE" or even "Intel PIIXn" the harddisk is 
> very slow but I can suspend and resume, everything works fine - although 
> it is very slow.
> Now I disabled ATA support and changed to the SCSI "Serial ATA/Intel 
> PIIX/ICH SATA". The disk performance increased from 2 to 35MB/sec and I 
> still can do the ACPI suspend (now via echo -n mem > /sys/power/state), 
> but when I resume I get a lot of errors from the driver on the console. 

Suspend/resume is not supported yet, in libata.

	Jeff



