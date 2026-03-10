Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5942E3397
	for <linux-ide@vger.kernel.org>; Tue, 10 Mar 2026 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773167353; cv=none; b=FGWW9hS0umONuJ7Z+ELIGXmNtYSE9MFLCFcw07L7Q8ojAnaOIOiX+LiupqhpmvGmiM41qMff47glvcq0hA1KBJjduAaWpezQ8K/dtGvrojc3x5dKAyffg0V6IIbgiA3lBX3DHuFQy0yS4C7u27m9K74TCL5vwDDROrrw2Jaj7dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773167353; c=relaxed/simple;
	bh=TVaDgs6Y08HDTlO3dn7CwvR1rkT0Bpj72TDQiblAGnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNu5hdjzBLOfBl9GlG+uBq4yLzwwbzRHJ3muCVdd1ul5HIQfYqqALbCv4plUDJiNRyOl1/thVxIIFRKv1NHWDMhGALNMJ3/FguOn/pr7fBWJwNmFo1EQ0a1dMXRTAUD1ns3gtPyzJpbAqtzqhSIHeKd6jC5K3QCNRkdrAoI+gDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzafLWkn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzafLWkn"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48541edecf9so16845605e9.1
        for <linux-ide@vger.kernel.org>; Tue, 10 Mar 2026 11:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773167351; x=1773772151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVaDgs6Y08HDTlO3dn7CwvR1rkT0Bpj72TDQiblAGnQ=;
        b=QzafLWknXWTYcfVCtQQ2awIsJ1ZHuwf+EvzkO2FcO2GPGbKCbCwdvpPMn4XBgH05dZ
         LbhxcVNyEtf735lPo9Djd3kn0Yol1sWQxq2qk0t6ZMFcmYJLgu3LbH6EuBjKk8Mgw5Z8
         rdUDgCmICQEuDyiNDxXk+SBKgxChSw17RzT7ndmCQSwbdZ+6M90fVLaRLNj9YFZgNR+P
         XrICteM28Nk4qEjJxjf1WVt0iALlrNL48flhbxxm+c6i0Z/iwoVCHN79gfGzshuz1lYU
         sMHNo9hTxBjiRiGxNaqHYwVMtaiUztQTjd/ChH/Ynftda7sCuJMnjpQdQntQ+5eM7/pb
         oN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773167351; x=1773772151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TVaDgs6Y08HDTlO3dn7CwvR1rkT0Bpj72TDQiblAGnQ=;
        b=F58oYeMgPgoKi/1FWHtPBhnLWlPmYuan/UKJMHwN965iKRGSK8SfcuAY3Q0cVnOO7U
         vd+PXBb+Vl5b1ze9ThtD7BnbPHYAtVUp0JnTcdN7AzCzBFL6asxmzMrW4qGmoh+qbwfg
         StPBaPq6Pi71J9CS8rICYKJhUZaoZ1vvWeDucVVEAJBpzUg0RbaqR8LRNjjhISqcbSwE
         Irv44ssLNPKAgtKfzD5/bspQQRTEBj+o8vZOXhXC8DEHD+VgYAkTp5EUj3wecpsQReNi
         P0pNlTG+BNZw0JaFofu1d3gbeiGXMT8jlzB01KSzl6wxP5QITcyOxsV4YInCtfoTaezN
         fnGg==
X-Forwarded-Encrypted: i=1; AJvYcCUXodR+qPyke8Voj9SGvrkVoYyW+OUs1Jz1HrHOVkvLL4hC3m39T5xCLFptZm2PAhHOcKeztjj0gCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+qX9W49DsO5x+uUAIIOMN+p7eesWLj7w+KmesHCU0cShiaA0b
	Y3QPAl/5nyZiisSIhap1UJMvCO+oEVWekqJ3z/1nNeJo4Z7DdsXahWDQ
X-Gm-Gg: ATEYQzyykh1A4eLcKtKfHlmxLsCYsl/pV89Z537qKFxUQfqSla1Edp04C/f6DwgF8vK
	cS1fcPznkzi6YqmD5tPkKKxguFNmu3jsLYGvUWTcI8YYKGkAgl3GrDPf/vTe9KR6FcSoODsnHYq
	fl3ftHQzGq7/0DbEWFZL05MJBwxi4tHwuKNXkFITjtfGSVVNlHYaHXOCIIbrgXmAqq4htxYMW/5
	VEPxSsIbVMj+ixkpI17d0GwUXf+WiUOkeMa77hTfVLrW6i7aaFr/kGgJ4l9O5uP6G9w/7nlstuY
	aG0flhvw7YUqKdk2hyPOyvva0xmvVef7KhLSy1k2avZ1+cudFTimNDuIKTLhvUXX3fnzn/AvFK/
	yLWD6+IgoU0AMoVXYehufNNaXJduHSsZHg9GNwl1KMO/KnlmVtDokFBGZRirWY+AA076G5S07fg
	==
X-Received: by 2002:a05:600c:8b01:b0:477:9814:6882 with SMTP id 5b1f17b1804b1-485269198bdmr262272285e9.5.1773167350702;
        Tue, 10 Mar 2026 11:29:10 -0700 (PDT)
Received: from kimsufi.. ([2001:41d0:303:6f54::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541a900easm106200825e9.9.2026.03.10.11.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 11:29:10 -0700 (PDT)
From: Ruslan Valiyev <linuxoid@gmail.com>
To: cassel@kernel.org
Cc: dlemoal@kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruslan Valiyev <linuxoid@gmail.com>
Subject: Re: [PATCH] ata: ahci: Add AMD 600 Series Chipset SATA Controller (0x43f6)
Date: Tue, 10 Mar 2026 18:29:09 +0000
Message-ID: <20260310182700.reply-val13@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <abBUdlxKa4DpVsPI@ryzen>
References: <20260310154956.743071-1-linuxoid@gmail.com> <abBUdlxKa4DpVsPI@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Mar 10, 2026 at 05:27:PM +0000, Niklas Cassel wrote:
> If the ahci driver fails to bind, that means that the class code for
> this AMD AHCI controller is not PCI_CLASS_STORAGE_RAID and is not
> PCI_CLASS_STORAGE_SATA_AHCI. I am honestly curious... what is the PCI
> class code of this controller then? :)

That is exactly the right question, and I should have asked it before
sending this patch.

I based this on a bugzilla report where the user confirmed the new_id
workaround works, but I did not ask for lspci -nnvs output first. I
do not have the class code from the affected system, which means I cannot
justify the patch as-is.

I will go back to the reporter and get the full lspci output. If the
prog-if differs from yours (e.g. 0x00 instead of 0x01), I will resubmit
with proper justification. If not, I will drop it.

Sorry for the noise.

Ruslan
