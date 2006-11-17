From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH/RFC] ata: Add support for the MPC52xx ATA controller using
 libata
Date: Fri, 17 Nov 2006 17:41:02 -0500
Message-ID: <455E3A7E.3030807@garzik.org>
References: <11637151391017-git-send-email-tnt@246tNt.com> <200611172049.49260.jarno.manninen@tut.fi> <455E0907.8000009@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:24986 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1753375AbWKQWlP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Nov 2006 17:41:15 -0500
In-Reply-To: <455E0907.8000009@246tNt.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sylvain Munaut <tnt@246tNt.com>
Cc: Jarno Manninen <jarno.manninen@tut.fi>, linuxppc-embedded@ozlabs.org, Linux IDE <linux-ide@vger.kernel.org>, Sven Luther <sl@bplan-gmbh.de>

Sylvain Munaut wrote:
> Since the current libata doesn't really support overriding IO accessors,
> I'd keep it like
> that for now. Apparently some other architecture needs special IO stuff
> so we could see
> a way to hook io accessor soon, and then we can change it if we notice
> big problems.

Sure it does...  there are no individual outb etc. hooks, but you can 
override every available bitbang function.  This is intentional, so that 
arches have more power to control when and how a set of registers is 
blasted to the hardware.

	Jeff



