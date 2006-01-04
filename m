From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ATA Write Error and Time-out Notification in User Space
Date: Wed, 04 Jan 2006 12:45:21 +0000
Message-ID: <1136378721.22598.90.camel@localhost.localdomain>
References: <BAY101-F1894F0927E1FB790D14772DF2C0@phx.gbl>
	 <1136314722.22598.36.camel@localhost.localdomain>
	 <1136378264.24032.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:25058 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751104AbWADMnJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jan 2006 07:43:09 -0500
In-Reply-To: <1136378264.24032.12.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: linux-ide@vger.kernel.org

On Mer, 2006-01-04 at 13:37 +0100, Erik Slagter wrote:
> > Its been known for some time so perhaps the ide maintainers have patches
> > waiting for 2.6.16 now its opened ?
> 
> Is this patch supposed to fix this problem:

Nope - it fixes a problem with the old IDE layer.

> Promise SATAII150 TX2plus using libata_promise, when it misses one
> single interrupt (or maybe it's not even missed but only delayed), it
> goes crazy, kernel log is full with disk failures, and the disk is
> kicked out of the md(1) array grmbl.
> 
> This happens when amd76x_pm is used, even with the irq watcher in the
> utter most conservative setting.

Does it happen with it not being used ?

