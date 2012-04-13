From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_cs5536: DMI detection of broken PCs
Date: Fri, 13 Apr 2012 17:03:28 +0100
Message-ID: <20120413170328.65231662@pyramind.ukuu.org.uk>
References: <CAH9NwWeOt3bbcpP98Q6A2iKSZwqD628iHHAgr_Oe-UgKkE=G5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:60698 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab2DMQAu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Apr 2012 12:00:50 -0400
In-Reply-To: <CAH9NwWeOt3bbcpP98Q6A2iKSZwqD628iHHAgr_Oe-UgKkE=G5A@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> Is there a way to backlist the old devices to not use UDMA at all? DMI
> would be a good idea for
> detecting old devices. Is something like this possible?

You can implement a filter method. Presumably the data sheet and errata
tell you what the problem is and how to detect it. That will be your
starting point.

Alan
