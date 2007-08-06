From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Mon, 06 Aug 2007 17:31:31 -0600
Message-ID: <46B7AF53.1040307@shaw.ca>
References: <fa.bsWpbo79BZgHoaIGhEMfTEBxs54@ifi.uio.no>
 <fa.mg6p0itaOQUo/t8deCaYpyqj6Nk@ifi.uio.no>
 <fa.RxWYL8z8KktgL8LGZ/cTB2nI1Yc@ifi.uio.no>
 <fa.AyyCtZ2yLjC5noHPHtmzn4ffhhE@ifi.uio.no>
 <fa.SuAjism+m0z0haqCRVjkc2S978o@ifi.uio.no>
 <fa.QgWcLG2hfRb92g4blN61qYfRjlQ@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:53591 "EHLO
	pd2mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933963AbXHFXbk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Aug 2007 19:31:40 -0400
In-reply-to: <fa.QgWcLG2hfRb92g4blN61qYfRjlQ@ifi.uio.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Michael Sedkowski <sedmich@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org

Tejun Heo wrote:
> Michael Sedkowski wrote:
>>> Hmmm... If the problem only shows up on nx6325, it might be that ACPI is
>>> pulling unnecessary stunt.  Please apply the attached patch and report
>>> when the disk spins down and up.
>> Disk spins down on "Pre-shutdown prepare" and then goes up and down on
>> "Power down".
> 
> Oh... crap, so acpi wants to sync cache on shutdown.  I wonder whether
> it spins down the disk correctly.  Does emergency unload count increase
> after each power down?  Also, please post the result of 'dmidecode'.

I know that my Compaq X1000-series laptop does do some kind of ACPI 
games with the disk on ACPI power off (I assume it is putting the disk 
in standby before power-off at least). It also does this if you boot 
into DOS, GRUB, etc. and then hit the power button. Could be if the disk 
is dumb enough to spin up for sync cache and standby when there is 
nothing to flush, and the kernel does its own standby, this could cause 
an extra spinup/down..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

