From: Mark Lord <kernel@start.ca>
Subject: Re: blkdiscard vs hdparm for erasing a SSD?
Date: Mon, 27 Oct 2014 22:09:11 -0400
Message-ID: <544EFAC7.80501@start.ca>
References: <2523736.cvg5kvG8qa@al>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.start.ca ([64.140.120.243]:37699 "EHLO mail3.start.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752904AbaJ1CUG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Oct 2014 22:20:06 -0400
In-Reply-To: <2523736.cvg5kvG8qa@al>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Wu <peter@lekensteyn.nl>, linux-ide@vger.kernel.org, util-linux@vger.kernel.org

On 14-10-15 09:12 AM, Peter Wu wrote:
> Hi,
> 
> Recent versions of util-linux have a blkdiscard program. How does this compare
> to the --security-erase option of hdparm? The goal is to erase the contents of
> an previously used SSD to improve performance.
> 
> Is the command `blkdiscard -s /dev/sdd` equivalent to the instructions listed on
> https://ata.wiki.kernel.org/index.php/ATA_Secure_Erase?

--security-erase is the nearest thing to a "low level format" that exists.
On some mechanical drives, it actually performs a true low level format.

For SSDs, most manufacturers that I have dealt with use --security-erase
as their preferred method for reinitializing a corrupted drive.

--security-erase is normally much faster than TRIM as well.

Cheers
