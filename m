From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] swsusp: allow drivers to determine between write-resume and actual wakeup
Date: Mon, 5 Jun 2006 15:17:52 +0200
Message-ID: <20060605131752.GE2132@elf.ucw.cz>
References: <20060605091131.GE8106@htj.dyndns.org> <20060605092342.GI5540@elf.ucw.cz> <44841AA0.4060404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26038 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751089AbWFENSn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jun 2006 09:18:43 -0400
Content-Disposition: inline
In-Reply-To: <44841AA0.4060404@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Po 05-06-06 20:50:56, Tejun Heo wrote:
> Pavel Machek wrote:
> >If you want to know if you RESUME was after normal FREEZE or if it is
> >after reboot, there's better patch floating around to do that.
> 
> Yeap, this is what I'm interested in.  Care to give me a pointer?

David Brownell had a patch to do that. I forwarded you my reply to
that mail...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
