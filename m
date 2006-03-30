From: "Anatoli Antonovitch" <antonovi@ati.com>
Subject: RE: [PATCH 2.6.16-g6ac37e95-dirty]  scsi: ATI SB600 SATA support
Date: Thu, 30 Mar 2006 17:13:34 -0500
Message-ID: <CAB45F03F8EF5B4992E343DBFC52032803076EDB@torcaexmb1.atitech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-haw.frontbridge.com ([12.129.219.97]:37563 "EHLO
	outbound4-haw-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751077AbWC3WOG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Mar 2006 17:14:06 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, akpm@osdl.org

Thanks Jeff!

-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@pobox.com] 
Sent: Thursday, March 30, 2006 5:09 PM
To: Anatoli Antonovitch
Cc: B.Zolnierkiewicz@elka.pw.edu.pl; linux-ide@vger.kernel.org;
akpm@osdl.org
Subject: Re: [PATCH 2.6.16-g6ac37e95-dirty] scsi: ATI SB600 SATA support

Anatoli Antonovitch wrote:
> Description
> This patch adds support for the SATA devices on ATI SB600.

Applied, though I had to do so manually due to two remaining problems:

* your mailer corrupted the patch, by converting tabs to spaces

* signed-off-by line should be at the bottom of the description, but 
above the patch itself.



