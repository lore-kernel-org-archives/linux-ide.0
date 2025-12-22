Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEC83009C1
	for <linux-ide@vger.kernel.org>; Mon, 22 Dec 2025 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766438351; cv=none; b=nKqAica0w/hLp5cDklwAGZvJv2aKDQWPqOa2IGC/YF5wR5Bs4mSC0gNRmwiPaIvbP7zufnzQYx8h1kPIIV8oAgcNtyAyRYMcDSeAZkAnMIoi3ErHyWLm9zlPqDgbZguVKXma9GOt//HIFP2tG0PMUwsK6DwiF7tDWkrOGm+eRoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766438351; c=relaxed/simple;
	bh=F9kR19xzx06gpyCDNxTxSMTrM2Jrvh1j3B48ySPCyTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3KV4cuuyMX3z7ZSyfWSJhd5Oq+cDIIkxnvDNHZ1zVW+TK7VrS6NKNh2hQrkhoebCgxQAQGbhBIaJ2+utIa9ZojCbp98WJNs8SNRK/bKyNr8sWU/WAvsASj5XKdJo1gn3xo6y9Ml0yVSlWDJ5Qq1G+3YmG1NKi5NvbmbylVrzQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2+Y/2ckw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2+Y/2ckw"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29e0753e5d8so573895ad.1
        for <linux-ide@vger.kernel.org>; Mon, 22 Dec 2025 13:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766438349; x=1767043149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bFTJeoz8GqsfRbAkCc2wdiOZwRmDuLGCiuYXvRybx5Y=;
        b=2+Y/2ckwvuGhddDO9WvO+IOtBLSDSxO01qeOunhTgJ3K912BF6g/giNm5sFr69xRTM
         6vgZyJOM99Ir6sVko19H/kaz46t98ytFBwr2+PB9kJ8Dv8HaxVLo42soRQqkTM/KuPUC
         LYc3/lHcX9zFySiJZq0if6G7psKCpAfeFUnY+6/CUlNkQIKr/Y07nj9IFENwMztUmRu0
         7VbAjbnQbwZbAw9J22bnZqIIt0OexJc5g5GUSXDZp5pjl8bhrQH74c6j9wxi3ZSag6Yb
         D78xjCDqiOGyZm85vLpWSI3HdK0Fc8reZFa/YqP4pBRJMVt2wKivSiL7ih/V9MHuBGth
         bWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766438349; x=1767043149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFTJeoz8GqsfRbAkCc2wdiOZwRmDuLGCiuYXvRybx5Y=;
        b=sOcE7u7zkQg8PpSGjPr2vC3uR90dLjDBSD4jc2SF7f5GdmpKpx2tct2SEKq4gHQTrP
         q7MWWxkq4CWh6lFlJlMO+pa8WblPuMCXngbusmQCCxtPpD96vJB9q1eTVskyUS3QXLPq
         eLRLI+fsScmuZ0iqwlA+2bySkdwmizrndnZxEUx/Wz7pM8ubQQEFHFw+obkvWDKcby0h
         azvhRkAuddsErxX21wkgZH0FoBLUWmuOT7SiWhEmZx2x42GXDIlEEHSC1Qur+CZOGjB7
         +aB3Ll4Nb27NndwJ4TSw+Hj98JTD4ZVAIVCusgpeSKTZQYSGqo+QZLHFS0nNeMJ9z32C
         LcKg==
X-Gm-Message-State: AOJu0YxkVwh1HP9yTG9m+SzBlNzo2juFTi0fjGrkCV1s+9fvM9o3G+rQ
	mto+z4YpjF6VfTeTH5MgsY3fhMjijJXEDasePoAscVFnL9st0EknHInCt9VRVk1dvE6kfKnkPBM
	yOKsEUw==
X-Gm-Gg: AY/fxX4ExPKcTg1oZfilUN7J0puYf0TPdlxhc+oG9UIAGcx9AxfnO9c59vp/OgIQcUE
	7tQJ3YqWK8txrpWzDc0fbhtDmwj2W8d0JHfX1evI8YX20uV2WEINuw/izYJxvPzfO4JpYvmjVTj
	MWTDTEFil0Y/o6ZukcYnYb3MplqLnxs4XbBfK5DPWKClkikQeYnwlp6rYOYPGbkE8NmxdPZT9E5
	myfKLNwjIPsYD7lHi/sUQlCzEj4nSYYY4qsCf+JadwhqQO+1LOZzDdqHhNovxJz/eNebFWInoA5
	1X5VgQA2AWd4vzp0NOKd/xjKABMFfSlENoj7sSS556KRl/41cHg6jZMIKY9ri2Xct0+DoGZ0BtM
	T6QswD556wcwiIoeCf7zPrYMKZRv8JaDjs1/uwqR8+5UfiYxpk3XSiodkNd863JlkhyifVXW0ag
	YeTs807w8IY0HZb12GTzm3Sd0iaV3IV0w/oZaFsXkwoKj0SnRSioKHIsPE2C4unfo=
X-Google-Smtp-Source: AGHT+IH0TmEPuAOlMdv9IdRLcAw5/HDQ7h312a1vVvj6TipAex4bakKNCUgWXSScQM7/aGfAgoJblA==
X-Received: by 2002:a17:902:e841:b0:290:8ecf:e9f9 with SMTP id d9443c01a7336-2a3142b8db5mr4120645ad.7.1766438348689;
        Mon, 22 Dec 2025 13:19:08 -0800 (PST)
Received: from google.com (157.132.203.35.bc.googleusercontent.com. [35.203.132.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d6e4sm106092275ad.75.2025.12.22.13.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 13:19:07 -0800 (PST)
Date: Mon, 22 Dec 2025 13:19:03 -0800
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
	Xingui Yang <yangxingui@huawei.com>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v3 1/2] ata: libata-scsi: refactor ata_scsi_translate()
Message-ID: <aUm1x-s_IX8jkpNp@google.com>
References: <20251220002140.148854-1-dlemoal@kernel.org>
 <20251220002140.148854-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220002140.148854-2-dlemoal@kernel.org>

On Sat, Dec 20, 2025 at 09:21:39AM +0900, Damien Le Moal wrote:
> Factor out of ata_scsi_translate() the code handling queued command
> deferral using the port qc_defer callback into the new function
> ata_scsi_defer(), and simplify the goto used in ata_scsi_translate().
> While at it, also add a lockdep annotation to check that the port lock
> is held when ata_scsi_translate() is called.
> 
> No functional changes.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
