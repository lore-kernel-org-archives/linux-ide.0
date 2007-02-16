From: Jeff Garzik <jeff@garzik.org>
Subject: Re: SiI 3114 and sata_sil
Date: Thu, 15 Feb 2007 20:14:07 -0500
Message-ID: <45D5055F.5080000@garzik.org>
References: <45D4A705.4050407@andrei.myip.org> <45D4A98A.7070705@pobox.com> <45D4AB9C.9050808@andrei.myip.org> <45D4B43E.2040807@pobox.com> <20070216011117.GA10679@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33162 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841AbXBPBOK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Feb 2007 20:14:10 -0500
In-Reply-To: <20070216011117.GA10679@curie-int.orbis-terrarum.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: Florin Andrei <florin@andrei.myip.org>, linux-ide@vger.kernel.org

Robin H. Johnson wrote:
> No, that's not a correct assertion. We can only say that device-mapper
> is being used somehow. It could be LVM, EVMS2, dmraid, or a few other
> things.


When using the stock open source ATA drivers, of those DM-related actors 
only dmraid can claim support for Sil 3114 proprietary "hardware RAID" 
as the user would see it.

	Jeff


