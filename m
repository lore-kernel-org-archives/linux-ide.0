From: Mogens Valentin <mogensv@vip.cybercity.dk>
Subject: Re: Gigabyte i-Ram cards
Date: Thu, 23 Mar 2006 20:16:40 +0100
Message-ID: <4422F418.5050905@vip.cybercity.dk>
References: <441F63E6.2090204@garzik.org> <44214F92.1080901@eventmonitor.com> <4421DDE2.60502@garzik.org>
Reply-To: mogensv@vip.cybercity.dk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cicero2.cybercity.dk ([212.242.40.53]:64970 "EHLO
	cicero2.cybercity.dk") by vger.kernel.org with ESMTP
	id S932588AbWCWTNE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Mar 2006 14:13:04 -0500
Received: from user1.cybercity.dk (user1.cybercity.dk [212.242.41.34])
	by cicero2.cybercity.dk (Postfix) with ESMTP id B19B8244DE2
	for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 20:13:03 +0100 (CET)
Received: from vip.cybercity.dk (port583.ds1-suoe.adsl.cybercity.dk [217.157.206.84])
	by user1.cybercity.dk (Postfix) with ESMTP id 611E574F89D
	for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 20:13:03 +0100 (CET)
In-Reply-To: <4421DDE2.60502@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Intel ICH boards can be driven using either the ata_piix or the ahci 
> driver, depending on BIOS mode.  Most likely, when you switched to SATA 
> mode in BIOS, it started programming the motherboard to boot in 
> IDE-compatible mode (ata_piix) rather than SATA FIS mode (ahci).

So, this could apply to Dell Dimension 9150 as well?
I only have limited experience with Gentoo (used at work), so I'm not 
sure what's actually what as yet on those boxes.
However, using stock BIOS setup, i.e. SATA mode, I couldn't install 
Slackware test26 (2.6 kernel), which use libata.
Didn't have time to investigate further.

-- 
Kind regards,
Mogens Valentin

