From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] AHCI PCI ID for MacBook Pro
Date: Fri, 09 Feb 2007 04:33:25 -0500
Message-ID: <45CC3FE5.2010408@gmail.com>
References: <82530.66623.qm@web25412.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.229]:27519 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946259AbXBIJdf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Feb 2007 04:33:35 -0500
Received: by nz-out-0506.google.com with SMTP id s1so740949nze
        for <linux-ide@vger.kernel.org>; Fri, 09 Feb 2007 01:33:33 -0800 (PST)
In-Reply-To: <82530.66623.qm@web25412.mail.ukl.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Root Kit <rootkit85@yahoo.it>
Cc: linux-ide@vger.kernel.org

Root Kit wrote:
> hi,
> i have a MacBook pro and i noticed that linux
> (2.6.20)
> binds the ata_piix driver
> to the SATA controller.
> being my SATA controller an AHCI (ICH7M) i added the
> PCI ID to ahci.c
> then tested the system.
> i inline the patch here:

Great.  Care to post a proper patch with leading description and SOB? 
Please take a look at the following patch.  You can omit diffstat result.

http://article.gmane.org/gmane.linux.ide/15855

-- 
tejun
