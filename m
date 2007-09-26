From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch 1/2] Enable link power management for ata drivers
Date: Tue, 25 Sep 2007 22:45:50 -0400
Message-ID: <46F9C7DE.8000604@pobox.com>
References: <20070924215140.966161778@intel.com>	<20070924151320.67f0c332.kristen.c.accardi@intel.com>	<46F84460.5090703@tiscali.nl>	<20070924164118.803cfb22.kristen.c.accardi@intel.com>	<46F84F45.6000807@pobox.com> <20070925105025.0cb9cc37@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41025 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754721AbXIZCp7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Sep 2007 22:45:59 -0400
In-Reply-To: <20070925105025.0cb9cc37@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, roel <12o3l@tiscali.nl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

Alan Cox wrote:
>> It converts several macros to inline functions (encouraged), and also 
>> illustrates a nice, clean way of testing an ID word's validity. 
>> [obviously the final implementation varies, depending on that ID word's 
>> history]
> 
> Its in -mm and I thought you put a copy in your tree after I said it
> hadn't upset anything in -mm ?

it didn't apply straightaway to my tree for whatever reason, IIRC


