Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFEC1A3144
	for <linux-ide@vger.kernel.org>; Mon, 14 Apr 2025 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744653112; cv=none; b=KnK/Q+/Y97kIOw5vTIfhYoVR4eJn25GoWQOrG6wEDecK8jeeqU8YuyHs7KkSqcfiJ7VU8LvRFe6+bWwlyu6mbUkAx9TTNeI9ZrBdQvOWZv9IuOGKMrzAJoMP4V2jXtugcXJCdIRta/n9nONnvQF+X8RKFKQicDo8CaHZT4OGk30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744653112; c=relaxed/simple;
	bh=BV5BU6EQDMbJFZ3kvs+3pazGV0S6CYLECQN1BQ+p/QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHA/7A4za4YbLJ/59bdF4YNaU70B6WyowJwXpnm+bX7mW9YEGB7xXRZ9IJ2iFLzjFtbghpnQ36IXkEYxK62Q+OKYI+xFkCOy+YyxDBzJ2GHAIyqgt6LGqQJ1EGAI44rZcSeylRIFE/KHHs5ikqf+Bp/glaEjdfqKX7QEHCoAc8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rgd2xvvH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rgd2xvvH"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2264c9d0295so19055ad.0
        for <linux-ide@vger.kernel.org>; Mon, 14 Apr 2025 10:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744653110; x=1745257910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0K2oEUSm864yP2LOR410S7OsyyGr0zSKSGoza/LmhqE=;
        b=rgd2xvvHLCABuBFLYnnhhkcWIAPDlDaXhrzZ9TMDExxLfPzlxfe5kdoDKWG2eHjNMT
         0mw5GjzMcvkgR7Vb16N+jZdTN6eDxhX4/xZItsba92aReZZBnocYu+Eb0w2lXV8th1Du
         0FcOLG5NOvcKbTyfZtSh6XaNs3TgHcBXa1ZfCqLwv+ra6b96gKOC2veKKMcQRtmXT0p0
         Q3OkAmk067QN1fS3F/9rKXwRSjOIE4vr6k9VQnUE7uGqI08I/gw8T4AZBWbdyj802PC/
         5CWebxnAFN5z3jRzzvDi9982Z2XjjpdtvyYAbA9IsW0Y/TDsU3Pu44p+q5MvrRkespqM
         P3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744653110; x=1745257910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0K2oEUSm864yP2LOR410S7OsyyGr0zSKSGoza/LmhqE=;
        b=flDT3xF8uGM1XKNlTfjOfUgc4f9DkkTuzqJMWu9p7LVnpwoCsGiuUIJc3eQ/qAlMOy
         8cRB0VLkiABSm0iouSWmo72rUMXcXvi4gp3pzVUFRbw94RK0Fc28+QGJp4P63tr9D3Rj
         SkdYyln4AzIE6e/55npTA5sYn6L2FmDyRGz9Lkf4Xb//Ycs62vQQbsqPwOIxr6DL/1nQ
         SSWMzOTcHpPvlNBgRiW7bcB7tOyU84bg2EPAyWPAu2zCh4GhEOcU+S4SKcHFN/HpeMSV
         g4eYvvoUY7zl6Omj+87OZngNNLk8JdJKYB5GTU3cCiX4j79YBc9xif9ln1xP/FoPcbQJ
         GoUg==
X-Forwarded-Encrypted: i=1; AJvYcCUWQGl38Hq3bnzvj4SXDEAlALH6vSBShg/fhzJFeLi5nqr4u8YGfrnq64ijlemXduSA9/EyHaSjCRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+lEHPRWDaF2RNatVUeB/qDlvsS2cadCLc5px1wp+2SFmCJxPZ
	6FEDfNxUr++ZuSnX8cjDY6yxLAd3218LfewjLtVimml3y9l4JLQrpZb3gDO9EcygYaEPbx6tLWI
	BuQ==
X-Gm-Gg: ASbGnct7IllAOAqtYZiUWNy11gvkPA+kO9pblRiTo+341dIVS/QggFUBRfLtf4umjXU
	iftJb+sP7y48mG1vVBpsgeVsbSzFjGKCPC2s/IWoepwHDwW1r+4cEyTjVLb/djVZpiXljik12Hw
	6WJCgb51+nck8uVwU+9HyzgtO8xZQm9lka4IBLBCcRz7txQ4bK5DNg7cp5rsT6ghJacXOVhqfIx
	UYKHjli/jwVv64ym0IxD8VTldf1sLgFBXcU6d6Pi5H93jxVxzB7xK5TiP/2NvCraAqvXXe7QORG
	RQ7P1ZyH2DPxSxUMMly6VaqEXGiOu4szi8hBeCQEoOcMdjbQTDIfXp/KX5AqE4znP0QmuVtCUps
	J
X-Google-Smtp-Source: AGHT+IGimhsEGw0sIl3y7lifNesAPTovf00pwlMqn6VmduDZAsjzIrjTYV9eavlutpQPiK/qoohagA==
X-Received: by 2002:a17:902:ccca:b0:223:ff93:322f with SMTP id d9443c01a7336-22c25196aa9mr148565ad.2.1744653109669;
        Mon, 14 Apr 2025 10:51:49 -0700 (PDT)
Received: from google.com (24.21.230.35.bc.googleusercontent.com. [35.230.21.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8a8b9sm101852225ad.57.2025.04.14.10.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 10:51:48 -0700 (PDT)
Date: Mon, 14 Apr 2025 10:51:40 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH 1/2] ata: libata-sata: Save all fields from sense data
 descriptor
Message-ID: <Z_1LLFOr_F5Qur9R@google.com>
References: <20250411132522.126316-3-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411132522.126316-3-cassel@kernel.org>

On Fri, Apr 11, 2025 at 03:25:23PM +0200, Niklas Cassel wrote:
> When filling the taskfile result for a successful NCQ command, we use
> the SDB FIS from the FIS Receive Area, see e.g. ahci_qc_ncq_fill_rtf().
> 
> However, the SDB FIS only has fields STATUS and ERROR.
> 
> For a successful NCQ command that has sense data, we will have a
> successful sense data descriptor, in the Sense Data for Successful NCQ
> Commands log.
> 
> Since we have access to additional taskfile result fields, fill in these
> additional fields in qc->result_tf.
> 
> This matches how for failing/aborted NCQ commands, we will use e.g.
> ahci_qc_fill_rtf() to fill in some fields, but then for the command that
> actually caused the NCQ error, we will use ata_eh_read_log_10h(), which
> provides additional fields, saving additional fields/overriding the
> qc->result_tf that was fetched using ahci_qc_fill_rtf().
> 
> Fixes: 18bd7718b5c4 ("scsi: ata: libata: Handle completion of CDL commands using policy 0xD")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>

Thanks,
Igor
