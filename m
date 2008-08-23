From: Chr <chunkeey@web.de>
Subject: Re: GA-MA790FX-DS5 SATA ahci NCQ erros on Jmicron 20360/20363  (JMB363) kernel 2.6.25-2 Debian/Lenny
Date: Sun, 24 Aug 2008 01:27:51 +0200
Message-ID: <200808240127.51972.chunkeey@web.de>
References: <g8p6po$nm$1@ger.gmane.org> <48B0916C.4080805@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmmailgate02.web.de ([217.72.192.227]:41967 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684AbYHWXYv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Aug 2008 19:24:51 -0400
In-Reply-To: <48B0916C.4080805@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergey Spiridonov <sena@hurd.homeunix.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

On Sunday 24 August 2008 00:38:36 Jeff Garzik wrote:
> See http://ata.wiki.kernel.org/index.php/Libata_error_messages for an
> introduction.
>
> In general, tons of ATA bus errors and SError register bits means that
> problems are coming from the ATA bus, a.k.a. the SATA cable and its
> related connections.
>
> So...  suspect bad cables, bad port connectors, cable interference,
> motherboard-caused interference or grounding problems, power supply
> problems.
>
hmm, or something totally odd...

what happens if you do: (after you made a backup!)
"dd if=/dev/sdX(where X is your affected hdd?) of=/dev/null bs=1"
Note:
The important bit is the small bs (blocksize) number.
You can throw in a O_DIRECT flag to disable the caches, or 
if you have some "empty" partition space, you can "dd" into
it with a small blocksize too)

my seagate & even a samsung hd103uj doesn't like that and will spew
out the same sort problems you have just posted... (but they work fine,
if I don't do nasty dd things!)

and unfortunatly my md(raid1) seems to do lots of "small" reads & writes
when it starts to check/resync the whole 1TB array :-/.

Regards,
	Chr
