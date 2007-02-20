From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] libata ACPI support
Date: Tue, 20 Feb 2007 18:49:17 -0500
Message-ID: <45DB88FD.5020509@garzik.org>
References: <20070220214716.GA3690@mail.muni.cz> <45DB74D9.206@garzik.org> <20070220232633.GA3598@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48963 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161091AbXBTXtT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Feb 2007 18:49:19 -0500
In-Reply-To: <20070220232633.GA3598@mail.muni.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Lukas Hejtmanek wrote:
> On Tue, Feb 20, 2007 at 05:23:21PM -0500, Jeff Garzik wrote:
>>> introducing SATA ACPI does not work for me (I've filled the bug
>>> report: http://bugzilla.kernel.org/show_bug.cgi?id=8046) beside those error
>>> messages, IDE performance is decreased. libata.noacpi=1 option works ok but
>>> the performance is still slightly degraded (about 10%).
>> Does performance come back if you also use acpi=off ?
> 
> It does not.
> 
> With 2.6.20-git15, hdparm -t /dev/sda says 28MB/s, 
> with 2.6.20, hdparm -t /dev/sda says 32MB/s.

Can you narrow down the -gitX release further?  i.e. does 2.6.20-git13 
perform at full speed?  -git13 includes several libata changes, but does 
not include the ACPI additions.

Since this is an ACPI execution error in the bug, that would tend to 
point to bad BIOS tables.  But since there is a performance drop that 
does not disappear with acpi=off, there might also be another factor, 
unrelated to ACPI, at play here.

	Jeff



