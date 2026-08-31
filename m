Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8162E3B0AFA;
	Mon, 31 Aug 2026 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168370; cv=none; b=p1UwhRnDgOqzWVX8na7J61AjxCWJ0TmKZE4h8iATg1/ydRO2sLT0jRYQ+i/ggo7mrKecU8BPU0W3R5NNTYQHUKzOQ+cusoozfIb+Zv5sQ18E2fAr07a5MUMIAeEqil4J2BweAkCzYJp/g8nK8qwVwLYASuJ0H2Dus3fbps7W0Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168370; c=relaxed/simple;
	bh=COxRg8MJSCpt+HRa9tvVHY6ZuH1rTgpZgewayJ4yyyk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HuUnfZdbdMAwXK1zYM4+xPzZnCTFelDoKKsjQ6/z/10NeLPNXfZILOegqA5Oh4MlGwnwUpMRP8c74V+gGv//tA886GuqT5GDj06MMTRNdhwl6eOWSp+ZFTGuOCOECo91S8t4QlvYcIz1kND9wTGHuGCL4690pOiF9tD3C2YiG3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Koo3bfON; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Koo3bfON"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51711F000E9;
	Mon, 31 Aug 2026 09:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788168368;
	bh=IwZZk/XmKoYwDuHRR31RvrwRf+WAJix26dN8cP75c/o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Koo3bfONeroyGH+2XOubEk18PTLeNrX5Tzg8RDyfvqjKdOvPUQdsiC7uwKEBxBYs6
	 j4fpwP3B09XbXvmK96HjuxEnit/gcZChK89iBWqMbTtF9qNuBfJ5Nkju9qjLCk6JLz
	 M7FM71M9l9TYmqPxvLeBE4AjEEA57mni95/Dv+vuY/XzTPkwR/aSPtZdf8TReS+ZPb
	 GSxLvXnGz2tSypCZLfpZclebhNwyXLm04q6aG5zTdUB5wMucLIOpCPLVLcn8/hLOEF
	 5ESAGUQd9K07by3BJGf6cVaqx1o61TwW8H4RxPDv/rpxbkD3DKviI6Z+kQ+7Z8zft3
	 L0TTf9e/9bicw==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org, linux@zary.sk, linux-ide@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Pei Xiao <xiaopei01@kylinos.cn>
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
In-Reply-To: <77dad1184ebd0e1e7ea541d4207568f8bc5ec01f.1785381141.git.xiaopei01@kylinos.cn>
References: <77dad1184ebd0e1e7ea541d4207568f8bc5ec01f.1785381141.git.xiaopei01@kylinos.cn>
Subject: Re: [PATCH v2] ata: pata_parport: Fix use-after-free in
 new_device_store
Message-Id: <178816836663.189107.12488362030216541340.b4-ty@kernel.org>
Date: Mon, 31 Aug 2026 11:26:06 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Thu, 30 Jul 2026 11:16:29 +0800, Pei Xiao wrote:
> The function new_device_store() calls driver_find() without any
> protection against concurrent driver unregistration. This can lead
> to a use-after-free (UAF) when a driver is unloaded (via rmmod)
> in parallel with a new device addition via sysfs.
> 
> The race window exists because driver_find() returns a pointer to
> the driver's private data, but does not increase its reference
> count. The caller is responsible for ensuring the driver remains
> valid, but new_device_store() did not hold any lock or reference
> during the lookup and subsequent use.
> 
> [...]

Applied to libata/linux.git (for-7.4), thanks!

[1/1] ata: pata_parport: Fix use-after-free in new_device_store
      https://git.kernel.org/libata/linux/c/bd46a0b2

Kind regards,
Niklas

