Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBE921883C
	for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2025 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744740244; cv=none; b=RMBnQ+UGSSo8iiUL2hY32aj23lBOl7b5TZNNljNIibo/xzS4Zn0U1W9GsD3NQQp8X4ke8l3KqeWd+y4/VQ+SZPRkpHIWmNrfdx9bsYlhQowjASFegkFw9Y7KBF/ivTnDGTEwM5chEOTdHjcvaCgbyYp7TEG5iSRcralCA/BZUJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744740244; c=relaxed/simple;
	bh=wOCrRkHubym7IKs5I+04VQPvDY70ptHb1RCTzXYz3Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVgmNdDvfKtR8vEfzw+yftWDQX4OqPvnbL9bnuJ9/tzuEtWg1QA2SxPGLwWsVx4CVoS3dFJ5bvnMMojLnZMDxTHQVPRj/Vp3BhKDSh5/52ePwwYrtV9HnJdxGwLTQmScZDy8xvP0YhpruLogpHbOICQIqzx9wRVeY5PvO4ov9fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WjczA1Sb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WjczA1Sb"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2264c9d0295so25725ad.0
        for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2025 11:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744740242; x=1745345042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=65U1OJDd5z4gnvZn4OFYO2gVhpQmaCHeDffOYxstFNQ=;
        b=WjczA1SbRqFn+VU2BJYWOuG/gKmq0sS4WXkMMU9ViF6+BCmKm3xq5Y/beFadiJ35HL
         x0Kshys063aS6/LCzL+C1gkaC0t3Gj8qWihmqebZ0rQ/rf68ALfAdxlWcQaGkvflLf4X
         vBz+Te9F8emJYPmiBfm9hij72zzsfx9hTVoMOsHFSXgUhzKStO1S1eq+LmVmpPKzHwI2
         fPERInOlu5D4grnxSTDF/oPXr+SbgFWBvxAjqJ+4SA8YZri286VTJg9TC7kJ/zVQUzf9
         RRLb3uUSl2tDS7Z17MceHIKdKVnXUejmiWLuxc2hatKlYVnIcuoWz5zzgupFuJeqjtzD
         G9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744740242; x=1745345042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65U1OJDd5z4gnvZn4OFYO2gVhpQmaCHeDffOYxstFNQ=;
        b=U96jUdYWMRO8AF0LHYApbK6kp9oKvYS4AeGzPAza4xLOjdTZrbG5FeUfgklEbK1hm1
         TNm+YleZIcH95AnnCvGcKLIoGSWOxldlHAqxlNaxAUr/hIp5bnMancToTL3tnS55VJh3
         G8lBNLU1fVuI+t0QjgbahLTm8RE61aqjO0hPfo69EZZhwhmv2813WJWOCByExldL7AiO
         RwU8mGLoUXMwJiiWu2auTmsjpe8CBws0toa+YNlk1BDPKgd5Y0tItJVmV77vKnz9u2xW
         wlR9IrPotkvrSU/EVQJ0izYewaVjQlUrsvP3bVn51tNLES+zVtX3RMgS2zbDspZqOpBp
         BPNw==
X-Forwarded-Encrypted: i=1; AJvYcCV9aHlsAJ9NkQlBIw050tlSgLbEeopXFaM1IzHG9oj+mLZBAzUO15as9JosSQGBGXHV862hQcLiHSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7M/gyCCkaWSm3iqTjBs05gHZPq5FzOXP8LUy1/eDSIHl18XmV
	+377aC3z6PWgIpDWaIpDYOwIbhae1hceXMcG4+RpuwdINrhB97VWRwlFwFYwWuksfeADuaKNUHi
	pwA==
X-Gm-Gg: ASbGnctkOZc8n5ZTPUS03SJUHuu0XgoilTyRxjp0uS9/uFLUlo3NiGWmwECRtrsH7GO
	t02gSPJxWisuhiuuxVeeJ1oOX4nVGKCm+YMfMmwucV6mWQ7brCfJGyGrkSDyiWLvx2LuzOQnYZM
	NSfH8Ux72ZiM+IS9kQSFmlbbZtYX8yRNVVbOkicpy0RQlh3iuwPVGJ/2dn3l0RPnjvEV+ARfNkD
	pAb11hZlLIj2oHqJgjQJ9M0AakAskdwsjZMrjB/uejGPoMipTvr5FMSvhrz+uUjEikIEPMfqyP2
	FOSAsuVtEhdcYB9VMddGwMaLuLTbODEp5GPFTev5TMjpulPFlAgLC8dck4UWI6/MyYTUWUw5UrP
	w
X-Google-Smtp-Source: AGHT+IGRpWVkZCTIMCAHWHi7zd/6xEroEkfxdkrwI3BN+Xe2bmZJlfG3UX0RMCNXgDRrSbpNNdLe6A==
X-Received: by 2002:a17:903:1b6b:b0:223:5696:44f5 with SMTP id d9443c01a7336-22c3171e6e8mr214365ad.12.1744740241838;
        Tue, 15 Apr 2025 11:04:01 -0700 (PDT)
Received: from google.com (24.21.230.35.bc.googleusercontent.com. [35.230.21.24])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a11d298esm9458505a12.34.2025.04.15.11.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 11:04:00 -0700 (PDT)
Date: Tue, 15 Apr 2025 11:03:56 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 2/3] ata: libata-sata: Simplify sense_valid fetching
Message-ID: <Z_6fjLf-g_WQkL9u@google.com>
References: <20250415073013.414987-5-cassel@kernel.org>
 <20250415073013.414987-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415073013.414987-7-cassel@kernel.org>

On Tue, Apr 15, 2025 at 09:30:16AM +0200, Niklas Cassel wrote:
> While the SENSE DATA VALID field in the ACS-6 specification is 47 bits,
> we are currently only fetching 32 bits, because these are the only bits
> that we care about (these bits represent the tags (which can be 0-31)).
> 
> Thus, replace the existing logic with a simple get_unaligned_le32().
> 
> While at it, change the type of sense_valid to u32.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
