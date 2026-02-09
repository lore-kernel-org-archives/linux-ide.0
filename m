Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3B238759C
	for <linux-ide@vger.kernel.org>; Mon,  9 Feb 2026 19:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770665514; cv=none; b=kpvCkXy+aThoNZ9xM2Ino+mHE6VGeDF0kV2KVKg8bAyYrHW1YBu0LAynb0Y5fAeQCAA+RZUy6XYS6OmztHKCB4lxnMMKHtjOx71eebwEYZl+QY4AYy6NP2GEeKqe+woxsAjYi7jIFuHkYsLE6N33mDiUjIRB9HdWYfKZTh6cJls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770665514; c=relaxed/simple;
	bh=NMMjrph8bNLMAw02ZraHdiK+pEZZUMZxT3K+AuWZRZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIHNLmH1W0WR9t4nzkSp1qn4qQu9Iv+HGy5qskhLrCKqz4xNw2ioKviSNby0ITocW8qCC+OoMNPLOpNr31xFBW4nbcfpSsCaZtghDRxCuCHxkb34azjtkYjEkGKDdX2WxhZ1/nT1hVZvgMlQUYCP5Wz3Xl5q7c0Lhzr3PzOAqFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lr4QbNsG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lr4QbNsG"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a964077671so12285ad.0
        for <linux-ide@vger.kernel.org>; Mon, 09 Feb 2026 11:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770665514; x=1771270314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L9rHFvDcYDJ5I2XeyKJgfwKYtF6xJ5jOPGzWKqUMlyY=;
        b=lr4QbNsGLRm9OYgccT+9NZAIwNtZbD/VWJ0t4X/j7Ter4ZV2JLaWMa2b1ccXZZr8Iw
         a41XBf+g5opQSgW2AIba3h1O3A4Iu1Z4990I96glDlpi2lDuA1c46GBfZniTgjEW2Gp6
         febFoFpul8se0HjpAKLaylfDzf+b/Z31sUWWSMdrarmVe0zVxL8rC7dI3vQxv1G551wf
         PgNwOHBZcHWgAErYiUZmRddipCo/sECt7njm7Th3XPOC89BXruZNVSyDDNHTwzBcHxI/
         4VunwDr6WQf7tb+AaNzCP1CgYuPUsmGzxcTmb4e/mCuw6qPvWwiZaOJzv432nwBR8umY
         LX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770665514; x=1771270314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9rHFvDcYDJ5I2XeyKJgfwKYtF6xJ5jOPGzWKqUMlyY=;
        b=Roqts9UZPNUNugKbe+1z2DhQpZa/XpYhf75w7b3SLg39jggJy4yw9Yp+0WrRdMLRPP
         wfRq9mKf55/umQzyQLOeYMF0iW4AXIPBNFIurDTNbFNLQtpB13kAOobSuvj3XjcnL76N
         RyDr/zycrpBdVkA/obnBXoZD0tuzqIIViGpCJ4SB3Z2u92PPZ0iiw5E5qZd1YnpYkxuo
         mSslAZFOoTeS+V5kfMMl6fD4dI/wtkB08B8d/VjGkxgH7or6HL65+jpL2DplliAQKnop
         z7VM1OsqpZvmaTnZfq0vZRiSN7SFcyS/F1lhFGMH+exFv9739rm/BhgoRAxYv/svODUN
         TIig==
X-Forwarded-Encrypted: i=1; AJvYcCVrrek+jUbb9LKUqDWQ3H47m7zN8GbTEltVPOA7Xq/5klwbw7DQ664dx1pH+Q4Ddpu6bA16BIzKTqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkBvybvCcBwV8jAM5PEDTfHqmbrvBGYxZ93lSbkTkm20G/jDIs
	ruxrsgpthZpZhUkt2RVxrmQmmFcTYV5tyyWNjfyJBcvwTP870q7NwjMFkocliuY8fQ==
X-Gm-Gg: AZuq6aLHPcAYsKMHI4DnB2wnD8eHHYhGeHyS00wa9QxE2lm23+Fcr6ARPqrQvgGAGh5
	AUawanExC0ZqWSNq/7TLAf1JTU0W/0whyFxpQ3Y06OLXGSskuLCXPplMQVLApbul1Hs1wrK/VQz
	gTly1EvHkIADRGYySRQkOpiIzefsUikOc3KdtruYuR1FhnbQPC7YAk0F/XmMP0bwx0Uq4f8BasG
	AEPCpWlj6ytm4aSiwtFwkjEkauTzwztJGuFklu/TcSUh1BWuepfrEomzi0FltJ7ZYcxo8qCCwaK
	lw0fLknNDX+Cvq2Ke/ln8wzxlGBIE9kmYn5l0KOeb6r7jMbho5L6VPl2NYGIeLSdxspDxF7/XAE
	+0eOIkxq5VUX91Kj3MxyPH2/rfJAZgxG40L71Ae3syt/z07RJ7dZEkMslsqfUNlYgtrFcBIEkgr
	07TfgfArS9cdg+RBxfGtea0LYIcgBd+UTqbJZHe0yz+TfnbqJHfw==
X-Received: by 2002:a17:902:7c93:b0:271:9873:80d9 with SMTP id d9443c01a7336-2ab0ea1940dmr290255ad.7.1770665513647;
        Mon, 09 Feb 2026 11:31:53 -0800 (PST)
Received: from google.com (185.29.127.34.bc.googleusercontent.com. [34.127.29.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951ca59f4sm112387565ad.43.2026.02.09.11.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 11:31:53 -0800 (PST)
Date: Mon, 9 Feb 2026 11:31:48 -0800
From: Igor Pylypiv <ipylypiv@google.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] scsi: core: Add 'serial' sysfs attribute for
 SCSI/SATA
Message-ID: <aYo2JBW76jH44lAU@google.com>
References: <20260205180015.2215143-1-ipylypiv@google.com>
 <430f606d-9305-41d9-9a49-b9ab6894cd61@acm.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430f606d-9305-41d9-9a49-b9ab6894cd61@acm.org>

On Mon, Feb 09, 2026 at 09:31:39AM -0800, Bart Van Assche wrote:
> On 2/5/26 10:00 AM, Igor Pylypiv wrote:
> > +	return sysfs_emit(buf, "%s\n", buf);
> 
> Since many snprintf() variants do not allow to specify the output buffer as
> input argument, the above seems risky to me. Has it been considered to
> replace the above statement with the following?
> 
> 	return sysfs_emit_at(buf, strlen(buf), "\n");

Thank you for pointing this out, Bart! I've now realized that you
pointed out this in V1 as well but I misunderstood your comment.

sysfs_emit_at() returns number of characters written starting at &buf[at]
so it would return 1 for the added newline. We can add the number of
characters written by scsi_vpd_lun_serial() to return the correct number
of characters:

	return ret + sysfs_emit_at(buf, ret, "\n");

This looks a bit too complicated/ugly to me. Instead, I will put a newline
manually and return the correct number of characters. PAGE_SIZE is passed
to scsi_vpd_lun_serial() so we don't sysfs_emit_at() to check it again.

	buf[ret] = '\n';
	return ret + 1;

Let me know if this sounds good to you.

Thank you!
Igor

> 
> Thanks,
> 
> Bart.
> 
