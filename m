From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC] ata: Intel IDE-R support
Date: Thu, 19 Aug 2010 13:22:10 +0200
Message-ID: <4C6D13E2.1010703@kernel.org>
References: <20100810155559.7620.79711.stgit@localhost.localdomain>	<4C6AB68D.8000102@kernel.org>	<20100817174257.3691ed68@lxorguk.ukuu.org.uk>	<4C6AB919.7060203@kernel.org>	<20100817180158.179e7780@lxorguk.ukuu.org.uk>	<4C6ABFFA.2000502@kernel.org>	<20100817192353.3529733c@lxorguk.ukuu.org.uk>	<4C6B7B72.4090405@kernel.org>	<20100818110306.03ce2fbc@lxorguk.ukuu.org.uk>	<4C6BE9C8.4030803@kernel.org>	<20100818161521.430ba361@lxorguk.ukuu.org.uk>	<4C6CFB63.2070001@kernel.org> <20100819110959.40312e58@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43885 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752041Ab0HSL0J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Aug 2010 07:26:09 -0400
In-Reply-To: <20100819110959.40312e58@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, jeff@garzik.org, kay.sievers@suse.de

(cc'ing Kay, hi!)
Hello,

On 08/19/2010 12:09 PM, Alan Cox wrote:
>> what if ata_piix is already compiled in or already loaded but ahci is
>> not for an ich6 controller?  We have priorities in the drivers, if the
>> user/admin wants to use the lower priority ones that much, he/she
>> shall.  This isn't an issue.  There's no way to hotplug intel IDEs
>> anyway.
> 
> The PIIX4 in the IBM docking stations is hot plug - and its why I also
> have to check 0x40 and write it if zero. So the case exists.

I see.  Most of the problems are solved by driver priority but yeah
that's an actual corner case.  Driver priority doesn't work unless all
the matching drivers are loaded by the time driver matching starts, so
the same problem could happen with pata_acpi depending on probe order
during normal boot, so pata_acpi should be blacklisted by default.

Kay, there are a few ATA drivers with overlapping hardware support.
When all the drivers are built-in the kernel or none of them is loaded
as modules, priority among them as defined by link order is followed;
however, if one of the drivers is already loaded while other
overlapping ones are not, there's nothing which guarantees driver
probing would happen after modprobe for the device ID is complete,
right?  So, the already loaded driver may be attached to the
controller even when there is a higher priority driver.  Am I missing
something?

Thanks.

-- 
tejun
