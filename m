From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/1] libata: rearrange dmesg info to add full ATA revision
Date: Wed, 31 Jan 2007 10:23:24 -0500
Message-ID: <45C0B46C.5080905@garzik.org>
References: <20070131021051.GA3403@bounceswoosh.org> <20070131060040.GA3361@bounceswoosh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57623 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030201AbXAaPX0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Jan 2007 10:23:26 -0500
In-Reply-To: <20070131060040.GA3361@bounceswoosh.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: linux-ide@vger.kernel.org

Eric D. Mudama wrote:
> Per Jeff's suggestion, this patch rearranges the info printed for ATA
> drives into dmesg to add the full ATA firmware revision and model
> information, while keeping the output to 2 lines.
> 
> Signed-off-by: Eric D. Mudama <edmudama@gmail.com>
> 
> ---
> 
> This extra information is helpful for debugging drive-related issues
> on ATA drives connected with libata, especially when the user can't
> easily run hdparm.
> 
> Update: added Tejun's formatting requests, and created the constants
> necessary.
> 
> Diff is against 2.6.20-rc6 (roughly).  Here's a snippet of my new
> dmesg with this patch, showing the full and truncated firmware
> revision information:

Looks pretty good to me at first glance.  I'll review it again tonight 
or tomorrow, when I make the next "apply SATA patches" pass.

FWIW, since this is not a bug fix, it will be going into 2.6.21 rather 
than 2.6.20.  As such, it will be applied to 
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git 
branch 'upstream' rather than branch 'upstream-fixes'.

Or, in shorthand, libata-dev.git#upstream.

Cheers and thanks,

	Jeff



