From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [patch 3/3] Enable Aggressive Link Power management for AHCI controllers.
Date: Tue, 12 Jun 2007 00:59:28 -0300
Message-ID: <20070612035928.GB9808@khazad-dum.debian.net>
References: <20070611184146.448266229@intel.com> <20070611114839.907bcae2.kristen.c.accardi@intel.com> <20070612011148.GA9808@khazad-dum.debian.net> <466DF3E9.30303@linux.intel.com> <d8jr6oikkcz.fsf@nygaard.ping.uio.no> <466DFE09.3020408@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:55866 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756589AbXFLD7f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Jun 2007 23:59:35 -0400
Content-Disposition: inline
In-Reply-To: <466DFE09.3020408@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Dagfinn Ilmari =?iso-8859-1?Q?Manns=E5ker?= <ilmari@ilmari.org>, Arjan van de Ven <arjan@linux.intel.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, james.bottomley@steeleye.com, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, htejun@gmail.com

On Mon, 11 Jun 2007, Jeff Garzik wrote:
> >>on/off doesn't really make sense if the question is "do you favor power
> >>or do you favor performance".......

Actually, it does if you think of it as "do you need hotplug right now or
not?".

> >How about just making it a numeric scale with 0 meaning no power saving
> >and then some fixed number of levels (e.g 0-9)?
> 
> The original proposal seems far more intuitive than these alternatives.

There is nothing intuitive about the text or the levels.  All cases need
proper documentation.  I'd never expect link powersaving to kill hotplug,
unless I read the AHCI docs.

And enable/disable ain't intuitive either :(  But enable/disable is useful
to get stuff like SATA bay hotplug, dock/undock and other stuff that needs
hotplug to be working right, unless we can make that automatic so that power
saving is always disabled in all situations we'd need hotplug to be working?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
