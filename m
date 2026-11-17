Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919094;
	b=otWwiM1mBhVSXVPznScmKldF46f2CbsGwiXTpNEPfRoRuVrXXibqHZOHYqxzVNDwMGA8
	 aGvUJldZbyr5E4c41JyMMx15MGH/muuhuamNqmE26GYvZym1s4jWL8V5cuwtFc6GG68OC
	 vZkn7H8SDC9ipQwq7/Ca19WuJn0O4cTMMEMzV3kUA3iO++RNSGAX+gCMz12TSO5H8jcvX
	 YUCPkSO3aiNJvIrRkL3MkdmL/WSyMHx5J20x+MCDFWZU1sn3YCxuxU4nl1vTzRdagzdup
	 3Oc09brSw4giK3fNRYgWWvKjH9buAXnXmBU7y84n0Y8/EqlTA7OwM0M8h/qIPNQL3Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919094;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=BfKTHlC3+Xbx5OHdr09scBdcIJUWSjUyLGqVWeWli9g=;
	b=SfqdaIN6/eFoeEho/CkWhxDMBwM9A+d89PqspXsCkG6Df1LD7xkIqXkR2FPCeW4MJakS
	 6eNc4wxJrwkpf2Nco1QkAagAVzvQJFEs4Jx2UrX0jz0rN+WDeMaupmF5Mv2N7PTow4Raq
	 17xAM2o6GWFlfpTvv2aTb2h3du/S/Bc9N+tJVDMKUYVMymkHnXsdQwRlYmnbZo7LaYCtW
	 1lGAbWDi7BbI3Vh4hiUGAom2gzybd9N3NZakktfMTBC+IZz3h/zNocDPeZYRXKSBoDqyI
	 2Ia2NEVFYUaZuMHO/uqjhLJfFdFfli97FjGm1KQLUXrDFearDLWUxRQcOQMpiQuqAwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KT1H6zLb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD96606A330;
	Tue, 17 Nov 2026 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KT1H6zLb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8C91F000C4;
	Tue, 17 Nov 2026 12:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794919094;
	bh=BfKTHlC3+Xbx5OHdr09scBdcIJUWSjUyLGqVWeWli9g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=KT1H6zLbTn/m6Jw8ozxk159/tT/nB808lvspGjSH1JPeQwWMOtiwYOWq+LeOUqzlc
	 YA7hZqAgTIyNepMFGiKyvOhySX3VpvshQbyVmtDG4b8ZmO57Rt4Ga0sMclvhaRai7m
	 iTder9kKRH70LsNOTVBlgzhOUwI8ENddgu56NuW5hppI8YXMOM5z05DzJzwWZbiELV
	 xId6uSeyjexcfuQG4bI4zLACrZEx0g7vviz301oRT4V18vzNMY+PFXS7BAztfO6Nx6
	 eX7aA6frTUQ009aFXNPE/qXp+Q4FwtS8iyfbiAr3e9DItM+esKcnbmaFAyLQN4dh6Y
	 VEVU1r1kpX87g==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org, mans@mansr.com, tj@kernel.org, 
 Haoxiang Li <haoxiang_li2024@163.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261117094903.1282096-1-haoxiang_li2024@163.com>
References: <20261117094903.1282096-1-haoxiang_li2024@163.com>
Subject: Re: [PATCH] ata: sata_dwc_460ex: Fix DMA channel leak in
 sata_dwc_port_start()
Message-Id: <179491909249.3460736.3681110965514683610.b4-ty@kernel.org>
Date: Tue, 17 Nov 2026 13:38:12 +0100
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Tue, 17 Nov 2026 17:49:03 +0800, Haoxiang Li wrote:
> If phy_power_on() fails in sata_dwc_port_start(), the error path
> frees hsdevp without releasing the DMA channel acquired earlier.
> Add a cleanup label to release the DMA channel before freeing
> hsdevp on this failure path.
> 
> 

Applied to libata/linux.git (for-7.5), thanks!

[1/1] ata: sata_dwc_460ex: Fix DMA channel leak in sata_dwc_port_start()
      https://git.kernel.org/libata/linux/c/9397e8e9

Kind regards,
Niklas

