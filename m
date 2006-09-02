From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.18-rc5-mm1
Date: Sat, 02 Sep 2006 05:38:24 -0400
Message-ID: <44F95110.6010500@garzik.org>
References: <20060901015818.42767813.akpm@osdl.org> <1157158847.20509.10.camel@mhcln03> <20060901183028.1c6da4df.akpm@osdl.org> <44F93EB3.8050500@goop.org> <44F942B9.6050102@goop.org> <20060902084440.GA13361@suse.de> <44F9452F.8090306@goop.org> <20060902085254.GA14123@suse.de> <44F950A3.1000206@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:15796 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750904AbWIBJin (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Sep 2006 05:38:43 -0400
In-Reply-To: <44F950A3.1000206@goop.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>, Matthias Hentges <oe@hentges.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, linux-ide@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>

Jeremy Fitzhardinge wrote:
> Greg KH wrote:
>> Yes, try reverting them and see if your machine works again.
>>   
> 
> Reverting them makes the machine work, with basically the same effect as 
> disabling CONFIG_PCI_MSI: no MSI interrupts appear in /proc/interrupts, 
> and e1000 & libata are using IO-APIC-fasteoi.  So, a reasonable result 
> for now.

Did you re-enable CONFIG_PCI_MSI, after reverting the patches?

	Jeff




-- 
VGER BF report: H 0
