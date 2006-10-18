From: Roger Heflin <rheflin@atipa.com>
Subject: Re: sata_mv problems on Marvell MV88SX5081
Date: Wed, 18 Oct 2006 16:08:43 -0500
Message-ID: <453697DB.2060806@atipa.com>
References: <Pine.LNX.4.64.0610181258330.29022@twin.jikos.cz> <45361FB1.4060304@rtr.ca> <Pine.LNX.4.64.0610181449470.29022@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 125.14.cm.sunflower.com ([24.124.14.125]:10526 "EHLO
	mail.atipa.com") by vger.kernel.org with ESMTP id S1422938AbWJRVIo
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Oct 2006 17:08:44 -0400
In-Reply-To: <Pine.LNX.4.64.0610181449470.29022@twin.jikos.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jiri Kosina <jikos@jikos.cz>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

Jiri Kosina wrote:
> On Wed, 18 Oct 2006, Mark Lord wrote:
> 
>>> Buffer I/O error on device sda1, logical block 122126336
>> Scroll WAY BACK in the log, and find the error messages which preceeded
>> the first occurance of that one.  (with a bad sector, it is very likely
>> you will see a zillion "Buffer I/O errors", as the SCSI mid-layer is not
>> at all nice about how it handles them).
> 
> Actually the "Buffer I/O error" is the very first error message I am 
> receiving, a few minutes after the driver is initialized and there is some 
> disk activity happening.
> 
> Thanks,
> 

Jiri,

Make sure that you delete the arrays in the highpoint bios before
trying to use the open source driver.

I have seen alot of really funny things on several of the different
hw/sw raid controllers (not just highpoint's) if you attempt to use
a disk that someone has already tagged as raid disks, even on the
same controller it gets interesting if you attempt to use them
non-raid.

I would be interested in knowing if the open source driver can successfully
driver those boards.

                           Roger

