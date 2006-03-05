From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET] libata: implement and use ata_dev_revalidate(), take
 #3
Date: Sun, 05 Mar 2006 11:10:56 -0500
Message-ID: <440B0D90.2080005@pobox.com>
References: <11415489584127-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:26835 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932172AbWCEQK6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 11:10:58 -0500
In-Reply-To: <11415489584127-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello, Jeff.
> 
> This is the third take of implement-and-use-ata_dev_revalidate
> patchset.  In the last take[1], out of four patches, %1, %2 and %4 got
> ACK'ed while %3 had some minor issues.
> 
> Changes from the last take are...
> 
> * in #3, ata_dev_same_device() tags mismatch messages with KERN_INFO
>   instead of KERN_WARNING.
> 
> * in #3, ata_dev_revalidate() returns -ENODEV instead of 0 if device
>   isn't present

I thought this was take #4?  Anyway...

applied 1-4


