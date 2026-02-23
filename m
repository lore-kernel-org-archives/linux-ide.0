Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2353382FB
	for <linux-ide@vger.kernel.org>; Mon, 23 Feb 2026 17:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868961; cv=none; b=hwJXtbTEOcvRl4QnEARY5p4eLqMBAhe2XQyRaANiF83DBmjs8qXICyrzIgSeYclK2GsmlJCu1YaRFwrpCNgVYLHUfC7cW6iQhRLiqk1SjWLg2y+JSgJsLAaYORqJIdv0VkIA8TvGaO4BsLFFbB93IyiktOIVXSm1lpsTlaEJ8KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868961; c=relaxed/simple;
	bh=zCsFPsi15Sesq/YfFE4D4Mrator93hTrxesIxYFXAik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9DZfl1Y48I8R3tsoxLPlXHv6m4QniiYfHNRW+fpHyN4EvSXtXHhTNlEZy7cz0K/bXH37PwwGRC26wmLPwzZyPTtC8Ta7n6XPWydt+WUt5O9GWGW7iF3W1J91Io9PT2Bi7dKznvoj7L5wjZFNgRHsMhR+hEfoQTie5Toorqgor8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ctGdLzdN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ctGdLzdN"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a76b39587aso2205ad.0
        for <linux-ide@vger.kernel.org>; Mon, 23 Feb 2026 09:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771868959; x=1772473759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=82hla+jnnTAa0JZoUXn9Fn/EcoC2SOr4qF0PvF/CMsc=;
        b=ctGdLzdNXv+DsSyeMP5oWdWrXwrC8aeTDgvDco3eBQurn07MJd4UtHZZHPFNjVtaLk
         ZNI6xk9n8IAqgvTAhfXJtDB1GhdkFsajNaQI+yj8+TpnYlNqbA4a4IRBXR1FlrLfnlsu
         svRR6RLw8U3IRDzylIn+ShcpMr67xzHUQGjSVOifMMIlqgiOUz7zXvkzHflsDrdtHlaG
         e+wB+ILbJqrNVYAfDzGHlI20J4oS08ewnYMbklvLaFeVAtne3yrDpeeZHRgaqYnpYRmR
         8agPhfY5/gFCzYSH/2UuW0omuaLCUCRsTiNrShJTWrNpo+44nNZcOHVvmRKAmeT4XfPB
         8iAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771868959; x=1772473759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82hla+jnnTAa0JZoUXn9Fn/EcoC2SOr4qF0PvF/CMsc=;
        b=FHG9afXLf9CCkRyUf15nKGt8K3QMTfTfBEfXCrqZQ3+V5eMoGRi2dCfKesptqMlGym
         5YzxKGgpac4rMu6XCIb+W/eeNYX10Hf2mD+lLWVjSgIaX+upGGIUbJIxdw5+Q5MqBZSi
         LAzfGnadB2TGuA2nSh0iUgoybSaIn6UPpvTnkcH1rzghc9iYeo03wr92lI4wDYuT68KK
         mJrpPUZmeyqmezjVwvSGCS/iQyRsCoUcrLxO1UNHRhCs/MBEVKpVNrim3ZG3DnJ/ojB8
         D1/+DstHTedNRHFfsjUn0n2B/in9TvKgRtg5vnjHqa2Fb5e6CYsMcIQ3MCMhoMis6i12
         dYQA==
X-Gm-Message-State: AOJu0YxLC0j7aHt8G+EF0yTWIFpL9Pdb6hSL7yUZ+1a41zSHKVSANT+o
	8gJCVEZZkAD7/dWu9skkHxKgXk8eq8VHLs3K6od5pDGJj4dmTOmtMAMtBI0f7mL8uQ==
X-Gm-Gg: ATEYQzwO3sLRraycf0H+t8OBEoQKUveKqha9rjgVJL+XvW3M8WtXo1MkG28FpgC5fxk
	Ttsnf2G/iCbUu5Zwg9TARH8zRveNl33ArlsPN6m/6aibZt0a1r1wF+FeTee8do4WtWYpAaKltix
	raTa8uL+9Gnsr7acPHj86/x/3QFsTv9t++rwb11aOtd2Z9swIohDDk/W7/zg8bCEeOlXdWxRZ9Z
	mwfz3riecg+0Xp/FZwJBoqTO47xQl9FtblIH0GYRQP6RjxM07skae5RVMVHHjop64+lpxwYqFvY
	HkFdh+BlWbw38b0tH0aPx9uhCK7VBY8iSek6Le6CTinKf1sP/ZUozAe12aQ9a/zjv/8HHQ4El6E
	GzeNogi9OOqJz0WlXLVbOTLd2D8tWzkwAgn9v/iUBWDtUK/j9lwR7Hi3p1bnlW7MmZOt/S15Zzp
	xZmHAI9zUjLJ0QASZ6cVmoQjNfYWf7p9Qt+BNIyj1XEJjVUDGE9cBqdXV3iZg=
X-Received: by 2002:a17:903:15ce:b0:2a0:89b0:71d7 with SMTP id d9443c01a7336-2ad75d5c85bmr2738945ad.13.1771868958611;
        Mon, 23 Feb 2026 09:49:18 -0800 (PST)
Received: from google.com (33.75.230.35.bc.googleusercontent.com. [35.230.75.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3589d81cdbfsm14983853a91.7.2026.02.23.09.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:49:18 -0800 (PST)
Date: Mon, 23 Feb 2026 09:49:14 -0800
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v2 2/2] ata: libata-core: fix cancellation of a port
 deferred qc work
Message-ID: <aZyTGlcNJudRfd2v@google.com>
References: <20260220221439.533771-1-dlemoal@kernel.org>
 <20260220221439.533771-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220221439.533771-3-dlemoal@kernel.org>

On Sat, Feb 21, 2026 at 07:14:39AM +0900, Damien Le Moal wrote:
> cancel_work_sync() is a sleeping function so it cannot be called with
> the spin lock of a port being held. Move the call to this function in
> ata_port_detach() after EH completes, with the port lock released,
> together with other work cancellation calls.
> 
> Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>

Thanks,
Igor
