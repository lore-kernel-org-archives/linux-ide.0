From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 5/13] ATA ACPI: use debugging macros
Date: Tue, 28 Feb 2006 06:58:30 -0500
Message-ID: <44043AE6.1010407@pobox.com>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com> <20060222135542.33fe242c.randy_d_dunlap@linux.intel.com> <20060228114733.GB4081@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:64387 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751693AbWB1L6e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 06:58:34 -0500
In-Reply-To: <20060228114733.GB4081@elf.ucw.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Randy Dunlap <randy_d_dunlap@linux.intel.com>, lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, akpm@osdl.org

Pavel Machek wrote:
> On St 22-02-06 13:55:42, Randy Dunlap wrote:
> 
>>From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
>>
>>Add more libata-acpi debugging, plus controlled by libata.printk
>>value.
> 
> 
> Please don't. Instead select messages so that it is not too noisy by
> default...

Wrong.  We want fine-grained message selection, just like modern net 
drivers have.  See netif_msg_xxx and friends.

	Jeff



