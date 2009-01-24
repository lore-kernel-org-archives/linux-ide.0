From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: v2.6.29-rc2 gets HSM violations for CD drive
Date: Fri, 23 Jan 2009 22:42:03 -0600
Message-ID: <497A9C1B.7080002@lwfinger.net>
References: <497A5836.2070904@lwfinger.net> <18810.24721.900344.239817@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:54783 "EHLO
	mtiwmhc12.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754485AbZAXEmO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Jan 2009 23:42:14 -0500
In-Reply-To: <18810.24721.900344.239817@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> 
> pata_ali is one of the drivers that got converted to doing 32-bit PIO.
> Please try this <http://marc.info/?l=linux-kernel&m=123254501314058&w=2>
> patch. It's known to fix similar problems seen with ata_piix.
> 

The patch fixed my problem.  Thanks,

Larry

