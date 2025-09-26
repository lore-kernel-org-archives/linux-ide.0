Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD76D27FB1E
	for <linux-ide@vger.kernel.org>; Fri, 26 Sep 2025 20:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758918496; cv=none; b=d+fEkLlKuTYoAHu5I2WZXCH6aSN6Z97A/BWuVBxgA3UK5D3sgXF0ejrssrsauiP1h9ezmn1/wYlAe7e2Y4yETynrfFCCHj4N+kuQlUooySkojVEoWMxvv/n2mgVVETslUQ8sPfs3QmYlVAep5191ImPMopc8pGddruNlXs35pwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758918496; c=relaxed/simple;
	bh=O8QFdXxSKwgVO+YVFBaltuXigjwA2T41bKepCRdEs5g=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=LMJdQxstrYTcSdRtpwZPD1LNOXz+rd1IbRnumFZorLh7w/EDgdhmSu7f8+CqMIZoiVGGVPAIW6VeZeCGt6hzoOunfOCjlLjK92psXJ3iq9DGOseLjKAvagr/xmtaGGPO5v0UrGfphn4F7XCuYRknoq2xPmGvJlN1g4xNnLl7Cak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHwgqH6y; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHwgqH6y"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77716518125so1385015b3a.3
        for <linux-ide@vger.kernel.org>; Fri, 26 Sep 2025 13:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758918493; x=1759523293; darn=vger.kernel.org;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8QFdXxSKwgVO+YVFBaltuXigjwA2T41bKepCRdEs5g=;
        b=VHwgqH6yDtOYK9ZhTdeD/w36v2vwHYw5ms4CKRZz49Qkpgb9bcNYrYXTsS30NNOc08
         4lx2N5avE6u3e47Kb9vCXBXTXpbXCFeAoJbh8QzC0qaNPoiBBoDQfbTW/6viVl7P7jgb
         MjK8hwDkW49kGWZy8LGDSmXr9yHVO/fdeI18xvZR0O57EtNiXwnj7yxEePi/gs+sIJD0
         dKDm5QJYBJ1VaUDfRtW3NzKmCQEeRifFRBVkX0JoEvrCvf/HPcaX4V1b22izMf4zz8YS
         T9C8xx/mCZ5Kw30YvYUUlpYmik5E021wLszIa1tfS/DUa1Xn1B6DgyjYrSwGJhg/QjCr
         O9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758918493; x=1759523293;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O8QFdXxSKwgVO+YVFBaltuXigjwA2T41bKepCRdEs5g=;
        b=ro9yklBANTRq+A4utR0DepJ5dWSgWocxOEGJaHOZJwiJjP4hy2TupclqSA73w9hil/
         n6sL0pQrZebSjSdlI3a57vBcu/j2HIgDp3FkN9kyglaE+bOAF8yH3ts4lsT4DCLmpXmz
         ukC//ih2VmvATlZO2DUoYcdGGRPNP/yUYZC9LVFU6QQ2FKcgVWssQHG26GVT86IkiFnr
         tJO1pH61AZREBs1ayRzhn2MgFPJRmQD1U3lcbsxrkiUXCfHh86lyH3z1Zyd9DkQFPcwR
         7gAQNtVn8R6y5w64Y6WjGupsVngBwxy797q9cOO+hUctjtDkXu5MY9DZ3CZgLe4iIhz1
         ileQ==
X-Gm-Message-State: AOJu0Yz6KEeLzfhgGfAUM4Ajr7zzMw1XrvMkdEDzFCcO7i4k/K+uSEJ7
	WZ9UAfB6as1vf8vFuhn0z3uROd7+gQbFeVAI+4KRQ6giZcKKXKpWbELD47i1SA==
X-Gm-Gg: ASbGncu7fjBCI5b9wJq0Zqn/IzovK0uHgWR1aL43kPGOB0ZJkRYe3t1nnD02VuqFM/2
	EHL+74kIvhhebFoues26sJbUoKPFPlA5Wkfmqi49VuaIS0ROEzUrKwI5G3VwD2hvTW2PYJ68GuH
	DUKeMiqyVn8j6AV/O2PfHhLIqlgnEpnVaaIrEu2DHOXaqsHY8gGC1hlnR0rwfntux4r5nCqsXC5
	hgVeIo0xJG4sk7sTeGeHQ6f6WLapzu4oqYOhHCQXVT9ms14fyvDBE90tnIJ2Jn6A6aRj7v8arZa
	zQl2/K/UdDt+F3c82MrmKxhM6v7UK7BFG2PGm5he40fztsaLQ3GwWyhhxsh4Gc2yAtCKu1hoiMK
	PvVv/gJESW9YlZFACzZcdp9rfM2FczudDnU99LyUr+k9q+S+fNLP0V//aYkTW/XHBYjrN29IRtm
	Q=
X-Google-Smtp-Source: AGHT+IHwNG6+lavdSbx7zxtAhB7Du3NILd7SOYZ3tMkTAvpzQCq7Y4R21luzbhXU/bnycL5v6YbHJw==
X-Received: by 2002:a05:6a00:3cc8:b0:777:8ba9:d200 with SMTP id d2e1a72fcca58-780fcdff5fbmr8027884b3a.10.1758918492573;
        Fri, 26 Sep 2025 13:28:12 -0700 (PDT)
Received: from smtpclient.apple (syn-076-088-087-014.res.spectrum.com. [76.88.87.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c2acfasm5098948b3a.103.2025.09.26.13.28.12
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 13:28:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Anthony Rossomano <trossoma2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Fri, 26 Sep 2025 13:28:01 -0700
Subject: Bad Disk Detection
Message-Id: <814F6726-DA06-4159-9D23-5CB6A59F3A2B@gmail.com>
To: linux-ide@vger.kernel.org
X-Mailer: iPhone Mail (22G100)

Hello,

Looking for some advice on methods to detect and disable bad disks, with key=
 qualifier being I/O errors.=20

This is to detect cases where kernel is continually trying to interface with=
 disk and I/O errors are occurring.

These are drives in ZFS storage pool. ZFS has criteria for faulting them aft=
er some number of errors but kernel never gives up.=20

Using ZFS reported status for the drive might be option but the drive status=
 is not reliable when pool is not online.

My first thought was to monitor kernel log for messages with this pattern =E2=
=80=9Cblk_update_request: I/O error, dev sda =E2=80=A6=E2=80=9D

Are there any error counters under /sys that could be used instead of scanni=
ng logs?=20

Not sure that smart data is too handy for this purpose with the variance of d=
ata provided

OS: AlmaLinux 8.10
ARCH: x86 64
Drives are SATA SSD

Thanks,
Tony


