Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CB42DF707
	for <linux-ide@vger.kernel.org>; Mon,  5 Jan 2026 23:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767655588; cv=none; b=Q1TH0TbsffWAMt3plPxN0pl3u0qiKBW6dI7h2io06EnX2SWLTPtagpeBXsFFUVcCmigGZJ3WwtxyTavp0zmvXMkSueM0SK3mcubsbYnPK7NYgE2egIYtgLMThTgS4j0ZdXt31eQc7TVW449VJAKCj8vYCWSSV7g1t1RdudTi1bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767655588; c=relaxed/simple;
	bh=E6fi/k+WJlX9JaL3qya2sm7lIzGqRfXc4StGV9/lhqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njgpJ1F/JSDm9YPTTnOpaJJylrgd2pJPLYRXcus4DpeBtE53ZogzDMDAT5RPtw3VbbPzZT9dfVDZiCnRu/872WXSnWh4hd04KfbzATErsZdlx1VHnu54x2Jt2yeg7cBnxRiIxct+wUIogx2tVIEv8J+1ojUbAIkPX9d6q80wqZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wnpj9WNE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wnpj9WNE"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a0d06cfa93so34455ad.1
        for <linux-ide@vger.kernel.org>; Mon, 05 Jan 2026 15:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767655586; x=1768260386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4RzpOLu9vNnl6xKFGK6Mo3CRqEDyepCvmuYVGfejP9I=;
        b=wnpj9WNELuGb9N9TeVIWQ3jMqaA0osr3Tul8CCktMcuPkGbfqxW4ldOQkbQUCNucZc
         YDP30No7C9nLx1IRSXof03KYopBsR+giBl03zwudeuKTCOchbNQ270oKfuF+mINNHbG7
         H2nFIAmPPhTdbbSI9F28vwJiFLIIS2PhCcNwbT6Ac3cgBCp6MUex7+X9nYl2G35yCuSm
         xtNpT8Bix/cxNAyqJexI7jX6SSZ4y8D9vbK2uoQAW+/eRhd30gy2FnZ9ITolyJ40uDss
         WIABZZjlj66szDJ4ycrCz3MtACW3zM5tgcaCZEfwenz//GJtX8S8V6B2QRQAkgN4oLVv
         KKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767655586; x=1768260386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RzpOLu9vNnl6xKFGK6Mo3CRqEDyepCvmuYVGfejP9I=;
        b=tXzV4ZbyTNFZ3HMQB8ONdufnFH97fawMIAwr88X7W+2DFGlRwnpEqBXmN8GsEejIup
         xRNMAbqYiIcUbTpQ5cFhRB4QsFLflsnteFZ1lsotvgHxq8UfO2xHejIigTlQKZ52QT4I
         Bsuu3CcgjSsue1LtYwQa+5zEm9WCi7qo4h7uk0EXwcMMfb2E1zn9YZuyD3Dg/lyS6m1q
         y22yyc51huqnD83JvRnUQpKe6VetNypH7auT31F62H3VjVTxQE7LkBIqg2KG1NxRiIpu
         pM0j8JR6i7QDLwjRRBfIu/VirBAK+xZLY+pL1sg5eR7oGNWsGK1Gtawb7B2C1g+IQwHq
         DIPw==
X-Gm-Message-State: AOJu0Yx+Hrp1+eydb0tLCazXhwDB5FJFnp4k797jAfMuhAS64NaVYhmb
	mqS+uImjRsBLsVFgvBkxdkdEaBYea128sq3SfTayweafpWpjtnjkDgpG9t9OE2ujMg==
X-Gm-Gg: AY/fxX4n3MTLzv2hlU6996lZ9a6OLgiKsQDWy/ryygi/NIZ7szcYr+/KnoxKOk31dwh
	9qnD705K9Pa6pOfFWJhe/lYK2o/sSBLzPKul7P8acN1eztBvhtmaPwwIXSGhblXMOd/kTPmfL2K
	GILGQlCZlaPVc2cCaMhVlEOWq7tmucv7UPrHKYQJI9lsf3veUfWP6c4jkNZu+J4azBe8Wm0SN0o
	uV0C2SyR32Tx2f4Og6Ggr3jtUP7n4GYD3XvGo015fp9rHGwOXjY29YfKLfanjdy0XMB1LkIzHoT
	NoUF6Vvjjfpcure9l4bbbMDh1fyShfJIM6yY8KcOURGCMpqfUaQpvnLt92EU/3xWUzCaTlr3mH8
	pwA6ZjtgdJadIz5keGAXt0NuMfcRnqcxuv0zaTGrdOviipbQyPOiTXMShN0V8BC/andGGACEfP2
	eZRIPIQJIcXPdPJrSyIDm1XV4O21o0wv2qjljZZojkTU0JyDmJ0w==
X-Google-Smtp-Source: AGHT+IGpRFm4sSd1b+3aCWEytSbj2iig1Qbj8H05ZZ1tOM1awvYZ4d80e8gUVQe9rtgwakBBfh+f7A==
X-Received: by 2002:a17:903:1a6f:b0:271:9873:80d9 with SMTP id d9443c01a7336-2a3e42a2e1emr465825ad.7.1767655585444;
        Mon, 05 Jan 2026 15:26:25 -0800 (PST)
Received: from google.com (185.29.127.34.bc.googleusercontent.com. [34.127.29.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c5de6405sm208941b3a.61.2026.01.05.15.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 15:26:25 -0800 (PST)
Date: Mon, 5 Jan 2026 15:26:20 -0800
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
	Xingui Yang <yangxingui@huawei.com>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v5 1/2] ata: libata-scsi: refactor ata_scsi_translate()
Message-ID: <aVxInN8EV4p_gkY3@google.com>
References: <20260104082203.1212962-1-dlemoal@kernel.org>
 <20260104082203.1212962-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104082203.1212962-2-dlemoal@kernel.org>

On Sun, Jan 04, 2026 at 05:22:02PM +0900, Damien Le Moal wrote:
> Factor out of ata_scsi_translate() the code handling queued command
> deferral using the port qc_defer callback and inssuing the queued

s/inssuing/issuing/

> command with ata_qc_issue() into the new function ata_scsi_qc_issue(),
> and simplify the goto used in ata_scsi_translate().
> While at it, also add a lockdep annotation to check that the port lock
> is held when ata_scsi_translate() is called.
> 
> No functional changes.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>

