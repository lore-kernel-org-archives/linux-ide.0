From: Mark Lord <liml@rtr.ca>
Subject: Re: /dev/sd*
Date: Wed, 09 Aug 2006 17:40:18 -0400
Message-ID: <44DA5642.6090804@rtr.ca>
References: <1155144599.5729.226.camel@localhost.localdomain> <20060809212124.GC3691@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:56288 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751377AbWHIVkT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Aug 2006 17:40:19 -0400
In-Reply-To: <20060809212124.GC3691@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Adrian Bunk wrote:
> 
> It might be a bit out of the scope of this thread, but why do some many 
> subsystems use the /dev/sd* namespace?

Because when those subsystems were first written, the only way one could install
most major distros was to use /dev/hd* or /dev/sd* as the device name.
This is still the case with many distros, though udev is helping get rid
of the hardcoding as time moves on.

So libata, USB, and firewire all were implemented as SCSI low-level drivers,
(rather than as independent block drivers), and thus inherited the /dev/sd* namespace.

They were not implemented as IDE low-level drivers, because the IDE subsystem
was never designed for hot-pluggable devices.

Cheers
