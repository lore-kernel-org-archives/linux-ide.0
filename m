From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] AMD SB700/SB800 SATA support 64bit DMA
Date: Fri, 22 Feb 2008 00:16:07 -0500
Message-ID: <47BE5A97.9070400@pobox.com>
References: <B90463BC30D2E446BA423D888DC85E502C6961@sshaexmb1.amd.com> <47BE56AF.1080808@gmail.com> <B90463BC30D2E446BA423D888DC85E502C6969@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33549 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751846AbYBVFQM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Feb 2008 00:16:12 -0500
In-Reply-To: <B90463BC30D2E446BA423D888DC85E502C6969@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, "Su, Henry" <Henry.Su@amd.com>

Huang, Shane wrote:
> OMG, but I modified my settings and verified that the patch can really
> work here before I sent it to you...

It's word-wrapping, and also quoting a bunch of characters, which make 
it difficult for tools to pick up:

> @ -85,6 +85,7 @@
>  	board_ahci_ign_iferr	=3D 2,
>  	board_ahci_sb600	=3D 3,
>  	board_ahci_mv		=3D 4,
> +	board_ahci_sb700	=3D 5,
> =20

That "=3D" and "=20" stuff was added by your mailer (normal MIME email 
quoted-printable quoting)

	Jeff


