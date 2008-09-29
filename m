From: Tejun Heo <tj@kernel.org>
Subject: Re: frequent disk head unloads under Linux: additional hardware
Date: Mon, 29 Sep 2008 16:27:46 +0900
Message-ID: <48E08372.2030508@kernel.org>
References: <48C43F98.401@asmodeus.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33362 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751063AbYI2H3e (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Sep 2008 03:29:34 -0400
In-Reply-To: <48C43F98.401@asmodeus.be>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pascal Vandeputte <pascal@asmodeus.be>
Cc: linux-ide@vger.kernel.org

Hello,

Pascal Vandeputte wrote:
> Hi,
> 
> I've been highly frustrated for more than a year about this problem with
> my HP nx7400 laptop and its Seagate Momentus 5400.2 disk (which is
> otherwise a really fine piece of equipment). By switching from Ubuntu to
> openSUSE today, I had to look for the Suse way of fixing this up
> (instead of editing /etc/hdparm.conf on Ubuntu), and I stumbled upon the
> storage-fixup script which is really nice!
> 
> As my harddisk isn't included in by default yet, I've attached the
> required information to this e-mail.
> 
> Adding this to /etc/storage-fixup.conf solves it:
> 
>    # Reported drive model: ST9100824AS
>    rule hp-nx7400
>    dmi system-manufacturer Hewlett-Packard
>    dmi system-product-name HP Compaq nx7400*
>    ata model ST9*AS
>    act hdparm -B 255 $DEV

How much does the Load_Cycle_Count increase under idle usage per hour
without the adjustment?

> An unfortunate side-effect of meddling with the power saving on my
> system occurs at shutdown: for some reason I can clearly hear the drive
> spin down and then suddenly spin up and initialize again before the
> power is killed... This doesn't happen if I leave everything at default
> settings. Restoring the default setting (128) manually before shutting
> down doesn't prevent this either. It's weird and I've been working
> around it by rebooting and using the power button when I see GRUB appear.

That's a known problem of certain HP laptops.  Please take a look at the
following bug report.

  http://bugzilla.kernel.org/show_bug.cgi?id=8855

Thanks.

-- 
tejun
