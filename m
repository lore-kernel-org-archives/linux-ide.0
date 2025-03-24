Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D4225E469
	for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 12:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742817779; cv=none; b=cCS+3ooimWSvcipKr0LVrKDMiyTf8q8jQgLYv8lqyhNc8O5B+7L9mTklzGgf7A4V/CmiQFYxYA15HYofjD4y9Ukr0QmGuLq/+NGdLRGLj8+7iSjqG15kP/DP5emkF0CTgyUmtpV+lN2FGkIBmd4o61uWI2pyLFaxt5ywLZ0q054=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742817779; c=relaxed/simple;
	bh=FEELsc+xwThvLoMBMuRuxxISfKrU7ZgpIA5jdXNoaG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWBlLfoedWD4oH7lx8GLi/La3USfE5vgi5PMTSfYvrtd57K6Ce5Z6YRX8XSoOFaTOOwd5P3x2y/gBaANviuqkeWCu+Owjx+Tk07TysCtJEBbs59FHU2gt5bioFSZB+pxeuYZAZaxUQkyiXzNHisudY66qVL4Xgelv46OI3/fT+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cARur/kI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cARur/kI"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so32179075e9.1
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 05:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742817776; x=1743422576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4akC+OE/V18+0Ds7y+PLOH+odBGH6DeU4C0bDZQdAs=;
        b=cARur/kIuLP0CIGDkP3OzuGzDPBmIiDJ4CeB6muak3PhmiRVbMbDueQVJq+Ktli5mw
         IZ8Kd33xkG1QFZ79065rV/ms7M4bS7soWFTDG0OAS3+uBgUF4ee837jb8K2nAlhI3zMy
         7PmA9XDpTWR8Bn/uaKxoAWX7qkod0IfiVjNiMJv7qA+5nI73SfR2haoQJEzjIi9iXV5q
         YGLa5qd562PAm5VRinmeEkcT1ogo5QrGyJmLmYfCKPxs2DNj+RZnYLnKe6j5nCXbJz1D
         r3WbMi44SzwMJvZVdBqpRDmwvNzwe47TQ81JjluiMorQSR20Rq4TW8xFstEuGwHx/VXd
         SdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742817776; x=1743422576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4akC+OE/V18+0Ds7y+PLOH+odBGH6DeU4C0bDZQdAs=;
        b=Po1Iq4yGexI+9L7ZVy0q40EHWQ7FXxIjVSduVrr4fMt+AW5BsHG6BjAFQ/yPY+U343
         LcgEzj9HCzNhVO6of5rQdESi8z0WorFe6VHxNOOSI03tsWdIaEWkKqRP67V4GtkZ6lLx
         i9H9xQTWA47MIQidUJ+3I56qLe2S8NL6yY6qeA+gF3PTsmjB8mZXAkrSTYtUuAdosPuE
         Tj4tZswmo4gzi78SV+mgQbAi8FYwbGrKWGWxksrV2WVwAq9ARO5t3zNhkjM9ljM3Pz5G
         zZKKlnKLa7xcC//IV6x+RpSSCWT6HgoPSFw90da/Bi54LwmPZHa5x9xvQxG1PQoIHQ4f
         vP+A==
X-Forwarded-Encrypted: i=1; AJvYcCV0+xuJopBEP3yc9zex5eGxL3r5h2KYUhVnDK8N+1435ejDV/y1mnRP1jS2bCR0Ebii6RtcoA+dg7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5oo9qTHZOChLDAWA0rSGPO4opJB9vLjbC78gmsonZ3uB7igh9
	hp4CHRnFVudg6j+40V30H2TEEtT/IkWOnmSZrW4mMqx3OM08KK9O
X-Gm-Gg: ASbGncvOzZ69qM7LqcwoUxEtycRq0qKZvwnxmx0QzlIgMtuBongnUsCd6POYRp+uW0A
	emVXu9YvphN+u5r4EVAO3bcHKlNesXl/F9OLCiXaeeK6he/EpnMeizANWqz/u+iz+HG3tAIIEYQ
	mDxNZxJyoQzyJQwx2glBusUbCgjwCEcxoRq6sCHMLaKEkReBgoWmEB9vwPujzELdc1jaaRGoLSH
	ix80Ks3YHWEy2ya9+P5DbK7iPA3ladw1DMYgGQ7nRzhfI1Y6tuqO0nnFbxHd1hvM6c7kzbrLEBr
	ix3CGB61cgnguGVk3m+WIPe+GM3DdFKVZ5DbQqK4oyf6nZLlCuGWxg==
X-Google-Smtp-Source: AGHT+IEy5hkQSrWaXlMErAFYM7j9pi0vrafE9+qzG+rQptrMzz86XaBSW22qUN0n6ekkJhhoPp0fcQ==
X-Received: by 2002:a05:600c:b94:b0:43c:ec4c:25b1 with SMTP id 5b1f17b1804b1-43d50a21273mr109713525e9.23.1742817775591;
        Mon, 24 Mar 2025 05:02:55 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:fd58:9303:2c1b:4279])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd277c9sm121085865e9.22.2025.03.24.05.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:02:54 -0700 (PDT)
Date: Mon, 24 Mar 2025 13:02:54 +0100
From: Paolo Pisati <p.pisati@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Paolo Pisati <p.pisati@gmail.com>, Niklas Cassel <cassel@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH v2 2/2] ata: pata_cswarp: Add Amiga cslab ata support
Message-ID: <Z+FJ7pB8uWFqNBW+@amaterasu.local>
References: <20250324092409.99430-1-p.pisati@gmail.com>
 <20250324092409.99430-3-p.pisati@gmail.com>
 <60c4bdf5-9c6f-40d9-b7b9-2fbfde6fdfd1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60c4bdf5-9c6f-40d9-b7b9-2fbfde6fdfd1@kernel.org>

On Mon, Mar 24, 2025 at 07:00:47AM -0400, Damien Le Moal wrote:
> > +	ata_port_desc(ap, "  cmd 0x%lx ctl 0x%lx", (unsigned long)base,
> > +		      (unsigned long)ap->ioaddr.ctl_addr);
> > +
> > +	ata_host_activate(host, 0, NULL,
> > +			  IRQF_SHARED, &pata_cswarp_sht);
> 
> 	return ata_host_activate(host, 0, NULL,
> 				 IRQF_SHARED, &pata_cswarp_sht);
> 
> so that errors are properly reported.

Ack, will send a v3 and reorder the patches.
-- 
bye,
p.
