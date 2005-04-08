From: "Eric A. Cottrell" <eac@shore.net>
Subject: Re: LIBATA AHCI engine timeout hang with ATAPI devices
Date: Fri, 08 Apr 2005 19:08:55 -0400
Message-ID: <42570F07.6080406@shore.net>
References: <4256D1A9.6080401@shore.net> <4256D7CA.7030908@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.primushost.com ([209.58.220.66]:25587 "EHLO
	smtp2.primushost.com") by vger.kernel.org with ESMTP
	id S261186AbVDHXJD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Apr 2005 19:09:03 -0400
In-Reply-To: <4256D7CA.7030908@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

Jeff Garzik wrote:
> You need something like the attached patch.
> 
> In general, ATAPI is still very much experimental at this point.  One 
> known bug that affects libata is that ATAPI DMA is not aligned to a 
> 4-byte boundary.
> 
Hello,

Thanks.

I already have that patch applied.  I will poke around the code over the weekend and see if I can figure out the problem.
I am alittle rusty as my last disk driver code was modifying Heathkit CPM BIOS to support a SMS SASI board for 8 inch floppies and 
Shugart SA1000 series hard drives!

I would like to help get ATAPI to work as I suspect more SATA ATAPI stuff will appear as motherboards use SATA.  It appears that the 
ahci/libata code is missing some needed steps that the ata_piix/libata code does.  Looking at the code and patches I can see that 
libata had to change to permit the hardware to perform tasks that libata did.

Thank you for your web page on IDE drives.  I downloaded alot of specs and even read a small bit of them.

73 Eric eac@shore.net
