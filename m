From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] removed static prototypes from include/asm-mips/mach-au1x00/au1xxx_ide.h
Date: Thu, 15 Mar 2007 22:03:06 +0100
Message-ID: <200703152203.06410.bzolnier@gmail.com>
References: <20070315201426.GA16573@ipxXXXXX>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:48831 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369AbXCOU4D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Mar 2007 16:56:03 -0400
Received: by ug-out-1314.google.com with SMTP id 44so493289uga
        for <linux-ide@vger.kernel.org>; Thu, 15 Mar 2007 13:56:01 -0700 (PDT)
In-Reply-To: <20070315201426.GA16573@ipxXXXXX>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-ide@vger.kernel.org


On Thursday 15 March 2007, Daniel Mack wrote:
> Hi,
> 
> This patch removes the static prototypes from the au1xxx_ide.h, some of
> them were not even implemented. Also, they caused build breakage since
> they differed from the functions actually implemented in
> drivers/ide/mips/au1xxx-ide.c.
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>

applied, thanks
