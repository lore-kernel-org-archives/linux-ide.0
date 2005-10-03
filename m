From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 5/7] AMD Geode GX/LX support
Date: Mon, 03 Oct 2005 20:06:32 +0100
Message-ID: <1128366392.26992.33.camel@localhost.localdomain>
References: <20051003175851.GG29264@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:48592 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750823AbVJCSjI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Oct 2005 14:39:08 -0400
In-Reply-To: <20051003175851.GG29264@cosmic.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com, linux-ide@vger.kernel.org

On Llu, 2005-10-03 at 11:58 -0600, Jordan Crouse wrote:

> +
> +	hwif->udma_four = w80;  /* w80 = 1 if a 80 conductor line is attached */
> +
> +	if (hwif->mate)
> +		hwif->serialized = hwif->mate->serialized = 1;

Is this needed, it doesn't seem to be in the databook or errata ?


> Index: linux-2.6.14-rc2-mm2/drivers/ide/pci/cs5535.h
> ===================================================================
> --- /dev/null
> +++ linux-2.6.14-rc2-mm2/drivers/ide/pci/cs5535.h
> @@ -0,0 +1,72 @@

Please put the private structure into the .c file as the other code now
does. Its a tidy up that wants picking up.


