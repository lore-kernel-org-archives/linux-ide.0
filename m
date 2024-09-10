Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB15D1A4B6E
	for <linux-ide@vger.kernel.org>; Tue, 10 Sep 2024 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994032; cv=none; b=b8G7OLu0s70Xi6jXPjW59VEcLzg/bjMJDlf0lCXVIgZ7rWx9nRi1Sx1cW1JJjFlccX7+R2WIxo7FHM7OaJtdhKwFfSBcVlsoU58xwKDRAuT3mE3FmB3HOXZ81q50Cb8H4Hu9hukJY8KpuD28maKfrgfeH0mfGAsHqqwOZZhoNFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994032; c=relaxed/simple;
	bh=y6+jU1nkaFCJb5CtmFh3MI53xVH1yh3eKGITi0k/9LU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auLll5OIR3MBOk+61LkMIvWsCS3lp99CTXOmNuhKWVs5dfbtuBCeBeqO4rNbXLhIWdjOPrPOq+msdJc8kYvZRpUkJcU1z5y6f6rJ+lKs0AjnaD0CIOlc4t2xdleH4BSwl060IDcT+ryMNHfvXwVOqbjSjtb4580/RJ2sLQRYnm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dt7R/5Gy; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dt7R/5Gy"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso10191299e87.2
        for <linux-ide@vger.kernel.org>; Tue, 10 Sep 2024 11:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725994029; x=1726598829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LPcgYLqFkVUYW17im6jAp29G4Hv8TcuOuscbjSMgOgo=;
        b=Dt7R/5GyZqQ5wA8zQTpIAH2C8c8FoRtpfzIk1YzIhSiNz0k8f0hW9OPF61Kr/Z4KF2
         5qh1Xk5QimVNRBnrAKDMl+veC55+A0NerxsSsmQKDCFH/fXdlHIc66f6oLa43Lw2t8YK
         pSaNNKFGMS++agXg4iFe3CIEdDAGqIY2pp6YQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725994029; x=1726598829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPcgYLqFkVUYW17im6jAp29G4Hv8TcuOuscbjSMgOgo=;
        b=Chh9E7M3dudj7YQIYQPXAbslrroRl1Lyye+fHckOHuepQXGgUnWUcuIdV2l+VP/9+K
         ldbjXByc55EhqPH6XOmzct8Wj46vhWJju9YKcaV3ONzCGrLho3Qs1Ba3LykAjST8NbQl
         /US+lJnO4sQ+XxYbO58X/vxoZPDBT2sAYGv6oIWa04gVqaTeg1+1xjULqn7P/7+rR1lJ
         EbRSpRSryDavsyKD1ZI32uJ6xO242DXuM5KOUprmCitrxqySl+3BhCqZqW4aE/MCKW0/
         nyVYfJu8MVMYA32+qeN3T5Ju5Ea2EEK+Ehc7HXGdKpARWmRkEMwckCxHbUEB35tFHcJF
         l2Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXzHUOuBTI2jAvVYP2K8AHin4kYZ8sk+LKCEltGEka7yKBcDJSyOQ5U0Q6TLBqruQTJz3nZcFJ67XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqtxp1+vkE20Hr0FCc7AzAg8xoHOv22C7YfDf8PDVNXdpbBZRN
	TUaK1N0p7vsAqKRG2v3Pem3Gal39bvKcfCRc1eoBWHOTWV25QOXk9Q6FBpH1OYHJZNqMYo0jYlr
	zj2KrxQ==
X-Google-Smtp-Source: AGHT+IGngEnZ+eGIH3sauVHKUfnWOUhQMVF3VHFrXuiJDOnoDpc8j2WfNzVp5WICNUcgau3yvg6v5A==
X-Received: by 2002:a05:6512:b03:b0:535:6a34:b8c3 with SMTP id 2adb3069b0e04-536587a6800mr15070765e87.5.1725994028560;
        Tue, 10 Sep 2024 11:47:08 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25cec10asm511579166b.160.2024.09.10.11.47.07
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 11:47:07 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8a837cec81so283570866b.2
        for <linux-ide@vger.kernel.org>; Tue, 10 Sep 2024 11:47:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqhMqvmgrewssqXkaqpdTfzDSlJqzW5pHX9lU/mWPh5JgsreUkf78qIc9crgWcYXQaznXC28bywPE=@vger.kernel.org
X-Received: by 2002:a05:6402:26c9:b0:5c0:8eb1:2800 with SMTP id
 4fb4d7f45d1cf-5c3dc78b469mr11458506a12.11.1725994026812; Tue, 10 Sep 2024
 11:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0a43155c-b56d-4f85-bb46-dce2a4e5af59@kernel.org>
 <d2c82922-675e-470f-a4d3-d24c4aecf2e8@kernel.org> <ee565fda-b230-4fb3-8122-e0a9248ef1d1@kernel.org>
 <7fedb8c2-931f-406b-b46e-83bf3f452136@kernel.org> <c9096ee9-0297-4ae3-9d15-5d314cb4f96f@kernel.dk>
In-Reply-To: <c9096ee9-0297-4ae3-9d15-5d314cb4f96f@kernel.dk>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 10 Sep 2024 11:46:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6o-GwyT=7nEfmHKz0FcipfSQwV9ii1Oc1rarMTUZDjQ@mail.gmail.com>
Message-ID: <CAHk-=wj6o-GwyT=7nEfmHKz0FcipfSQwV9ii1Oc1rarMTUZDjQ@mail.gmail.com>
Subject: Re: Regression v6.11 booting cannot mount harddisks (xfs)
To: Jens Axboe <axboe@kernel.dk>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Netdev <netdev@vger.kernel.org>, linux-ide@vger.kernel.org, cassel@kernel.org, 
	handan.babu@oracle.com, djwong@kernel.org, 
	Linux-XFS <linux-xfs@vger.kernel.org>, hdegoede@redhat.com, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Sept 2024 at 11:38, Jens Axboe <axboe@kernel.dk> wrote:
>
> Curious, does your init scripts attempt to load a modular scheduler
> for your root drive?

Ahh, that sounds more likely than my idea.

               Linus
