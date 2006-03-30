From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.16-g6ac37e95-dirty]  scsi: ATI SB600 SATA support
Date: Thu, 30 Mar 2006 17:08:46 -0500
Message-ID: <442C56EE.3010702@pobox.com>
References: <CAB45F03F8EF5B4992E343DBFC52032803076EB1@torcaexmb1.atitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:16037 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751066AbWC3WIw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Mar 2006 17:08:52 -0500
In-Reply-To: <CAB45F03F8EF5B4992E343DBFC52032803076EB1@torcaexmb1.atitech.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anatoli Antonovitch <antonovi@ati.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, akpm@osdl.org

Anatoli Antonovitch wrote:
> Description
> This patch adds support for the SATA devices on ATI SB600.

Applied, though I had to do so manually due to two remaining problems:

* your mailer corrupted the patch, by converting tabs to spaces

* signed-off-by line should be at the bottom of the description, but 
above the patch itself.

