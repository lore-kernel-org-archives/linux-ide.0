From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Driver for Promise PDC42819 SATA/SAS controller
Date: Fri, 22 Aug 2008 18:43:40 +0200
Message-ID: <18606.60604.356878.363677@harpo.it.uu.se>
References: <65a6ef750808141846h1104bc1cj9a9c0bb721b62f58@mail.gmail.com>
	<18597.25642.934859.944853@harpo.it.uu.se>
	<65a6ef750808210557o1cf07c5fj9d273413003037f8@mail.gmail.com>
	<18605.27969.933718.902876@harpo.it.uu.se>
	<65a6ef750808211710k4f1e18b5y74b8d51e30c5900@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:64360 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375AbYHVQnq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Aug 2008 12:43:46 -0400
In-Reply-To: <65a6ef750808211710k4f1e18b5y74b8d51e30c5900@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Nelson <mdnelson8@gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Mark Nelson writes:
 > > But without docs or a reference driver I cannot really say what it
 > > would take to support it, sorry.
 > 
 > Yeah, I figured as much after reading that hardware docs
 > are only available under NDA... I do have Promise's "partial
 > open source driver" all working with the controller; but I
 > don't think that's what you meant by reference driver, is it?

No. Promise's partial-source drivers sometimes contain some useful
information, like register definitions, but the only useful info
in the TX4650 driver is the PCI ID list for the T3 chip family.

The older SATA150 and SATAII150/SATA300 chips on the other hand
have full source reference drivers, and we also have documentation
for them.
