From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 21/22] libata: implement ATA printk helpers
Date: Sat, 13 May 2006 22:00:13 -0400
Message-ID: <44668F2D.50709@pobox.com>
References: <11473487912421-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:25229 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964772AbWENCAW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 May 2006 22:00:22 -0400
In-Reply-To: <11473487912421-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement ata_{port|dev}_printk() which prefixes the message with
> proper identification string.  This change is necessary for later PM
> support because devices and links should be identified differently
> depending on how they are attached.
> 
> This also helps unifying device id strings.  Currently, there are two
> forms in use (P is the port number D device number) - 'ataP(D):', and
> 'ataP: dev D '.  These macros also make it harder to forget proper ID
> string (e.g. printing only port number when a device is in question).
> 
> Debug message handling can be integrated into these printk macros by
> passing debug type and level via @lv.

FWIW:  The long term goal for libata printk'ing is to use the 
kernel/module command line, or blktool, to set the verbosity level for 
each ATA port.

The transition step to this is setting ap->msg_enable to a useful 
default bitmap, and (alas) touching each printk.

	Jeff


