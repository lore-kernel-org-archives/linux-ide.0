From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [BK-Patch] ST3160023AS needs mod15
Date: Fri, 02 Jul 2004 12:07:18 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40E58836.9040901@pobox.com>
References: <Pine.GSO.4.33.0407021149400.25702-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52955 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264655AbUGBQHc
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jul 2004 12:07:32 -0400
In-Reply-To: <Pine.GSO.4.33.0407021149400.25702-100000@sweetums.bluetronic.net>
List-Id: linux-ide@vger.kernel.org
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: linux-ide@vger.kernel.org

Ricky Beam wrote:
> This BitKeeper patch contains the following changesets:
> 1.1414
> 
> # This is a BitKeeper patch.  What follows are the unified diffs for the
> # set of deltas contained in the patch.  The rest of the patch, the part
> # that BitKeeper cares about, is below these diffs.
> # User:	jfbeam
> # Host:	troz.com
> # Root:	/opt/kernel/src/bk-linux-2.6
> 
> #
> #--- 1.27/drivers/scsi/sata_sil.c	2004-06-22 20:42:10 -04:00
> #+++ 1.28/drivers/scsi/sata_sil.c	2004-07-02 11:42:45 -04:00
> #@@ -86,6 +86,7 @@
> # 	{ "ST360015AS",		SIL_QUIRK_MOD15WRITE },
> # 	{ "ST380023AS",		SIL_QUIRK_MOD15WRITE },
> # 	{ "ST3120023AS",	SIL_QUIRK_MOD15WRITE },
> #+	{ "ST3160023AS",	SIL_QUIRK_MOD15WRITE },
> # 	{ "ST340014ASL",	SIL_QUIRK_MOD15WRITE },
> # 	{ "ST360014ASL",	SIL_QUIRK_MOD15WRITE },
> # 	{ "ST380011ASL",	SIL_QUIRK_MOD15WRITE },


I'll apply this, but...  for what it's worth, a simple patch is 
preferred.  These bkpatches are crap :(  [not your fault]

	Jeff


