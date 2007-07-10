From: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [PATCH 1/2] [ide] mmio ide support
Date: Tue, 10 Jul 2007 13:49:36 -0500
Message-ID: <20070710184936.GF24480@austin.ibm.com>
References: <20070707094852.9473.21013.stgit@localhost.localdomain> <468FC4AC.9030701@ru.mvista.com> <200707072007.10448.arnd@arndb.de> <200707081515.42105.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:41432 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757486AbXGJSti (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Jul 2007 14:49:38 -0400
Content-Disposition: inline
In-Reply-To: <200707081515.42105.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sun, Jul 08, 2007 at 03:15:41PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> > on the argument that drivers/ide/ is going away soon. Most
> > current distros have already moved over to using libata
> > exclusively.
> 
> The in-kernel default for PATA systems is still IDE subsystem.

In part because libata still does not yet work correctly 
for at least some (older) ide chipsets (like mine).

--linas
