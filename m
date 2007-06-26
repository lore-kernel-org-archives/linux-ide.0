From: Heinz Ulrich Stille <hus@design-d.de>
Subject: Re: Frequent SATA resets with sata_nv (fwd)
Date: Tue, 26 Jun 2007 19:29:34 +0200
Message-ID: <200706261929.34303.hus@design-d.de>
References: <fa.Z5bo5y2TvW4efa6slAJpcdPwqAA@ifi.uio.no> <467ECBB8.2030706@shaw.ca> <alpine.DEB.0.99.0706251207230.20899@cheetah.fastcat.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.tammen.de ([62.206.99.154]:57060 "EHLO mail.tammen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756828AbXFZR7I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jun 2007 13:59:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.tammen.de (Postfix) with ESMTP id 695D6E81EC
	for <linux-ide@vger.kernel.org>; Tue, 26 Jun 2007 19:29:47 +0200 (CEST)
In-Reply-To: <alpine.DEB.0.99.0706251207230.20899@cheetah.fastcat.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: ide <linux-ide@vger.kernel.org>

On Tuesday 26 June 2007, Matthew "Cheetah" Gabeler-Lee wrote:
> On Sun, 24 Jun 2007, Robert Hancock wrote:
> I selected that model in part because it at least claimed to support
> NCQ.  I'm not sure if it reflects NCQ or not, but I do have
> /sys/block/sd[abc]/device/queue_{depth,type} which show simple and 31
> respectively.  Samsung's page for the drive also says it supports NCQ=
:

I seem to have the same problem, just not as frequent: four drives of t=
his
type, connected to an SiI 3132 and an nVidia MCP55; resets occur on bot=
h
controllers, and only with this drive type, not with several Maxtor 6B2=
00M0.
I never thought to check, but all drives on the nv controller have NCQ
disabled according to /sys/block. So maybe it's not (directly) NCQ rela=
ted?

MfG, Ulrich

--=20
Heinz Ulrich Stille / Tel.: +49-541-9400473 / Fax: +49-541-9400450
design_d gmbh / Wilhelmstr. 16 / 49076 Osnabr=FCck / www.design-d.de
Osnabr=FCck HRB 19116 / Gesch=E4ftsf=FChrer: G=FCnter Tammen, Rolf Tamm=
en

