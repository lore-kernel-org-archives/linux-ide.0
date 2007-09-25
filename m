From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 1/2] Enable link power management for ata drivers
Date: Tue, 25 Sep 2007 10:50:25 +0100
Message-ID: <20070925105025.0cb9cc37@the-village.bc.nu>
References: <20070924215140.966161778@intel.com>
	<20070924151320.67f0c332.kristen.c.accardi@intel.com>
	<46F84460.5090703@tiscali.nl>
	<20070924164118.803cfb22.kristen.c.accardi@intel.com>
	<46F84F45.6000807@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51232 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751071AbXIYJoy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Sep 2007 05:44:54 -0400
In-Reply-To: <46F84F45.6000807@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, roel <12o3l@tiscali.nl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

> It converts several macros to inline functions (encouraged), and also 
> illustrates a nice, clean way of testing an ID word's validity. 
> [obviously the final implementation varies, depending on that ID word's 
> history]

Its in -mm and I thought you put a copy in your tree after I said it
hadn't upset anything in -mm ?

Alan
