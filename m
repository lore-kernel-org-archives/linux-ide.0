Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7923C3FCB33
	for <linux-ide@vger.kernel.org>; Thu, 24 Sep 2026 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245138; cv=none; b=dJECUVYMmxFqNZYLQHl4CUNWNLebn6PEU2aoLoHdL5mf+h9TrCQ8NPXVQeIz3RfG8bVzJ7E8Et73vh2DpwD/zJ3maadkaWxLoh4B/0vmLSU9KQUgVGRtuBrgxW5bkTPhGd1uK6oUwfpaUmCiWLHW+PTN0xvv5G5ApS0C+8ovrGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245138; c=relaxed/simple;
	bh=lwalC0D92Ro85gQzDARgrb917GJU2FxTGiKOWrUgAI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyrBiUX/wj0cF6RG8vToohgN5HDPBWtQnZ8CRvxrJK7Gi1/GuTP/iz0+utuGbJPY8VvkaHkegJldcHo+xTu4OlfIHthB5hfWl97+aJp2t3lWz8k6OPc9zVzkeWWIAc8c48VldYtJLYHRvf4ZDwanesbsvVB9nSpnMYa7ocBIx1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kX1EUyEB; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kX1EUyEB"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4d04d740cso903066a12.0
        for <linux-ide@vger.kernel.org>; Thu, 24 Sep 2026 03:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790245133; x=1790849933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fl1Q6AJ6kNtXyHlg9LbEO1jNeJ2HRzLOuubRkhu5Y0w=;
        b=kX1EUyEBVYRbnZZH/yGx1h2E691LNSIcHnOk0jVddubV8v4bcWip3Z4tpSAU5u1idy
         XSlQ4ZlrakBPB5j7iIet7JiS+DVKdV6AGBRImHViD+qTYk8dH2FM8xuUnYQZLCoDtDhp
         L1xynEZB84zVc6bIShmmh1ZpmFrBQadT8esnef6Mz83VJz97Ng6E8itGvNzS+At+q259
         XABaKlLv/9gsDV7BENFvegC1Pz5fttrRV+0kCC8eb3eBzB3k5BwtKAoABiEyBYz63iB1
         3NIfZyKDy05azW6va+oWtKcRCJEm6uclyiWTcmwDwKnjMYU5vdJpnZ4RTIfX8HZLXqFS
         DT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790245133; x=1790849933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fl1Q6AJ6kNtXyHlg9LbEO1jNeJ2HRzLOuubRkhu5Y0w=;
        b=ECFf3Jblus3RzIAeR1Fu2f1lyEURS4Gz/0sUk3rxKj3VUvr5hGkrwHjZdX99zjyGio
         /l+e7DCMMZTCauDgjjLlBOiN8WZjcUxxrDJPHUPV3CNKKpZnf4uXz7+UDQX57+wUMiGF
         sg2ckzykuwarI6AE7P+ITDMf+jS243leYQ15iBV/vAN7pz8hKte8z2INUWMGz+PqSQND
         AxdnNryzOb5JVdvbVGmowTGHOrtyEEm3EIuXpdQrpXhTJE+W2JpMZSj+Ph/t35M4eYe0
         rEaECxrJqTMaQbXqCqUWhHFP9v8ANdDRaWZ0XTf/rOCCTrgsJJpNzxiE4CfAwq2D6TD8
         svBw==
X-Forwarded-Encrypted: i=1; AKwUvBw69l5x6iQiUV1F2xr8Q5DyhE/6O9IATTDxVqc/iAp7ZOUmWJQy76yx0VX9d7dJS0RW7uP5y+7zG6I=@vger.kernel.org
X-Gm-Message-State: AFuF++ngV5lNUgRggojaw8lNvTfAuou9lUlUKOdTfouu7EaBhMdf0ggr
	oqQ77K7MYfPfwWijncsveSAyEdUsRJRZpJyd7+mOw6A7SrhD2yMV/CJd
X-Gm-Gg: AYBFou1vU0ugNIiEouqaZ3vAcU7H+u7xCgv52HOIA8CCP7yFmJCW43dy/DW6HpuSK7D
	rIEaI2fDlq7ituaf0lCNfL2+GElSVGD0ZLuWlGRwDoT33lI2ZRhWcgAAPm4hnhdpPPngYaefGFw
	GxTgwaLjYr7PQUXMnfs+5mA96mzWWJmZ4V+SSKevtYUBQ48dhGrSLl9w/tdfKSJQfcPNkuj6qBc
	vfV94Nnnw4WRBDOlKp+5Nh247fTIoSih2ir8yNMQmvhoWIz7qKN+wNymKVTWwGPjn9HyT58wI0i
	IfK2K4/e23W00P4J6CbgYItbUmvp4pPmuQThiL9HHxOu4f1tQGqEdT/lYwTJiFP4vLayk7F85Ps
	/zpMfB4uLI58XrjNHU1zLqLZRXZmsKVZtniVRthLPngQr2IuEM/NGd3hESjGfKG6F96U4avKzuU
	xb4qkVUhxIH1Exi6mUUuaQPBUPoRWNj2jbzGHJhqJVQevHy4tX+C2RThooV83nHAweo0pYQfOFY
	jorGDn7OaofbWdxQPY/NemUA5T4YvqvM65p1bmGuURRAGstYQh0Pf64TfIvD041utIqitGt771T
	IYkyPP8MuhP/1LEqeAYmVurMoDFNHWXc5QGa1Ywd7pLgdA3TowRF7Syo0Ow=
X-Received: by 2002:a17:90b:4c03:b0:39e:6a81:f34b with SMTP id 98e67ed59e1d1-3a098bb66c6mr1656806a91.37.1790245127858;
        Thu, 24 Sep 2026 03:18:47 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972f2cddsm4315921a91.1.2026.09.24.03.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:18:47 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: cassel@kernel.org
Cc: dlemoal@kernel.org,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: name the libata/linux for-next branch
Date: Thu, 24 Sep 2026 18:18:44 +0800
Message-ID: <20260924101844.2403008-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <arTuIxpEsaYIQXU4@ryzen>
References: <20260924033545.3624716-1-matthias.goergens@gmail.com> <arTuIxpEsaYIQXU4@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Niklas,

On Thu, Sep 24, 2026 at 11:32:19AM +0200, Niklas Cassel wrote:
> I think this could have been written simpler, without references to dates.

Agreed, your wording is better.  I'll use it, together with the
s/tree/branch/ fix, in a v2.

> But in reality, if you want to clean things up, why limit it to these three?
>
> Write a script that clones all trees, compares HEAD against what is
> is Linux Next (Next/Trees file). If it diverges, add the branch name to
> the tree entry in MAINTAINERS.

That script is how I found these: about 160 T: lines diverge.  libata
isn't a one-off; it's in the first small batch of the plan I described
in the ext4 thread [1].

I'm sending them in small batches rather than all at once because I'd
invariably get something wrong, or miss a subsystem's conventions, and
I'd rather learn that from a handful of maintainers than from 160.
Exhibit A is the KVM/arm64 reply [2]: that for-next is purely an
integration branch and patches there must be based on a tag from
Linus's tree, so naming it would have sent people to the wrong place.
Comparing HEAD with Next/Trees can't tell that apart from a branch like
yours.  So I now also look at how each branch is built, and I'm holding
back the ones that look like integration branches, block included,
until I know how to word them.

As for the other two: SCSI went out in the same first batch [3], and
nvme.git isn't in Next/Trees at all, so the script never flagged it.
Thanks for the offered Acked-by; I'll Cc you when block comes up.

Thanks,
Matthias

[1] https://lore.kernel.org/all/20260924033200.3615554-1-matthias.goergens@gmail.com/
[2] https://lore.kernel.org/all/877bkb3zjq.wl-maz@kernel.org/
[3] https://lore.kernel.org/all/20260924033541.3624532-1-matthias.goergens@gmail.com/
