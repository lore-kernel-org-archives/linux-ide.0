From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 4/13] ATA ACPI: add params/docs.
Date: Tue, 28 Feb 2006 06:57:33 -0500
Message-ID: <44043AAD.5050404@pobox.com>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com> <20060222135403.55086107.randy_d_dunlap@linux.intel.com> <20060228114647.GA4081@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:56963 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751651AbWB1L5j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 06:57:39 -0500
In-Reply-To: <20060228114647.GA4081@elf.ucw.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Randy Dunlap <randy_d_dunlap@linux.intel.com>, lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, akpm@osdl.org

Pavel Machek wrote:
> Hi!
> 
> 
>>From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
>>
>>Add and use 'noacpi' parameter for libata-acpi.
> 
> 
> Why is this option needed? Either the code works, or it does not. If
> it does not, it is not suitable for merging...

Invalid logic.  It is needed for the same reasons that acpi=off is 
supported in the generic ACPI code.

	Jeff



