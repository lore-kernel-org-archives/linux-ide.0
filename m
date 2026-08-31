Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1C83CAA59;
	Mon, 31 Aug 2026 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168785; cv=none; b=d9egAN+fH20z1GD+peuDOi7+lg26quMKLxbwdvgS7PYcIE9G807KiIb6qnq92TldJ/hR/vJfBCsAYlSPvDXvQ35zB86MWFNKS3eI6RWHA5hnxsqkvNPbcqfR2L3lc8y3XkdM+zAIEAsOMOf1Moyfan/Dr8DmQfHI/pmVUPFwph4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168785; c=relaxed/simple;
	bh=lcvPTHJxZuO0AJv7HPkCAcGoa0ujLim8EjIr19uItgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEomhBRb0M3AF+58XUA5aLqNqosjuFrpEFBfCN8vLbl0DiXQ/Yo1D8XJSQSxMx8XVWXs5qgwzwHP+kMGT/Z/nbdrNNObdZvhTDQlwonSgUo445wPEnmlburEJk3+urNP7nkdW8QPN1zvrn1oGeiMzT4Oji7KxDCjF6g/PEeDGv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTtPduHn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTtPduHn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091F21F000E9;
	Mon, 31 Aug 2026 09:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788168783;
	bh=31BC3Dvs8vzr2MouGxTv3QOrWJbAg7ptVsOT2SRyoOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cTtPduHnIbkZBGI4HqenwhZNw/VD92oK81jOYS3mzBy/GSR82Ge3rnq6qXqI3VtGx
	 pLumw/rVtoBG9a8EYxHggx+igdzev+sqErwTkRlkQ48Y/WS6Wz5ad5o3QhNRkDD8pZ
	 aPG3nao2sKh1dYunV1codSrAwoj6xcAjsZAG8bjIHY31khl+L3H2Wj3CsF9wi/NtQP
	 jUJJ8bUjOd2GQ4CObTO+4Ouajxl6x0bgd3c3mzsZu8rw27JUTqPMaZYJlLLTVDIT2b
	 ZoDaW5vQxcaNfXFC+sT95qMCZu9DAgt1KugxXhacoQVFJO3DjKTX4xz+bmeVgFe/wE
	 i/aqQsSi+nVaw==
Date: Mon, 31 Aug 2026 11:32:59 +0200
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org, linux@zary.sk, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Pei Xiao <xiaopei01@kylinos.cn>
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: Re: [PATCH v2] ata: pata_parport: Fix use-after-free in
 new_device_store
Message-ID: <apVKS5ZSmxplZp7c@ryzen>
References: <77dad1184ebd0e1e7ea541d4207568f8bc5ec01f.1785381141.git.xiaopei01@kylinos.cn>
 <178816836663.189107.12488362030216541340.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178816836663.189107.12488362030216541340.b4-ty@kernel.org>

Hello Pei,

On Mon, Aug 31, 2026 at 11:26:06AM +0200, Niklas Cassel wrote:
> On Thu, 30 Jul 2026 11:16:29 +0800, Pei Xiao wrote:
> > The function new_device_store() calls driver_find() without any
> > protection against concurrent driver unregistration. This can lead
> > to a use-after-free (UAF) when a driver is unloaded (via rmmod)
> > in parallel with a new device addition via sysfs.
> > 
> > The race window exists because driver_find() returns a pointer to
> > the driver's private data, but does not increase its reference
> > count. The caller is responsible for ensuring the driver remains
> > valid, but new_device_store() did not hold any lock or reference
> > during the lookup and subsequent use.
> > 
> > [...]
> 
> Applied to libata/linux.git (for-7.4), thanks!
> 
> [1/1] ata: pata_parport: Fix use-after-free in new_device_store
>       https://git.kernel.org/libata/linux/c/bd46a0b2

I picked up this patch.

But here:
https://lore.kernel.org/linux-ide/dd146e49-33ff-4ae8-a641-1dc614e22733@kylinos.cn/T/#m1cd93326f2935273e707c0aaea3c659a238bf2b6

Damien asked you:
"Sashiko had a comment about this that I think is very valid: if rmmod is
executed with devices attached, what happens here?
This entire driver seems to be lacking reference counting on the
modules/drivers, so this all seems very fragile."


The Sashiko comment he was referring to was not a Sashiko comment posted in
that same thread, but on an earlier version of your patch. The Sashiko
comment can be found here:
https://lore.kernel.org/linux-ide/20260729112609.3CD3A1F000E9@smtp.kernel.org/

""""
[Severity: High]
This is a pre-existing issue, but does pata_parport_unregister_driver() leak
devices?

When a protocol module's init function registers multiple protocols (like
kbic_init registering k951 and k971) and a subsequent registration fails, it
will call pata_parport_unregister_driver() on the already-registered protocol.

While the protocol is removed from the IDR and the driver is unregistered, the
dynamically created pi_adapter devices are not cleaned up. Since the module
init returns an error, the module loader frees the module memory, bypassing
the reference held by the devices.

If these dangling devices are later removed (for example, via sysfs
delete_device), pi_remove_one() calls pi_disconnect(pi), which dereferences
the freed pi->proto->disconnect pointer, leading to a kernel crash.

Should the associated devices be unregistered here as well?
""""


Do you perhaps have some spare cycles to address this issue as well?


Kind regards,
Niklas
