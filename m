From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 2/13] ATA ACPI: debugging infrastructure
Date: Tue, 28 Feb 2006 09:43:54 -0500
Message-ID: <440461AA.1090907@rtr.ca>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>	<20060222135133.3f80fbf9.randy_d_dunlap@linux.intel.com>	<20060228114500.GA4057@elf.ucw.cz>	<44043B4E.30907@pobox.com> <20060228041817.6fc444d2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:31420 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751001AbWB1OoA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 09:44:00 -0500
In-Reply-To: <20060228041817.6fc444d2.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, pavel@ucw.cz, randy_d_dunlap@linux.intel.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
>> Fine-grained 
>>  message selection allows one to turn on only the messages needed, and 
>>  only for the controller desired.
> 
> Except
> 
> - There's (presently) no way of making all the messages go away for a
>   non-debug build.

Agreed.  We need a way to make them all really go away
for embedded builds -- memory matters there.

Cheers
