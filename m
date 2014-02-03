From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ACHI: Attempt to enable a single MSI if block enable
 fails
Date: Mon, 3 Feb 2014 15:46:08 -0500
Message-ID: <20140203204608.GK30250@htj.dyndns.org>
References: <52EFFE7F.6050807@michaelmarley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:38390 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbaBCUqM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Feb 2014 15:46:12 -0500
Received: by mail-qc0-f171.google.com with SMTP id n7so12096428qcx.16
        for <linux-ide@vger.kernel.org>; Mon, 03 Feb 2014 12:46:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52EFFE7F.6050807@michaelmarley.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Marley <michael@michaelmarley.com>
Cc: linux-ide@vger.kernel.org, Alexander Gordeev <agordeev@redhat.com>

cc'ing Alexander.  Alexander, can you please reply with Reviewed-by?

Thanks.

On Mon, Feb 03, 2014 at 03:39:27PM -0500, Michael Marley wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> From: Michael Marley <michael@michaelmarley.com>
> 
> Commit 7b92b4f61ec49cb1a5813298f35258bd7ecd3667 ("PCI/MSI: Remove
> pci_enable_msi_block_auto()") causes the AHCI driver to immediately
> switch to INTx mode if the pci_enable_msi_block() call fails to
> allocate the requested number of MSIs. This behavior causes some
> systems (for example, the Lenovo ThinkCentre m57p) to begin using
> INTx when they worked fine in single MSI mode before.  This patch
> makes the driver try to enable a single MSI if the
> pci_enable_msi_block() call fails instead of switching directly
> to INTx.
> 
> Signed-off-by: Michael Marley <michael@michaelmarley.com>
> 
> - ---
> 
> - --- drivers/ata/ahci.c.orig	2014-02-03 20:00:04.834008843 +0000
> +++ drivers/ata/ahci.c	2014-02-03 19:34:53.737257483 +0000
> @@ -1171,7 +1171,7 @@ static int ahci_init_interrupts(struct p
>  	nvec = rc;
>  	rc = pci_enable_msi_block(pdev, nvec);
>  	if (rc)
> - -		goto intx;
> +		goto single_msi;
> 
>  	return nvec;
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1
> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
> 
> iQIcBAEBAgAGBQJS7/5/AAoJEANTUn3blhEaLo8P/31AEbD9b61h2zFAcGlqZmN/
> OEp69smHl9DbciaL0nQGIY4TRUpjA2XVxT/ZC3Fdz0huqX226g2D2G7/LLk299r3
> m/GC89640FBRaVqNTASNKvIANlq0t2vgdOXGsgLXCD3EAigMdCVLiKNvdDYpUdXo
> uaUg7WTVM12U+bWCrTB0RVgU7kKqkPSWb59kUPFaInjrTWzZ4jf4SZEzOr1b6mB0
> Ihn/BsMf76q9rzGEwTaKPV+BrS/QZY5oz23r8+Pqw+lNVgtnmCQ7UkRJ40MI3roS
> lU68syoG/CjI6imO/TQcr54eHMTBRl55Ut4VO/iLYaJKhXGGsuP43oPrJM0LZzpi
> jjwzgz4Bij0Hi5Wx7AS0sDNEERi+w4At/+eKQmUkjA6qUblzIKCpMMCmp0CvodXH
> 8J9TU9CqcnQs2hgGy990nFxdmiLh+Ee5NFBfKxpTGxv4eAjuK6RbxMLfndF6rRXO
> MpMoFMK3BdFnQoi6We5er7HKPcbqOpR2hrw8mALhWDxgv+N2pq1J5uG69mc5vwxJ
> YV7N0tnCtVTyxGavtMP669YCNH0KvRzXJvzJRE1TuuTvNu+oudMWJinilyhPnYJk
> U5DYzLWj4t42qEsGr3QjFBEv90DG/LNc5YavI9XOfepjGFbdlcGQPAe3HnaE86KD
> s9JiFcvAixL295414PRN
> =f6LE
> -----END PGP SIGNATURE-----

-- 
tejun
