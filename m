From: Kevin Winchester <kjwinchester@gmail.com>
Subject: Re: [JANITOR PROPOSAL] Switch ioctl functions to ->unlocked_ioctl
Date: Tue, 08 Jan 2008 19:50:47 -0400
Message-ID: <47840C57.6000304@gmail.com>
References: <20080108164015.GC31504@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754720AbYAHXvK@vger.kernel.org>
In-Reply-To: <20080108164015.GC31504@one.firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, paolo.ciarrocchi@gmail.com, gorcunov@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Andi Kleen wrote:
> Here's a proposal for some useful code transformations the kernel janitors
> could do as opposed to running checkpatch.pl.
> 
<snip>

I notice that every driver in drivers/ata uses a .ioctl that points to
ata_scsi_ioctl().  I could add the BKL to that function, and then change
all of the drivers to .unlocked_ioctl, but I assume this would be a
candidate to actually clean up by determining why the lock is needed and
removing it if necessary.  Does anyone know off-hand the reason for
needing the lock (I assume someone does or it wouldn't have survived
this long)?  If the lock is absolutely required, then I can write the
patch to add lock_kernel() and unlock_kernel().

-- 
Kevin Winchester

