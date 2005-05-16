From: Christopher Allen Wing <wingc@engin.umich.edu>
Subject: Re: [PATCH] ata_piix.c: check PCI sub-class code before AHCI disabling
Date: Mon, 16 May 2005 17:31:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0505161726590.8582@hammer.engin.umich.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hammer.engin.umich.edu ([141.213.40.79]:20640 "EHLO
	hammer.engin.umich.edu") by vger.kernel.org with ESMTP
	id S261896AbVEPVcI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 May 2005 17:32:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: greg.felix@gmail.com, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Greg:

I think I have the same hardware that you have (Intel ICH7 SATA, PCI ID
8086:27c0). I can confirm that the ata_piix driver fails for me without
your patch. I get the same error message:

	ata_piix: probe of 0000:00:1f.2 failed with error -5


With your patch things work properly. I have the ATA controller set to
"separate controller mode" in the BIOS.



Jeff, should this patch be a candidate for inclusion in libata?


Thanks,

Chris Wing
wingc@engin.umich.edu
