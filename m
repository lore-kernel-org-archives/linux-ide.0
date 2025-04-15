Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CF521E097
	for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2025 18:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744740311; cv=none; b=JXBf1WSizg58V9sHRgiME2JXKa/5Y0C0bAUnrkQkOGpaufarVSJQn0Y9sDgf26LRyX3rcqsdk5kM05jvGsVVAviTZlkbZMDE197VrNxfxmSM67MadK3pC1P39pnhxfc0XS6NURIv8t0QeGWD6SU7kqptqRLBhZ6yn7sKLAXH9U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744740311; c=relaxed/simple;
	bh=YcuHIKfq0aZ5FQjSXwqQWBJcujLVaOEdCCIlwjaV2lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meYvQNhH9gKmMLlnLZSFB6pq/SXgt051DEfcgSlS0kcKEan7L8rnj98bxtYcCgXsBsHn5b+Q47xXE76pD97uyxW2w3DHYQ5B4TgAjI39eXgNGL3QBNl8j1Hxn4PUoWFgpfa79z1rS8vZyIAjSxAr3HSmybv9/IpojoUDmfD7/70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SOzJPq1N; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SOzJPq1N"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2264c9d0295so26155ad.0
        for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2025 11:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744740309; x=1745345109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lkkBDEMu3ClPVlV02k6xSb6QkvNhpwkTDj/2dcO/xeU=;
        b=SOzJPq1Ni/MI4QoUh5s/jw4Zch9uGHMrIoLQRmmTvHrzRfrfETlXrLsiZb3lw+7cuw
         ElfnOnBeOZm2rgcUrakKK2uoj4L8JHDQ9nKCEjAbQRKK3vCyrd3CNaa5FpraLu6+8xl5
         j9w1IQ8WPgcfj6g0axBdas6YzkVrS3l3DxsQdvNV0tZp+nFVSrbflSTcb1mbFmGgeGf/
         oIJhSoWWenUJVroHAhnsuk5ZQiHVQnBbmFWrI+7F1VLbKzry2jb+OeOSgXdhvUtNmbk8
         d6Y5sVmm2V023X94Cx5isEMHdDg6VDKBhrlNWK2gl2fkkmaB65P8hxcvbA60TiosmbT/
         T8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744740309; x=1745345109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkkBDEMu3ClPVlV02k6xSb6QkvNhpwkTDj/2dcO/xeU=;
        b=VId8ZoX6DC2I+0tARYP3ut9YfWQrnSY2sZx7DoyE3iGBHtnxvih9CdryYIsws84Xp5
         R+wk+Kf6DCg7RxAQL1J5aT6iNEGDmUJ1J12ja5/dXL/ZpLbj+O6TqKn5mbnDYI8ZHklO
         +MPNIlVfOyaRIbGfimjtbTolJiUvcwEAbaNMAEqWBxaNH8IHUfkfrTrfzTioLX1mG6lQ
         JA/5U6Sg/8lWb4PS8HQsn3haSawOxFS8P+uwdG9lLwcwdeSDFF193BZqoU/caXIqCWy/
         qy8DuU3MMhpaAVhE7PCFEGzl5vvzprICfnDkVK7UlmX1SkhDBRo7DXM0HLeWyaC1M3O+
         KoRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAekbcg41TgkhvJk+isHkLmfRyDnaiPWs2kSaqiV23j/6LgtdbJNNqNG+8xE4uX4gId/znJUIuI+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4GqaJHOHKtI+FA1mxbT4ctn/qAtXzhtdbpMPQDlWiOpZGTuR6
	AYqX5gVqKunhYztp9Wwb+sloS1jxlhuD9Y1qkGkZuIx9qYaE018bnNdCr/V8Tg==
X-Gm-Gg: ASbGncvzPzJT6ZfJ8JnCUbIm3dHldXJBD8tAmom1xKKLSXy5rV6GJk2UPGS+QF4gECT
	MGffkXD1YuBCtlVMN2tGkg+CvTdx3LMIEHzAch/OU0vwZnn/AgpVn2D1wV5KmrPaUzKld6E7sq0
	2ov7PmXojjZ4Pi3ygG72AER8r5MKzIzGVzRSuE7KF5tNiPIqTQK6BpQRqhdJ6QA8FS2PkB4mmX4
	9fjsQVf5l8hCDbywrwH75TsfVUCpBS5GLWBWYUdW0AtHsDm2nVROdrVkw9rG25KVn5uXDzs++SU
	uGm/buVL2iYlvp6yn1lw9rjS6DWMma66JBgFCuFSFbw2J4GsMQdUnzZFmjB8rmnZm34qYTI+IrR
	g
X-Google-Smtp-Source: AGHT+IFInNsVMzJBd8UCPD/uyCnBKsXkqn4AGumDbjEnrYw7Qxqltc7O0EawSFchVRqzPsc1jFZTJQ==
X-Received: by 2002:a17:902:ccc8:b0:21d:dba1:dd72 with SMTP id d9443c01a7336-22c31bd357fmr45425ad.15.1744740308648;
        Tue, 15 Apr 2025 11:05:08 -0700 (PDT)
Received: from google.com (24.21.230.35.bc.googleusercontent.com. [35.230.21.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df2fb0bcsm13539895a91.36.2025.04.15.11.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 11:05:07 -0700 (PDT)
Date: Tue, 15 Apr 2025 11:05:03 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 3/3] ata: libata-sata: Use BIT() macro
Message-ID: <Z_6fz6kKim5upPtj@google.com>
References: <20250415073013.414987-5-cassel@kernel.org>
 <20250415073013.414987-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415073013.414987-8-cassel@kernel.org>

On Tue, Apr 15, 2025 at 09:30:17AM +0200, Niklas Cassel wrote:
> The BIT() macro is commonly used in the kernel.
> Make use of it when converting a tag, fetched from the Successful NCQ
> Commands log or the NCQ Command Error log, to a bit field.
> This makes the code easier to read.
> 
> Suggested-by: Igor Pylypiv <ipylypiv@google.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>

Thanks!
