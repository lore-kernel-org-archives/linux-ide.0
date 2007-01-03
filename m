From: =?ISO-8859-1?Q?D=E2niel?= Fraga <fragabr@gmail.com>
Subject: Re: CDROM drive not found when booting using new libata code
Date: Wed, 3 Jan 2007 21:19:46 -0200
Message-ID: <i9qt64-fc7.ln1@tux.abusar.org>
References: <4562C65C.2010802@gmail.com>
	<20061206181652.GA3107@artsapartment.org>
	<45779852.1030909@gmail.com>
	<20061207105525.4ebb4547@localhost.localdomain>
	<45780AF5.2020605@gmail.com>
	<20061208010626.GA1856@artsapartment.org>
	<45927532.3060404@gmail.com>
	<45933F2A.5070304@gmail.com>
	<20070102210708.GI24909@artsapartment.org>
	<459B239B.90204@gmail.com>
	<20070103180840.GC2268@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:41637 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932177AbXACXaN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Jan 2007 18:30:13 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1H2FYY-0005lx-To
	for linux-ide@vger.kernel.org; Thu, 04 Jan 2007 00:30:02 +0100
Received: from 200-207-206-233.dsl.telesp.net.br ([200.207.206.233])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 04 Jan 2007 00:30:02 +0100
Received: from fragabr by 200-207-206-233.dsl.telesp.net.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 04 Jan 2007 00:30:02 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Wed, 3 Jan 2007 12:08:40 -0600
"Art Haas" <ahaas@airmail.net> wrote:

> ata2.00: ATAPI, max MWDMA1:PIO4
> ata2.00: revalidation failed (errno=-2)
> ata2.00: limiting speed to PIO4
> ata2: failed to recover some devices, retrying in 5 secs
> ata2.00: revalidation failed (errno=-2)
> ata2.00: limiting speed to PIO0
> ata2: failed to recover some devices, retrying in 5 secs
> ata2.00: revalidation failed (errno=-2)
> ata2.00: disabled

	While this problem isn't solved, how can we disable the second
device (in lilo or something like that) so we don't have to wait for the
retries? Thanks!

-- 
http://u-br.net
Linux 2.6.19: Avast! A bilge rat!
Sao Paulo - SP

