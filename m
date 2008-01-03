From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] ide: delete filenames/versions from comments
Date: Wed, 02 Jan 2008 18:40:08 -0600
Message-ID: <477C2EE8.50301@shaw.ca>
References: <fa.CAem1qRl3AG/KJjVoPZU/Cn8U1g@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:31932 "EHLO
	pd3mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442AbYACAkQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jan 2008 19:40:16 -0500
In-reply-to: <fa.CAem1qRl3AG/KJjVoPZU/Cn8U1g@ifi.uio.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Delete filenames/versions from comments.
> 
> I'm leaving decisions about adding DRV_VERSION defines and MODULE_VERSION()-s
> to maintainers of the respective drivers.
> 
> While at it:
> 
> * Remove unused VERSION define from ide.c.
> 
> * Remove unused/stale DRV_VERSION define from au1xxx-ide.c.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

How about getting rid of this stupid thing in drivers/ide/ide.c:

#define	REVISION	"Revision: 7.00alpha2"

which is used in:

printk(KERN_INFO "Uniform Multi-Platform E-IDE driver " REVISION "\n");

It's been 7.00alpha2 for god knows how long, so clearly this version 
number is not useful..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

