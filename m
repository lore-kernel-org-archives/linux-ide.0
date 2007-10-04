From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: PDC20267 (Promise FastTrak100) instabillity/resets with newer
	kernels.
Date: Thu, 4 Oct 2007 22:39:44 +0200
Message-ID: <18181.20368.199630.935379@alkaid.it.uu.se>
References: <1191527587.1575.30.camel@indigo.declera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:50396 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755990AbXJDUkA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Oct 2007 16:40:00 -0400
In-Reply-To: <1191527587.1575.30.camel@indigo.declera.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yanko Kaneti <yaneti@declera.com>
Cc: linux-ide@vger.kernel.org

Yanko Kaneti writes:
 > Hi
 > 
 > The integrated PDC20267 (FastTrak100 BIOS version 2.30.0140.13)
 > controller in following constants hardware setup behaves differently
 > under live-cd fedora kernels 2.6.18-1.2869 and
 > 2.6.23-0.214.rc8.git2.fc8.
 > 
 > - Intel S845WD1-E server motherboard with onboard PDC20267 (105a:4d30),
 > latest bios revision P12
 > - two HDT722525DLAT80 Hitachi 250GB harddrives in master mode connected
 > to the two PDC20267 channels
 > - a cd connected to the chipset 82801EB/ER (ICH5/ICH5R) IDE Controller
 > for the purpose of booting the live-cd
 > 
 > 
 > The two disk are put in a md raid1 setup. The first one is online, the
 > second is being added and the raid starts reconstructing.  
 > The reconstruction works fine with 2.6.18 with a speed of approximately
 > 50MB/s. 
 > With 2.6.23 immediately as the reconstruction begins there is string  of
 > ATA bus errors and port resets until it settles on PIO4 transfer mode.

Your 2.6.18 kernel is using the IDE pdc202xx_old driver, while
your 2.6.23 kernel is using the libata pata_pdc202xx_old driver.
The latter one is marked experimental and is known to not work
very well yet. Just switch to the IDE pdc202xx_old driver instead.

/Mikael
