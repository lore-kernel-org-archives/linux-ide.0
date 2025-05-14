Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0831856B81
	for <linux-ide@vger.kernel.org>; Wed, 14 May 2025 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747222877; cv=none; b=YDGIglgdI4ElDpp6h5x1oWQgelSJxMRCW8KCzeC4zpaMhrpo2MiiYVvXoBEH5aHJxs2YBuxMHhzYJGc2bUrMbGMGuJIBNQ9gztbIbQ1MlStAV129dtT6efhRhgEFApUlRxTU7oXuLs5DZi0u+gGuvDXqYbNd0YhbYPyee+S0qeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747222877; c=relaxed/simple;
	bh=AvMS1QZuWH8nM9oPd+mGGzHreipLq8tB7qOea+edNvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uByoi2k1iKIAYsmPkbM+hPacytK/Z1J/NRG0R0BRMkAoqocTqQvKKGpXmX/96CndwFuZQUZWijdPYrIPbaK0yIY0hP1rt1MbvDz9ZMDspCdbX2gMHBUy6ZYuT3kBi7X8Lfq3+MCiHQMTgPSClttWDRev8qggBFc78hg9tBAhD5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyvmSghd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyvmSghd"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-442f5b3c710so3633835e9.1
        for <linux-ide@vger.kernel.org>; Wed, 14 May 2025 04:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747222874; x=1747827674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=et8U1o84ecbh6m4FOLOfviKzf2/yLZIseHIwaaEPlVY=;
        b=gyvmSghdiXDHg6VHiY23kykWoYflKeAArqj5jSNCyBZd2SWeO9A7UXfvTHOBfVzm17
         migrRHLM1kZ6xMg9hQ1BPHIXnGG8XvnIcsP6qBnfHmYHz8AIr2YJqgGvmYHfiMtOHOPI
         R8H5g8YoPNGu7117VuznBm+0kCNJ7jfMsLhbsz2qM21RrGAgPLBttTMEBmSI2S5upe80
         YCrWhtf52W8TJKNZyk4rupxrTOfOgRSZ4MWnkFZ4QUlOHW/0Wfd3md7QMl6vXIct4b2n
         RKPexdkrubmv65WKhtsj6JAMo7BosDTPSCtrQAZK3uqj/7VHb8NOL/189JqeN+Eygl9X
         Vy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747222874; x=1747827674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=et8U1o84ecbh6m4FOLOfviKzf2/yLZIseHIwaaEPlVY=;
        b=MLTZj4cc7h7PAg+74EXedC5JD8uNxdOd9xI89Wej6OVU+LbbLkLHqgD5pnyMBB/CNc
         ap/T+YVN1bOQ9IbEIYy1Ggx3H/Ou+ziVl3SqiNL6wyUpqwubZo1OL5dIvx+pzLPni/U7
         50hNk55dtUgSCc/LMoXrCQmfXuCFT7y7F5dm22ksSnaJF/zIHkt06Xot2vilnryaNMPF
         nQQq69+s6LZUzLMFOMm6lt2B50bG/RVSLw9+aIIh3B2zKRSShwqbbuKFxzG1/UpwYtbi
         3QL5FW9w6GTuNgbWs49/WXNDiu1zq90DzzvUCXmQzONFkRzMp/hSmn8qOR5+6QiJgA4U
         dC9w==
X-Gm-Message-State: AOJu0YyGxbtlhuBJVEkPm2GQx2AMRvrlLuTtaNim2pcVexi58hvBj5X3
	dKXonrQVpwfeYCBjfNTF4iQczyWXp6/DK2lxK6wnRec7fxq32Y46
X-Gm-Gg: ASbGncu/lCjpD7oXVOhbyfR5soLjx4LPyEiaPUM1ei/wjLaPHaT0fMOFd3+tSMhzPJ4
	SENIEeJu2yg8nwZ2gGWG1UhmGau9bJQnM5SaEm490sLfUW7AvIq+qoibF15+j7HqWbUbEuPuzgR
	D1VZYF151xasCEF5KLBRbSdSoK6SXVlmgEXuJUonn6jq+XuhPLU90CKJ5gtoe8pXn+oi+KeJpd4
	H4bSNv/S8bV7T28s56RjW5z5cVJclf4Y0lSraTpv8G6gKjH50PGUl7HKuGg7E8XjGPyiyjauMLs
	ANYm2QmiLPi++42uvSGd8bSVMg0s8C/vP4JbiaXPyVQifKU=
X-Google-Smtp-Source: AGHT+IGVtf89pkxJBQnHkIvMa5c5+fKBhgVKo/JJ9GqR/nbttBuKODGJ8fajL/+CqsHVRYTyZbU+tg==
X-Received: by 2002:a05:600c:3b02:b0:43c:ee3f:2c3 with SMTP id 5b1f17b1804b1-442f20bae1emr25599145e9.7.1747222873501;
        Wed, 14 May 2025 04:41:13 -0700 (PDT)
Received: from gmail.com ([213.157.19.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f397926asm26770195e9.36.2025.05.14.04.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 04:41:12 -0700 (PDT)
Date: Wed, 14 May 2025 13:41:11 +0200
From: Paolo Pisati <p.pisati@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH v4 0/2] m68k: pata_cswarp: Add Amiga cslab ata support
Message-ID: <aCSBV_L-NcNX4n7G@akinoame>
References: <20250325155613.352680-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325155613.352680-1-p.pisati@gmail.com>

On Tue, Mar 25, 2025 at 04:56:11PM +0100, Paolo Pisati wrote:
> Here is a driver (and the subsequent defconfig change) for the pata/CF socket in
> the CS-Lab Warp series of Amiga boards.
> 
> Changes in v4:
>  - refactor pata_cswarp_data_xfer()
>  - ioremap WARP_OFFSET_ATA region
> 
> Changes in v3:
>  - suppress a comment
>  - properly return ata_host_activate() error code
> 
> Change in v2:
>  - fix style, remove duplicate swap macro, driver version, etc
>  - rework the zorro attach mechanism
>  - remove the unnecessary zorro ids refactor
 
Gentle ping about this one: can i get an ACK or a NACK?

Thanks.
-- 
bye,
p.
