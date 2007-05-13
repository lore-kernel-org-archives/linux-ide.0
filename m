From: Jim Paris <jim@jtan.com>
Subject: Re: [2.6.21.1] SATA freeze
Date: Sun, 13 May 2007 14:18:06 -0400
Message-ID: <20070513181806.GA19538@jim.sh>
References: <fa.zU1kuoSgByTYCYqY+iCQ5rMJy34@ifi.uio.no> <46460C1B.6000609@shaw.ca> <20070513012045.GA15162@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:53502 "EHLO neurosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757510AbXEMSSQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 May 2007 14:18:16 -0400
Content-Disposition: inline
In-Reply-To: <20070513012045.GA15162@curie-int.orbis-terrarum.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-ide@vger.kernel.org, Fred Moyer <fred@redhotpenguin.com>, linux-kernel@vger.kernel.org

> >  This appears to be a different problem. Something is issuing SMART-related 
> >  commands (smartd or smartctl perhaps) which the drive seems to be reacting 
> >  strangely to.
..
> Specifically, I could trigger it by running 'smartctl -d ata -S on
> /dev/sda' OR (s-S/o/).

This sounds like a known bug in smartmontools:

  http://marc.info/?l=smartmontools-support&m=117203137719518
  http://www.mail-archive.com/linux-ide@vger.kernel.org/msg03160.html

-jim
