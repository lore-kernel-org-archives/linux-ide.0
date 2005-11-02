From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH] pmac ide doesn't properly cleanup hwif when
	releasing controller
Date: Wed, 02 Nov 2005 21:21:28 +1100
Message-ID: <1130926888.20136.21.camel@gaston>
References: <20051029044852.1a518908@Tatooine.r3z0>
	 <1130623795.29054.179.camel@gaston>
	 <58cb370e0511010820p77bd47c9wa566f3d356291733@mail.gmail.com>
	 <1130878823.29054.449.camel@gaston>
	 <58cb370e0511020005q27acb8fdg16acb1f307fafe7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:42156 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751544AbVKBKYa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Nov 2005 05:24:30 -0500
In-Reply-To: <58cb370e0511020005q27acb8fdg16acb1f307fafe7b@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Thibaut VARENE <T-Bone@parisc-linux.org>, linux-ide@vger.kernel.org


> "in future" we won't be doing brain-damaged restoring of HWIF
> fields in ide_unregister() and the problem will go away.  If you
> want to go ahead feel free to but remember to separate 2 states
> (HWIF is unregistered by ioctl and HWIF is really going away)
> which are currently both handled by ide_unregister().

Yup... maybe I should do ide_unregister() :)

Ben.


