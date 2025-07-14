Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF173D76;
	Mon, 14 Jul 2025 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752478132; cv=none; b=aomytcRmztf3RFInQHdKKaFrVcpTYMmDyL5ueVH+m9ZhRuY2atBWX+X3aG7Rm6cnRDCAQ+xUk28iO3SRoMsX1T90He9uv+pnQ7vYDaoFT5spwmscL4ptDnHJDqNlEQ6uhJJ93sYdGPOgFqkRgBwB+7pHLzvWBsS5RjNMkpw5Aic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752478132; c=relaxed/simple;
	bh=mcIeN26mW2QOCg36HqShkkGX0SI7BYu0b6H25sH1JrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVipo24KzzvWuqBx1jDbHiUTUJzg50nXLwygsE6ZptFuJi2Xxk6o2Ax/KLD3B8hANBWQYptjh4jo+GrCs1JCRamnOTBUUYgoNv3bW201U9J2A/r6rBBuV/+ntfFkSD+1y+v+2AWeCL2xMq5j7ZlWcJ0/fWY2pfGwK6rQ3fjhTIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flawful.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (1024-bit key) header.d=flawful.org header.i=@flawful.org header.b=JFJ0Bhc8; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flawful.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flawful.org header.i=@flawful.org header.b="JFJ0Bhc8"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-553b60de463so3849518e87.3;
        Mon, 14 Jul 2025 00:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752478128; x=1753082928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f2VNptzwv2bPiplAojd0riBXktnKtc+U1EZ4E1NYtxE=;
        b=pM/doVMIY4KlznyLvG8COcjDufeHo2xlr7N85XndCHh7iLXa7Zqf6FNgKkGgxBJkac
         /Jqp/XjE0TEHhPHoAfHDq1mBJsDbq4BqfW0olK1GKKb7g/NMCh3GMXaDm6YoQeFJK6bJ
         UHPoFr2+8GmoxjwTImM8TUKi1lNw18axbX3COvDcReL/aWHHyspwgpPUnUUghGOzZO8k
         jTdScGkBmMZLRTms6I4v2fFMHT3IlkvdXB+GEnUdKCIeiEFgS5bwXhD6R27GL7YaJJmd
         MZMBcHpX/uIsGjlmfVh85paCLDhPX2kEDWJO1/zbCjicObAnMshAhdWeu5B6e6dvuDQN
         KILg==
X-Forwarded-Encrypted: i=1; AJvYcCWO4+TbiYlidPfSaR+kEAPae5vExxmiRHaI7ndN28+zLVchHdmIKXNVKaL1qcJ/a5FWkyh9rwEU/fY=@vger.kernel.org, AJvYcCXoJr8ucP2cZDnR0NEUuPUzBzdI4XCJshUVZ6L7s2F/wvwxqoECHJNnLylCdM5lNKAiwWqaVWChKZfO4BcN@vger.kernel.org
X-Gm-Message-State: AOJu0YyqmQiNa/lXuvcc6If+BJvgGYxKXvN0Ocqh7AOvrSeOOZKKlPZj
	RtYCLGuemPAQ5ljHNaWveMIhRzRzfB2iEGoHjtph9k1/IXC6hhrr59d11yUjCApR0CQ=
X-Gm-Gg: ASbGncunrlaITiD8xIERp8WvjYq8fHolMLQzgYasdIIRafpTUpXb+XWYEuGdaxZqSzq
	71iuX56kiH4UjOe19U4n4cbspycR3Tti+oS6dn+3inVV6nITouwpJAPaxvdetU3tdrf8D85m+v0
	TwSWUE/LNLKWJoVnqF4roRfFKN0A5rEDBT9dcZ8SjisdgoAi0tZC3hOk/h8QbUoYaHe3KGKo/NJ
	jstPrxGvXUqsSjdb1SYsJn6tZaDmb13wC3mbAp/jN7zjZD/dxKr9e4MrT5+qiAtgf7ObaOMuo90
	t5qqw+ydGxt0O0imaF8qr288tu8lP9wcHsHix7Y2B1QNg5FhjUoUdnL+QR3yJE5R8djMd7GIhri
	52e/6/wTwLDSV0x/tuMEw6Rje4DPnSTt2W7Kk+q3aDRkmhX2FKJc=
X-Google-Smtp-Source: AGHT+IFk3O9vkoMK0ual1K0OKlq4gSNWgzsMAGkIHDMAlkS86/lMzIvTztWLdeBgbxoYovoW4dLkTw==
X-Received: by 2002:a05:6512:33d6:b0:554:f74b:78ae with SMTP id 2adb3069b0e04-55a0462c4c8mr3455107e87.31.1752478127937;
        Mon, 14 Jul 2025 00:28:47 -0700 (PDT)
Received: from flawful.org (c-85-226-250-50.bbcust.telenor.se. [85.226.250.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7bb444sm1879287e87.7.2025.07.14.00.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 00:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
	t=1752478126; bh=mcIeN26mW2QOCg36HqShkkGX0SI7BYu0b6H25sH1JrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JFJ0Bhc8bHjWrlucyV2mJX6mylGTMyRJWJJv+1rolkJQe54lfH+8DSZ1BB18Gzeec
	 5ZMaHt1SoM3cK+9P2tO9SwhQpdekCPkPWQeO2lTk1R/eoLJ+M8h1cVd2o61CraSrz+
	 FDLlWzhrR+G7ebD1PpJ3ofYyW9w0vrShlDHVcyXI=
Received: by flawful.org (Postfix, from userid 1001)
	id 2CDD82C7E; Mon, 14 Jul 2025 09:28:46 +0200 (CEST)
Date: Mon, 14 Jul 2025 09:28:46 +0200
From: Niklas Cassel <nks@flawful.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v1 1/1] pata_rdc: Use registered definition for the RDC
 vendor
Message-ID: <aHSxrmZ41-YOP7PW@flawful.org>
References: <20250711113650.1475307-1-andriy.shevchenko@linux.intel.com>
 <6d0b19d8-fb1a-4a3f-9a21-7c696df880c0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d0b19d8-fb1a-4a3f-9a21-7c696df880c0@kernel.org>

On Mon, Jul 14, 2025 at 09:32:09AM +0900, Damien Le Moal wrote:
> On 7/11/25 8:36 PM, Andy Shevchenko wrote:
> > Convert to PCI_VDEVICE() and use registered definition for RDC vendor
> > from pci_ids.h.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Commit title needs "ata: " prefix. Niklas, can you add it when applying ?

Yes :)


Kind regards,
Niklas
