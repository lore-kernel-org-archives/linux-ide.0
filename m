Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024FC4F30DB
	for <linux-ide@vger.kernel.org>; Mon, 19 Oct 2026 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415326; cv=none; b=a9vuXHvq5z02/52+4dqRw+pkwvxGxxSoRw2WxnEe80VCniLafhf4KKMz2Fj0vnvr0jStSaKcweiQZttNIFawVBWbCm4k6qRLDZohfkT11pxuXYSYCNN6fCVRYVtxRLKagwWuRXcBH5CEp05qDq3GLjGOr25h+QuXKhFtb3FIOCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415326; c=relaxed/simple;
	bh=6n04UjmHWzHkRI2pU81sYk4TGUvABFkPV8ul8H4khJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNTP02jn8xlNIVY+etypttnehrWE6TOJSZu/RR0k4hjVgBIPUb1yt7hWtVECsS2g21rKhnmBpfSUAIi+FcDQcQeEkT0q5seLTk3nYYDEHNxcbcBkUMWeridrIGovWh6tdqoq4ScIRiGbhnlGVzebyq+IcHuddzcXBgiiKUXnnrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5C0rCwh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5C0rCwh"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1cef0439aso22665625e9.0
        for <linux-ide@vger.kernel.org>; Mon, 19 Oct 2026 06:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792415323; x=1793020123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vTQAPwM+cnw+xqrbQuZPi16xVs48V+krw0MsL6q3+zM=;
        b=V5C0rCwhAEbMYRgw5cI6JESIJDR7L8tJpfRch3GmnL5Lnhi+yF/y1oigkXx+ZgEQI7
         SdIPuBNz6rrAsk/cQOYPEWD/jTgtZSlDbDJugVoU2hgf0Il36Q5JPKmqe3Z3w/gFyEB1
         Hbex/mfa1Z7bywpIGRfaP7pLwCYe/QWuMyzAKXBmJFo7mZJoFfCWkCVDld+bRD4YQuym
         l/LXI71wEwctd1YuWtOC5gUBVJRZ70VbUP/xx68iVsdGBTT+2QUDHhsJ6TuGHwrnZV7A
         VEIC8EeahShy2EvhVtQz1moTW1YY4J5hnaDUr8uVH5D8K6SQOsIBM+FcwMhPvIi/TK0k
         s2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792415323; x=1793020123;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vTQAPwM+cnw+xqrbQuZPi16xVs48V+krw0MsL6q3+zM=;
        b=sjf350sdN7dKu6tC2DZIeeUXODfib5eeH+SZRScQkYUZ9sG29mMFqz8Bx/4qQPY4Do
         J+k4DhEVJHyYZgMf5+hPDMqOIjAZks0qb9gQBx8892MTZIx8KkdWko/TIi/JlbO8fnyQ
         wzBTJKyX432KXr2uXoP6EEoq6sLy8ZG9sE+EXpVJ4DDcBHPJgwYydnIeIQGGR1YNKYNl
         LqryHLCSi3vmaTHYX+93toTbER2f9jDOKhgm1SyjNe0oroUrnFfzmQsQWCWgqSih07g5
         bxKjNivK3OLkRk4f2Hcy3YhfJ11kBqzZHsuxAkOZiSrlO4kzaLrSwRnvjOcIUq6SkXuI
         4GjQ==
X-Forwarded-Encrypted: i=1; AKwUvBwIKRC8M2kNBpn7rlGz6HlCwTmamHcXqtGkYY0TrBtAqv32Vh6nu9dlWIi8IROMlafrgD7V8frWQmY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBQ5dUj9H4exPZ7Tv22DV+l8m2iJ8PAGA5jVrSrjl4djYFla8G
	tCJC0WK4FiDgvRaPmDSC5l069NjWhWaFpvPcNKeDG/GUwmPOw/pe/9s=
X-Gm-Gg: AYBFou1GOkb4T8UQHk2ahFPcmy7PO8ZAI6lWimmNL8fzuuxEOWeKLvZKVihfG6/DLul
	COM6cToYnQkNQTVA5h9LPUY8aalJnE6KJlqP81IdfJYJ8l4kG3Uli4xfW6rlZMpi6XsI6iIScOM
	LQsF/6yM3/esyuMhnKnEsf9GZ8rVSucEGZ1MuF6MEPtiFJpUeCE5yWnK9WuEm878uG0ghOAqK06
	YzH0GJDS8mnG55RW2ZAukLbQHZcDPGW532IvV337NPelm2WWpLPNyDFRxUk22e/AhMNfGBtJn5J
	Yy+zEno5v6F3ZhHpDFQyZO8Yl2G46DCF4zygX4iRClkLXAE3xV/4eSt0VCxSVrDnDaOs0SWJY9q
	CWj2+qsTuakXB/wQGL+hS4iP/QMs6EQaQ35J2F6b6lgO2/BBZ4up1MCkf1NcRB8psY4Q+xAvY5u
	pn+SKV5UIDtReCFOhDqDoKjPFGinFpAyJLiDb+baxJX7N3DBb+3n23Cd2RPRkGsVnjeeOUsS+9V
	O+jlETFVQyYo9k9UBrSjnkT7wD5mwrMVPDBHCQMOING/nNFHeoy8opRgAgiRw==
X-Received: by 2002:a05:600c:8485:b0:4a1:d7c3:d3d with SMTP id 5b1f17b1804b1-4a1ef992f33mr17017955e9.10.1792415322800;
        Mon, 19 Oct 2026 06:08:42 -0700 (PDT)
Received: from lithos ([2a02:810d:4a94:b300:7ea2:632d:ad2b:6944])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f8d12sm23659618f8f.36.2026.10.19.06.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:08:42 -0700 (PDT)
Date: Mon, 19 Oct 2026 15:08:37 +0200
From: Florian Fuchs <fuchsfl@gmail.com>
To: Daniel Palmer <daniel@0x0f.com>
Cc: ysato@users.sourceforge.jp, dalias@libc.org,
	glaubitz@physik.fu-berlin.de, dlemoal@kernel.org, cassel@kernel.org,
	linux-sh@vger.kernel.org, linux-ide@vger.kernel.org,
	geert@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ata: pata_artop: read the ATP865 mode register
 through pci_iomap
Message-ID: <atYWVQ8ymEgIcyZh@lithos>
References: <20261017041419.311921-1-daniel@0x0f.com>
 <20261017041419.311921-2-daniel@0x0f.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017041419.311921-2-daniel@0x0f.com>

Hi Daniel,

On 17 Oct 13:14, Daniel Palmer wrote:
> artop_init_one() probes the 6280's "fast" bit with inb() on the raw
> start address of BAR 4.  That address is a PCI I/O address, which is
> only a usable port number on platforms whose I/O port base maps PCI I/O
> space one to one.  On an SH7751 LANDISK (identity io_port_base, PCI I/O
> window at 0xfe240000) the resource starts at 0x1400 and inb(0x1400)
> dereferences that address:
> 
>   BUG: unable to handle kernel paging request at 00001400
>   PC is at artop_init_one+0x10e/0x170
> 
> Map the BAR with pci_iomap() and use ioread8(), as libata-sff does for
> the BMDMA registers later on.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  drivers/ata/pata_artop.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
> index 9f8d41639a62..351ff4c8e48e 100644
> --- a/drivers/ata/pata_artop.c
> +++ b/drivers/ata/pata_artop.c
> @@ -405,13 +405,21 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
>  	case 1:		/* 6260 */
>  		ppi[0] = &info_626x;
>  		break;
> -	case 2:		/* 6280 or 6280 + fast */
> -		if (inb(pci_resource_start(pdev, 4)) & 0x10)
> +	case 2: {	/* 6280 or 6280 + fast */
> +		void __iomem *bmdma = pci_iomap(pdev, 4, 1);
> +		u8 cfg;
> +
> +		if (!bmdma)
> +			return -ENOMEM;
> +		cfg = ioread8(bmdma);
> +		pci_iounmap(pdev, bmdma);
> +		if (cfg & 0x10)
>  			ppi[0] = &info_628x_fast;
>  		else
>  			ppi[0] = &info_628x;
>  		break;
>  	}
> +	}
>  
>  	BUG_ON(ppi[0] == NULL);
>  
> -- 
> 2.55.0
> 

There is a small logic change, where -ENOMEM is returned, when BAR 4 is
unassigned, where libata would fallback to PIO [0], so maybe it
shouldn't fail when BAR 4 is unassigned?

Tested-by: Florian Fuchs <fuchsfl@gmail.com> # on PX-EH40L (LANDISK HDL-U, ATP865 1191:0009 rev 10)

I also tested forced PIO4 mode via libata.force=pio4, which also works
on the device. (ata1.00: FORCE: xfer_mask set to pio4)

[0] https://github.com/torvalds/linux/blob/master/drivers/ata/libata-sff.c#L3088

Regards
Florian
