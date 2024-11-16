Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046D38BE8
	for <linux-ide@vger.kernel.org>; Sat, 16 Nov 2024 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731771637; cv=none; b=C0s4X6Sgh4XrFJYJtbT0LNxYCmwOcqc1wXyHUnAB+Em7nsozrtwTho9qX64Azto03h9JC96UgGw5EJZYjat4BgXSEvbk9r0aC8MmRjjmXeLgXOY4z7z/U+Rf8tyNvbztZsHNzkbjaxBqJlDbAurWvQpKkOAJNR83CNnOkP+Gw2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731771637; c=relaxed/simple;
	bh=Wd+7kLQISUZlzyPvYmSUTVOb8NV4Vyd3OpsFXw6X7a0=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=mUwAXVL1xp3nic0DclZceoUoKrYV1yAgKIpeVBigv7pgW62cLCUbNV//wrA3yqsaOE6nmMMADI/vI1LFEZW/9tawYxb+5ZWKII1xjBnsOJvJ/hMAxiMRF1cfqvIqrK83syZWdcB03YXTen2rcREMucxRsvCjqQHA3jiqmR+XxD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/h6WZV1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/h6WZV1"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c805a0753so27362155ad.0
        for <linux-ide@vger.kernel.org>; Sat, 16 Nov 2024 07:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731771635; x=1732376435; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=K/h6WZV1avKeqHtH8myhAoF0GAE4jbeGORY/cdHA5SLaCgBD//xnKw4d2eChA5a/ob
         qUJRMH22s8TgDInO7UKnBrS2Hka5AbEqkjaiRbJbRVTyM+kJ5+bHNhuh6p65TOT94REv
         ml7d2Vktwe9s0tJf4V78LvPniNCn3uCfs2K04TYMHv9Tc2/jrowLnTbj/2ED63jQNGNd
         opWMXooNl1zpohXZJIn8dJc988XyfExXNxs+n57n3hKRccp8FbpYl36Ne3DxC9JUSbv3
         M5TdLdyEiozozqYyQs2wdlGMWXgZBRGQT1MZHn2Zvq4itcYoxxwwrvWDY4ZkVL90mjkH
         5rFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731771635; x=1732376435;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=NAGUr3OlWGSd1m5zuLKJj9MXViKUMUIH+qDaa9di6jUQdeB8rk5Tk+TUsx84xVveLM
         wwaWP6QeFCZAvvWzKcLeQTUybjbpPzbC3eRLlnmcEaav5+allP+PaRkhKbTB4vewdwQc
         Ew1nrZUX3jMiAR6gPUL4EBj4+wJpYpmx3zWOMtXfZTYP4I4m4pUGZR1Xe+XRApRTmmFo
         Hb9JxvSapgcQvBQFnLMaTyOLfB6EEenU8XZMYw5Ehnq2Geppoz8dH+wn1V5tjf33Rwsl
         o3buWPd68wGoFaRpYUsq3TSl5Az4KzF2RhZ0nXRS2NrqAzq3amfMC5YR5ccATabrCM7d
         XQzw==
X-Gm-Message-State: AOJu0YweYHoT+x3czw9H1Dv2g8Z/mislw2aBJfu9XegMiJcOGCrzn8K9
	BN/RkmKGqTb39FyKAIoWjyBn2KidZTsa0uKX8xEX2RrMd41TkuL94Jtr5w==
X-Google-Smtp-Source: AGHT+IG1Bazp/GoUprPDLJeek/VtEIf5JbsUpFCSrk60ZJ2ISba0R31f2bILtZktk6Nd+Tbr88GzVw==
X-Received: by 2002:a17:902:d588:b0:211:eb00:63bf with SMTP id d9443c01a7336-211eb00650cmr48339855ad.42.1731771635211;
        Sat, 16 Nov 2024 07:40:35 -0800 (PST)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0eca5a2sm29312955ad.110.2024.11.16.07.40.34
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2024 07:40:34 -0800 (PST)
From: "Van. HR" <fallelhadj31@gmail.com>
X-Google-Original-From: "Van. HR" <infodesk@information.com>
Message-ID: <a56e712e53bbde3a6279c41d19f98dc9ba177904b36fc316b73c32be6a0f89f4@mx.google.com>
Reply-To: dirofdptvancollin@gmail.com
To: linux-ide@vger.kernel.org
Subject: Nov:16:24
Date: Sat, 16 Nov 2024 10:40:32 -0500
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,
I am a private investment consultant representing the interest of a multinational  conglomerate that wishes to place funds into a trust management portfolio.

Please indicate your interest for additional information.

Regards,

Van Collin.

