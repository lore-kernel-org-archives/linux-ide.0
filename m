From: Jens Axboe <axboe@suse.de>
Subject: Re: Detecting CDROM Eject key press
Date: Mon, 11 Oct 2004 12:54:21 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041011105421.GK2290@suse.de>
References: <4163E7A2.9060402@vodatel.hr> <pan.2004.10.11.10.08.23.808702@vodatel.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:53974 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268775AbUJKK5k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Oct 2004 06:57:40 -0400
Content-Disposition: inline
In-Reply-To: <pan.2004.10.11.10.08.23.808702@vodatel.hr>
List-Id: linux-ide@vger.kernel.org
To: Vedran Rodic <vedran@vodatel.hr>
Cc: linux-ide@vger.kernel.org

On Mon, Oct 11 2004, Vedran Rodic wrote:
> On Wed, 06 Oct 2004 14:40:02 +0200, Vedran Rodic wrote:
> 
> > Can I detect that CDROM Eject key has been pressed when the cdrom is
> > mounted and the CDROM door is locked?
> > 
> 
> I guess this is impossible, and the only way to make the eject key react
> every time is by disabling door locking.

Yes. If the door is locked, you don't get any notifications.

-- 
Jens Axboe

