Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EBE317162;
	Mon, 31 Aug 2026 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172583; cv=none; b=T+cquN05xgNyiQwnBljcgxLE2jwYfGWzrHyAjlwGDfDx//Eq6jqT7EaTzl38Y0HjEDBbGtSfOJTHM4U6HV4zbN789HQS498WcNylkBZ1AF99KopHpYiwdJp9IMyxRfyq7IdB6brLv/vmmVFyry0G0mx0Yg0MLkYzzjIvPweJqu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172583; c=relaxed/simple;
	bh=kdo5aCL3GI0eFaq5YwMsZzOtsmZOEZfp5wyzgWBvsGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsyUbyOlFmhoC4bFgErmKBU3OS+r8MvrgAjaUx5OK5Tmij3BklN+Sl3YPKuD2gDaXnekwT1lSgEx9JyzRRX7R4RKxE3N5bBJy/tlC5+O79Q4sKGefnL/t2Th1MxRmMQkFMAZhxyiqQiwQTsyFp/ed5ww84TiYvQmVON4MpC4AtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLpe1XbV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLpe1XbV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234291F000E9;
	Mon, 31 Aug 2026 10:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788172581;
	bh=sGWc8CFjz1Fprl7MowMB/ePn4CqqZpJIBMccjOBtfVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CLpe1XbVwJd4aoP/haxcIYNRf2bwnu6KcNdxjdy/xQTcGa8Rp34Zch4IE1ETpiut0
	 k6ztTF0sP9Z3aPqot182RsHMJfP+EGALtUuR8iv+SDc0WA0kNGkZscf9Xu3WtU55bx
	 oMOfhVUXG/dgrGK1fcVW9CjSwnW3rBd75kkQkq0JcoIEU5w72W4gSoPem1TE1S5Iyl
	 nHiHxf1lE8+UCfkQAnvFMkMyIC95CnkeboWxD1oKwIrFBx7BUXsPp+4ugq7hayCwm/
	 DddgIsQwGoTm0G47yZHXvXPTXKM51Yja0tDzTDpIFqOD4neELKe/kJg9UH0jetCAW0
	 oKk3JJEjDjc0g==
Date: Mon, 31 Aug 2026 12:36:17 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: dlemoal@kernel.org, linux@zary.sk, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: Re: [PATCH v2] ata: pata_parport: Fix use-after-free in
 new_device_store
Message-ID: <apVZIdLAECj05h41@ryzen>
References: <77dad1184ebd0e1e7ea541d4207568f8bc5ec01f.1785381141.git.xiaopei01@kylinos.cn>
 <178816836663.189107.12488362030216541340.b4-ty@kernel.org>
 <apVKS5ZSmxplZp7c@ryzen>
 <095d7e23-27f5-438a-b881-63fcf0b9baaa@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <095d7e23-27f5-438a-b881-63fcf0b9baaa@kylinos.cn>

On Mon, Aug 31, 2026 at 05:49:51PM +0800, Pei Xiao wrote:
> 在 2026/8/31 17:32, Niklas Cassel 写道:
> > Hello Pei,
> > 
> > On Mon, Aug 31, 2026 at 11:26:06AM +0200, Niklas Cassel wrote:
> >> On Thu, 30 Jul 2026 11:16:29 +0800, Pei Xiao wrote:
> >>> The function new_device_store() calls driver_find() without any
> >>> protection against concurrent driver unregistration. This can lead
> >>> to a use-after-free (UAF) when a driver is unloaded (via rmmod)
> >>> in parallel with a new device addition via sysfs.
> >>>
> >>> The race window exists because driver_find() returns a pointer to
> >>> the driver's private data, but does not increase its reference
> >>> count. The caller is responsible for ensuring the driver remains
> >>> valid, but new_device_store() did not hold any lock or reference
> >>> during the lookup and subsequent use.
> >>>
> >>> [...]
> >>
> >> Applied to libata/linux.git (for-7.4), thanks!
> >>
> >> [1/1] ata: pata_parport: Fix use-after-free in new_device_store
> >>       https://git.kernel.org/libata/linux/c/bd46a0b2
> > 
> > I picked up this patch.
> > 
> > But here:
> > https://lore.kernel.org/linux-ide/dd146e49-33ff-4ae8-a641-1dc614e22733@kylinos.cn/T/#m1cd93326f2935273e707c0aaea3c659a238bf2b6
> > 
> > Damien asked you:
> > "Sashiko had a comment about this that I think is very valid: if rmmod is
> > executed with devices attached, what happens here?
> > This entire driver seems to be lacking reference counting on the
> > modules/drivers, so this all seems very fragile."
> hi Maintainer,
> I have submitted this patch, and now I'm a bit unsure whether I've
> solved this problem.
> https://lore.kernel.org/lkml/a8d9807618ab786313654099c904d613075e1b63.1785398816.git.xiaopei01@kylinos.cn/

That patch proposal seems to prevent the module from ever being unloaded:
https://lore.kernel.org/linux-ide/20260730082554.B2C161F00A3A@smtp.kernel.org/

So I would assume that it is not the right solution.

I did not try to unload the module myself while having devices attached.

However, as far as I can tell, this is a pre-existing problem, and not
related to your already accepted patch, so don't feel obligated to fix
this problem. It was mainly if you had some extra time.


Kind regards,
Niklas
