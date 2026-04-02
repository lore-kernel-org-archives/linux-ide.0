Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA3E30C35F
	for <linux-ide@vger.kernel.org>; Thu,  2 Apr 2026 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144050; cv=none; b=WFh8YGud7TY4euNm/I/2A31TjzYi0VkDShItXWSoLiwHIga7kfTbVPtaGdoFpfYNVexvclExWP+kwWJXTi1d2MnvPyPbPv3Hw/1NSSyy3b3le8oFaHVG7WTy+Nc8JxyTPIBVvueYzMglAX6UsgKcALJCh519vlItGBbWLUjJsCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144050; c=relaxed/simple;
	bh=VL4lBHVu6zmGUU9nz+PN/SJ7XueMUbcbTQXKq9IeTYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rzjoa1x39PJsR5K6LbaudDjoAMqZNHE8EbcvaZw4nt1SsdT/CfLzTRziAQxpCOiLFMe7Ta0zBlAknlBn5mI2DWXY2UGHsVVgs87u9CMaeCCoexE44vfQfd55zhj2HYSPmbpUDwidptaoeEAccMHAJe1TITuD2TqahiYIpMgN+o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FDDFR6OF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FDDFR6OF"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b0b260d309so77685ad.1
        for <linux-ide@vger.kernel.org>; Thu, 02 Apr 2026 08:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775144049; x=1775748849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ktk7xptOhNTCBPMKzgE2ARifOuymzl3kcaYnuA/xXMc=;
        b=FDDFR6OFNce6Iddws3/Dt00EL/gx4rN5tVSAXjCF18GV8w1xcfo9NSCeg4sLkT0+YE
         I48wKaH4dY1nmQHbaqBlNtCIDLOxHSOowdOi0dfUVTyONsuD1tk+VLP1SAI5aAQqF4Qd
         su9c2dfszjo4ycpoSctih73hI6qVx46PTRYzheLP4HVrXN2QO27LN4hxpBxE0o4HPyMe
         /ZaMFswAXZ+Yfk+h8vebFMiGRIAaHf9MOQuTYBl9z3P2yqVKfb48o+F6yreIWsa9rYcc
         hcEGzx1dvsbYHyI2dZ/n2BSdFApb5BWV6PzQUUF5YrTNWZKuZdCk7rPp3FgfrxX7b0nR
         d7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775144049; x=1775748849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ktk7xptOhNTCBPMKzgE2ARifOuymzl3kcaYnuA/xXMc=;
        b=k4kz6FLiQLIEh2h//G41rNdh/w1QNUV1eM4NcMMkQJKXx9iCD1AnjylngMdwDc3rre
         EhoVJElYVi1UkXo59OEswZkusyQoSrhjfcjT2V0ouucCziyen39TFdjA5nFktRtF8thi
         +ELMk5YY29lVHhcnZSBl2qpDYi4zJrLYNE8jNk0Je9uaApzfNWuFZ5J5AxaDOybMi+ue
         ATpXebcHo8LeQh1Dthmz9Yobsx09he/PGTOD27FcTYWpOmjLzqKp5xW763v+i3HzCfKq
         s8CEAhMR4aJqIBwLr1bbfF/w/D/tkGNHYXGkJ4zPiakU3ugGO7VkFqtanLddqNGKa4Ub
         +4rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCwfVmtpR217+VY1WGXwoEhvRkAGpQsoF4/jZnnLn8Y6oCKg/KLe6btRWPGcWewC0f1j1Iju9vD+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGC7jwmtp4jOzNVMxw9UwxO1qrRsl++5/0IPi96/gKlDaR6aNV
	6ZntnF46BcsaCGnfFypMrkAQYUAhkHQjBNAgr1LAwvS9J44wWtsPo6ebjAY435VH8g==
X-Gm-Gg: AeBDiesRpf24lwG+2kPK+z+9Ew4IWdP3TFQZIdyrUOiZXGahLqJ1FgjWdmDs52vOor/
	uDkbeVkaK4m+/EhPhhRtVvkGf+EVwj02Z+U56uvyzWFsQo6sH2+e4PeVxl5mHDU7qMY/QLqS2Kl
	1heV6gbD30SRgutp8YKEg/SPw7N5x8lgA4tJ6ETrtpYj9cnWnozqaEMMYghNOYhb9ydrcdXvbV5
	8mgAvZVD53e5M8Mp/jpmmMjzM797wEad4P5tvuchyDhFtdEOkBQlBl7z/rjphjYjO9+V1BZHSdj
	+QjorILq0Nr499pkzmuaEgOynU9vLcGyBHM27seuSNoTVZIzHdpZXvFmaeuTpf5ZAeyRmd+n8Bw
	9LNOkTcYgDiUkDzWJDj/CofJw0W1njoGQLklooN5RV492i31xdGjnImepQIXx3XuRcJu3TVoYve
	puwUGp1IonhCBoT7i9twdpo1oUG2TPqPlE8ZBYol4sMBIp7imWy5XikNLgQs8T/A==
X-Received: by 2002:a17:903:1ace:b0:2b0:4d40:ce18 with SMTP id d9443c01a7336-2b27858a844mr2358385ad.14.1775144048316;
        Thu, 02 Apr 2026 08:34:08 -0700 (PDT)
Received: from google.com (91.195.168.34.bc.googleusercontent.com. [34.168.195.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca75dfsm3398012b3a.60.2026.04.02.08.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 08:34:07 -0700 (PDT)
Date: Thu, 2 Apr 2026 08:34:03 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: libata-eh: Do not retry reset if the device is gone
Message-ID: <ac6MawqZxWf5_DW3@google.com>
References: <20260402011101.676267-1-ipylypiv@google.com>
 <ac4vDZVvJydch994@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac4vDZVvJydch994@ryzen>

On Thu, Apr 02, 2026 at 10:55:41AM +0200, Niklas Cassel wrote:
> On Wed, Apr 01, 2026 at 06:11:01PM -0700, Igor Pylypiv wrote:
> > If a device is hot-unplugged or otherwise disappears during error handling,
> > ata_eh_reset() may fail with -ENODEV. Currently, the error handler will
> > continue to retry the reset operation up to max_tries times.
> > 
> > Prevent unnecessary reset retries by exiting the loop early when
> > ata_eh_reset() returns -ENODEV.
> 
> ata_do_reset() ?
> 
> The loop is inside ata_eh_reset(), so it sounds a bit weird to exit
> the loop early if the function itself returns -ENODEV.
>
 
Thank you for catching this, Niklas!

Yes, it should be ata_do_reset(). I'll send a V2 to fix the function name.

Thanks,
Igor
> 
> I guess you could also write it like:
> Prevent unnecessary reset retries by exiting the loop early when
> a callee in ata_eh_reset() returns -ENODEV.
> 
> 
> Kind regards,
> Niklas
