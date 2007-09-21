From: richard kennedy <richard@rsk.demon.co.uk>
Subject: Re: pata_via cd/dvd timeout problems
Date: Fri, 21 Sep 2007 09:53:05 +0100
Message-ID: <1190364785.3121.10.camel@castor.rsk.org>
References: <124748.3608.qm@web54408.mail.yahoo.com>
	 <1188982210.3075.9.camel@castor.rsk.org>
	 <20070906013347.1f588dc4@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:2104 "EHLO
	anchor-post-34.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751151AbXIUIxI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Sep 2007 04:53:08 -0400
In-Reply-To: <20070906013347.1f588dc4@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Thu, 2007-09-06 at 01:33 +0100, Alan Cox wrote:

> Probably. If you can file a bug in bugzilla and assign it to me I'll take
> a look at this after the kernel summit. There are one or two reports with
> pata_via and ATAPI (ie CD) that look similar.

Hi Alan,
your [PATCH] libata: Set transfer sizes properly for ATAPI fixes this
for me.
I've been running 2.6.23-rc7 + your patch since yesterday evening and
have not seen any timeout messages. I can mount and read disks on either
drive with no problems. 

thanks for tracking this down  
Richard

