Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1153D322DAF
	for <linux-ide@vger.kernel.org>; Tue, 18 Nov 2025 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763478779; cv=none; b=os8WxHvH+lram0QNf9y0onSIFvtkkf2a/2PbDN7daMz3UTyouUQY5emKoO3gV0T7qyezs0k7jF49z9O0nUhbm59DJGWMlii7/8ja18rEEdifVb9H1fnNavah2q4+tuKXezvFp6g2ci2+yBH871SsPTINoglCroMnllsTMzma8jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763478779; c=relaxed/simple;
	bh=GqVsyjgz9WTOsR7HTxufMlHGUJnUnGy+rFjXcfWDQ1o=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=T9HxyozegPtOw9tIDTe/4KebcGpHOUqiNgYoNyLYiCMAAhdh7a8KznUItly0B2SCw1zJ6gxVUqKe06484aY47q71u5+vSyuZXXRX024OuVlfQpC2Uzq+mHPM9vcPswIw5ZvEuflj7/KFlz8/066MNX2FRZMvdRKp0GK4trKL8XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=CopaHvdw; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="CopaHvdw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
	In-Reply-To:From:Subject:Cc:To:Message-Id:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=KMokZP+fDNsZ2IgczkDdY4s45umUpfkK2lK9EFRVbTk=; b=CopaHvdwLFWuxsRhHvDexoYbWc
	Z+ZaBqOaykYu1iV3l1rJvIYQC6kRWnE5wDztG9wi4CfwVb4kDiWJwS1tpm6gHYmQSkN+QgMiJMZ5g
	aQjbnHQJcviIp/2Beu9eGLRHADu5V99alxU4dYypXXmHPeXD+E2u8uPYC377w+dYlnVoMTcXs33Lc
	sJDbvlo6B1CIPC7tBZjz1o3PmSJ5gzUFuh5lWnAxfxHMdcJGtuCvqeCq9OQBy/88F5GZMyg05/z4c
	pxtgdzHTl7+FVmGjcNXIhstGZCY/mPu8hCfkTKKKJAIWnvNeTppTiGMlXRGlhxAgMy4HFRhWqAQV6
	uxrIppnw==;
Date: Tue, 18 Nov 2025 16:13:05 +0100 (CET)
Message-Id: <20251118.161305.959866833545078228.rene@exactco.de>
To: cassel@kernel.org
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH] fix PCMCIA Iomega Clik!
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
In-Reply-To: <aRyJB2j4MDNIARIM@ryzen>
References: <20251117.134321.1327313572065130952.rene@exactco.de>
	<aRyJB2j4MDNIARIM@ryzen>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Tue, 18 Nov 2025 15:56:07 +0100, Niklas Cassel <cassel@kernel.org> wrote:

> Hello René,
> 
> On Mon, Nov 17, 2025 at 01:43:21PM +0100, René Rebe wrote:
> 
> Please change the subject to include: "ata: pata_pcmcia: " prefix.
> 
> I.e. something like:
> 
> ata: pata_pcmcia: Add Iomega Clik! PCMCIA ATA/ATAPI Adapter

sure, will resend.

> Looking at:
> https://en.wikipedia.org/wiki/PocketZip
> 
> It seems like this device was renamed to PocketZip.

My devices have all stickers with Clik! I don't have a PocketZip to
test.

> So perhaps:
> ata: pata_pcmcia: Add Iomega PocketZip Drive
> 
> 
> > Add PCMCIA Iomega Clik! ID to pata_pcmcia.
> 
> Perhaps:
> Add Iomega PocketZip Drive ID to pata_pcmcia.
> 
> 
> > 
> > -- Signed-off-by: René Rebe <rene@exactco.de>
> 
> There should be no "-- " before the Signed-off-by, see:
> https://docs.kernel.org/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

Yes, of course.

> > 
> > --- a/drivers/ata/pata_pcmcia.c	2025-02-27 18:51:20.641993816 +0100
> > +++ b/drivers/ata/pata_pcmcia.c	2025-02-27 18:56:22.022992807 +0100
> > @@ -362,6 +362,7 @@
> >  	PCMCIA_DEVICE_PROD_ID12("STI", "Flash 5.0", 0xbf2df18d, 0x8cb57a0e),
> >  	PCMCIA_MFC_DEVICE_PROD_ID12(1, "SanDisk", "ConnectPlus", 0x7a954bd9, 0x74be00c6),
> >  	PCMCIA_DEVICE_PROD_ID2("Flash Card", 0x5a362506),
> > +	PCMCIA_DEVICE_PROD_ID2("PCMCIA ATA/ATAPI Adapter", 0x888D7B73),
> 
> I think this should be something like:
> PCMCIA_DEVICE_PROD_ID2("Iomega PocketZip Drive", 0x888D7B73),
> 
> Also, make sure that you add this entry at the correct place, i.e. in
> alphabetical order (Iomega, before IBM), please also make the hex ID
> string in lower case letters to match the existing entries.

Did not notice the list was fully ordered, the hex probabbly pasted
from some pcmcia tools output. But happy to reformat for v2 ;-)

Thanks,
	René

-- 
René Rebe, ExactCODE GmbH, Berlin, Germany
https://exactco.de • https://t2linux.com • https://patreon.com/renerebe
