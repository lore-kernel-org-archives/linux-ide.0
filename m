Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBA427F749
	for <linux-ide@vger.kernel.org>; Tue, 25 Nov 2025 04:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764045228; cv=none; b=LY7f/UECcI7UxuSMPVUpPBIw6swY30W8UQ/0c33O+f4bm5uWNVuV/RWKtXVJvT4DwE0C2FQr40IsJ7/NlFTI5wFhprzzT9Z8+BaPujbAg/q/ZOpdgp/5EMP8xL5nCejKec01QyYxJr58SPpq9ot7cAMybbH6NXa32pVxIDhZMPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764045228; c=relaxed/simple;
	bh=vQsj1mexjs5zHg+TEfr43VL6YD/NfHQ6fhpdqso5WCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xd1jlc6UBGSCMwNrdgVlrVNTJunXYb26L7xpe0Ky3dMjZUstDrpKgaqodt2X2H6TDd2gHE6bBj2pIm38LEVUgLV/1gjGI3BgWAuW9IldqeXEza/8rpUIdwywdRsM4DxqVQPUP9BXkME+38ojdL/K17Eu1AFsctwpBKQdBKNGpIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmN3OtyU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmN3OtyU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC41C4CEF1;
	Tue, 25 Nov 2025 04:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764045227;
	bh=vQsj1mexjs5zHg+TEfr43VL6YD/NfHQ6fhpdqso5WCw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MmN3OtyUDObiE4Jbj32T3xU2dAEh24beR1T8oEpnfc+r4X5VjmhnpgEW/dM1izxVI
	 Ldl0XkuDIa6n+7/yrnjacCh6GMzAkQLs9pq9wr9XtMYzZMhJfZ9uPPeX36CZQDHTow
	 pu+nVgFroXGJzSodHxmDlhVEgkJ/EV16C3PYAAuBiJMrEusI6DNL+itRFLldHJebi6
	 3gr9YG2chqbCHT7acLrxg3RFbsQAjC2TczcLiV4T+JP+UYSOCCctO9NT09k83pRY0h
	 6wD46ZX0U65cN682LVIkeerPA4HFDXFlwS3ODj4lZiV/FR7tpbRwypgfxUhEwG1rbb
	 gOZdnkxOq8KqQ==
Message-ID: <78445daf-ed42-4f40-bb14-8373d7c1ab1e@kernel.org>
Date: Tue, 25 Nov 2025 13:29:36 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ata: libata: Move quirk flags to their own enum
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, xxjack12xx@gmail.com
References: <20251124134414.3057512-5-cassel@kernel.org>
 <20251124134414.3057512-6-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251124134414.3057512-6-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/24/25 10:44 PM, Niklas Cassel wrote:
> The anonymous enum in include/linux/libata.h that is used to store various
> global constants can currently be backed by type int.
> (It contains both negative and positive constants.)
> 
> __ATA_QUIRK_MAX is currently 31.
> The quirk flags in the various global constants enum are defined as
> "1U << quirk_flag_bit".
> 
> Thus if we simply add an additional quirk, the quirk flag will be 1 << 31,
> which is a value that is too large to be represented by a signed int.
> The various global constants enum will thus therefore be backed by type
> long.
> 
> This will lead to error prints like e.g.:
> ata_port_err(ap, "EH pending after %d tries, giving up\n",
> 	     ATA_EH_MAX_TRIES);
> 
> now failing to build, with build error:
> error: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘long int’ [-Werror=format=]
> 
> This is because all other constants in the various global constants enum
> now has to be printed as a long.
> 
> Move the quirk flags to a separate enum, so that we don't need to change
> the printf specifier for all other constants in the "various global
> constants" enum when adding an additional quirk.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
