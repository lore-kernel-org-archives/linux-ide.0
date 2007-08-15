From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata drive loosing connection/resetting port
Date: Wed, 15 Aug 2007 15:19:20 +0900
Message-ID: <46C29AE8.5070903@gmail.com>
References: <20070813220241.3f4b8df5@workstation64.home>	<6bffcb0e0708131311k51238bb0l63eeb2fce53e3481@mail.gmail.com>	<46C180D8.9060005@gmail.com> <20070814221928.243949b6@workstation64.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:26579 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbXHOGTh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Aug 2007 02:19:37 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1647563rvb
        for <linux-ide@vger.kernel.org>; Tue, 14 Aug 2007 23:19:37 -0700 (PDT)
In-Reply-To: <20070814221928.243949b6@workstation64.home>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andreas Radke <a.radke@arcor.de>
Cc: linux-kernel@vger.kernel.org, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Andreas Radke wrote:
> already tried different ports, several SATA cables on that mainboard and
> psu works well. the Samsung drive works well no matter where
> connected. never had any issues with the Raptor drive when it was
> connected to the "old" Intel P965 board before. what's the difference
> form ICH8 to ICH9R? any changes in how the driver works?
> 
> i confirmed, that the issues still resist in kernel 2.6.23rc3 and also
> when using controller in "ide" mode together with ata_piix modul.
> 
> but on thing that is really weird: i used our installer iso to boot
> with 2.6.22 kernel and even after several hours the error did not
> appear! can you explain that? so it only happens when filesystems are
> mounted (also / partition is on that drive). 
> 
> any idea?

Can you post full boot log and the result of 'lspci -nn'?

-- 
tejun
