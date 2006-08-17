From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: More ATA corner cases
Date: Thu, 17 Aug 2006 09:28:48 +0100
Message-ID: <1155803328.15195.18.camel@localhost.localdomain>
References: <1155731962.24077.346.camel@localhost.localdomain>
	 <44E3A13D.20102@rtr.ca> <1155775118.15195.14.camel@localhost.localdomain>
	 <44E3BDB8.2030502@rtr.ca>  <44E3DB21.2050105@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41893 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932275AbWHQIKs
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Aug 2006 04:10:48 -0400
In-Reply-To: <44E3DB21.2050105@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Mark Lord <liml@rtr.ca>, jgarzik@pobox.com, linux-ide@vger.kernel.org, Doug Maxey <dwm@enoyolf.org>, Unicorn Chang <uchang@tw.ibm.com>

Ar Iau, 2006-08-17 am 10:57 +0800, ysgrifennodd Albert Lee:
> Don't know whether the JS20 can be added to the whitelist automatically.
> If Alan is ok, will ask Unicorn's help to sent Alan the dmidecode and
> lspci -vxxx data of JS20 (and maybe other blades like HS20/HS40, etc).

If they have unique PCI subsystem identifiers then it should be easy to
do.

