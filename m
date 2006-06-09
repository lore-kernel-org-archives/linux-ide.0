From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC] ATA host-protected area (HPA) device mapper?
Date: Fri, 09 Jun 2006 10:48:50 -0400
Message-ID: <44898A52.2010008@garzik.org>
References: <20060609104759.26001.qmail@web26913.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:29066 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751444AbWFIOsx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Jun 2006 10:48:53 -0400
In-Reply-To: <20060609104759.26001.qmail@web26913.mail.ukl.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Etienne Lorrain wrote:
>   Your hard disk is a lot more powerfull than what you think, only very old

No, it's not.  I am well aware of what's in the ATA spec.


>  hard disks only have ATA set max command. Nowadays, you can not only set the

Not true.


>  Gujin also do the absolutely needed setup of the IDE hard disk which is to freeze
>  the password system _and_ the config system of all the IDE hard disks present, so
>  that no virus can put a random password and send you an E-mail with the address
>  where to send the money to get the password to unlock the hard disk and so access
>  again your data. Again, freezing means no more modifiable until next power cycle,
>  so IMO it is the job of the bootloader to setup the hard disk, before running
>  anything like Linux, a commercial OS, a bootable CDROM...

This is totally broken, and I am going to strongly recommend that no one 
use this software.

It is the OS responsibility to do this.  As a simple example, when the 
libata ACPI patches are merged (soon), libata will send BIOS-specified 
taskfiles to the device -- including the hard drive password, if any. 
Then it will freeze the settings.

Gujin's behavior will prevent the user from accessing their data, if 
they have protected it via BIOS.


>  Gujin is assuming that your hard disk are accessible by the documented ATA ide
>  system, and some (or all?) IDE SATA interface have (volumtary?) broken
>  implementation: they are not IDE register compatible.

More evidence that Gujin is completely broken.

Host controller programming interfaces have _always_ been variable.  PCI 
IDE standard was never a requirement for all host controllers, indeed 
such a requirement would be stupid, and widely ignored.

Modern SATA controllers are all FIS-based, and are not (and should not 
be) limited by the legacy IDE register programming interface.

	Jeff


