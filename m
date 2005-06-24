From: Krzysztof Oledzki <olel@ans.pl>
Subject: Re: SATA speed. Should be 150 or 133?
Date: Fri, 24 Jun 2005 11:33:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0506241127210.3016@bizon.gios.gov.pl>
References: <Pine.LNX.4.62.0506240135340.29382@bizon.gios.gov.pl>
 <42BB794B.6080109@rtr.ca>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-187430788-1671707983-1119605638=:3016"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bizon.gios.gov.pl ([212.244.124.8]:19162 "EHLO
	bizon.gios.gov.pl") by vger.kernel.org with ESMTP id S263082AbVFXJeJ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Jun 2005 05:34:09 -0400
In-Reply-To: <42BB794B.6080109@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---187430788-1671707983-1119605638=:3016
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Thu, 23 Jun 2005, Mark Lord wrote:

> True SATA drives ignore the "transfer speed",
> as it really is meaningless and does not apply.
So, am I the the only person confused by this message? ;)
There is "SATA max UDMA/133" not "PATA max UDMA/133".

> But most (all?) first-gen SATA drives are really
> PATA drives with a SATA bridge built-in.
> Some of those drives require that Linux set the
> DMA transfer speed for them to work reliably.
Oh, so how to check true (current) speed?

> Last I looked, the highest valid PATA transfer
> speed was still "UDMA/133".  150 just plain
> doesn't exist for PATA (and the whole concept
> doesn't exist for SATA, so ..)
OK :)


Best regards,

 =09=09=09=09Krzysztof Ol=EAdzki
---187430788-1671707983-1119605638=:3016--
