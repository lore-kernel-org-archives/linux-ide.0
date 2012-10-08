From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: ata_dev_acpi_handle - NULL ptr deref (bug #48211)
Date: Mon, 08 Oct 2012 11:13:48 +0800
Message-ID: <507244EC.4000206@intel.com>
References: <CABZ+qqkQY4jRpTjLcOmLwBHY7Q8o1ooiqT82-Y6ogZp5OL6=4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50427 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211Ab2JHDNw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Oct 2012 23:13:52 -0400
In-Reply-To: <CABZ+qqkQY4jRpTjLcOmLwBHY7Q8o1ooiqT82-Y6ogZp5OL6=4g@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan van der Ster <dan@vanderster.com>
Cc: linux-ide@vger.kernel.org, mjg@redhat.com, Jeff Garzik <jgarzik@pobox.com>

On 10/03/2012 07:30 PM, Dan van der Ster wrote:
> Hi,
> I filed this bug report:
>    https://bugzilla.kernel.org/show_bug.cgi?id=48211
> and Alan suggested I mail this list.
> 
> I cannot boot 3.6 with acpi on using this hardware:
>     Shuttle sp35p2, Intel P35, AHCI SATA
>     disks attached via an external SATA port multiplier
> 
> I get a NULL ptr deref in ata_dev_acpi_handle with 3.6, but not with 3.5.4.
> Using acpi=off convinces 3.6 to boot.

Attached a patch on the bugzilla page, can you please give it a try?
Thanks.

-Aaron

> 
> I'm new to kernel debugging and don't have a serial console, but I did
> manage to slow the printk's and take a video. See around 2:00 here:
>     http://www.youtube.com/watch?v=WNkQCnfc56g&t=2m1s
> 
> Please let me know if you require any further info to debug this.
> 
> Best Regards, Dan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

