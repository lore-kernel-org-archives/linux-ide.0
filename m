From: Frederik Deweerdt <frederik.deweerdt@xprog.eu>
Subject: Re: Limiting DMA speeds for individual IDE drives
Date: Tue, 8 Sep 2009 16:24:34 +0000
Message-ID: <20090908161204.GA3113@gambetta>
References: <Pine.LNX.4.44L0.0909081157520.2653-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751572AbZIHQYj@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0909081157520.2653-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-ide@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Tue, Sep 08, 2009 at 12:03:48PM -0400, Alan Stern wrote:
> Is there any simple way to force the old IDE driver to limit the DMA
> speed for a particular device?
> 
> I've got a situation where a drive claims to be capable of supporting
> UDMA/100, but it's in a noisy environment and gets lots of errors at
> that speed.  I'd like to limit it to UDMA/66 or even UDMA/33.
> 
> The hdparm command should be able to do this but I can't run it until 
> the system has booted, by which time a bunch of CRC and possibly other 
> errors have already occurred.  Ideally it should be possible to limit 
> the speed starting as early as device detection, but I can't find any 
> way to do it.  Is there support for such a thing or will I have to hack 
> it in?
Does passing ide=nodma at bootime, and then having init set the DMA at
the right speed, would work?

Regards,
Frederik
