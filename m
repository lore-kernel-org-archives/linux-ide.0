From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] [libata] pata_platform: make probe and remove functions device type neutral
Date: Tue, 27 Nov 2007 23:31:33 +0100
Message-ID: <200711272331.33988.arnd@arndb.de>
References: <20071127153708.GA12490@localhost.localdomain> <20071127153900.GA14183@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.179]:57849 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758823AbXK0Wbr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 17:31:47 -0500
In-Reply-To: <20071127153900.GA14183@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linuxppc-dev@ozlabs.org
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>, linux-ide@vger.kernel.org

On Tuesday 27 November 2007, Anton Vorontsov wrote:
> Split pata_platform_{probe,remove} into two pieces:
> 1. pata_platform_{probe,remove} -- platform_device-dependant bits;
> 2. __ptata_platform_{probe,remove} -- device type neutral bits.
> 
> This is done to not duplicate code for the OF-platform driver.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
