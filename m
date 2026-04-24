Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FA821A447
	for <linux-ide@vger.kernel.org>; Fri, 24 Apr 2026 02:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776998925; cv=none; b=bI7U7gm0Umdalif0u+0p3uNykKKZhVYWSqJCs2/ZM1FW0dL3p1VrdC41ZqV1xX8ZQ97nogwnEI8z+MxG1oPPQ3afh1O86n90W/SYINl80zL7LR+1SR5gpKIavEyyRFL5yPs4lEMgFqMTtO16hrtuWFg13Hta7occEG5TWdcOGO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776998925; c=relaxed/simple;
	bh=J7EiUVcRgh3MfIJ3yT6isIZ7kXZ6FS2VmoKIixkIDhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQ272wbXjW/t6sDEn85c31X4Joh60AA7voPXAgdZRqnK1/VcW+WRYiRlnGy/jOfOw0+AcAtfl3+xwjgpQMigzYO3KbuL9FG5azCf/HntTkijhXL1rq29iz57z7h0VJIXCQa2GN3ILpkmYJyX6VYPPQTHPBJby/XUX08Esz2BsBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q97gcut0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q97gcut0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D40CC2BCAF;
	Fri, 24 Apr 2026 02:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776998924;
	bh=J7EiUVcRgh3MfIJ3yT6isIZ7kXZ6FS2VmoKIixkIDhM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q97gcut04JaA2DI0OLJnpsnsSUs8H0JCDQ1agEMB1/YUo+/uV/XSCn+Uv7wSnAdk4
	 pjVjLagrRXchkXU2SImHf4WwvzWrE5rgDSmoEuyXD07yRCjB/jHIvTC89zIxTsCAGS
	 wuF9RkgBOGqswh+oXyblQoKYFpTYb6pp2hd1ZUhzYgLdtxUjrhZaTvvpVIAZvLujax
	 YHYdWgndiDDPjywrKH9HlExq8Miw/zD8N/zS36g9RY9Y2AWq42EXaEuWnd1xUGNsHl
	 NqiLCL0KsgeF1usLTYdp7PnpSirCq/Y1uDQW3eBAY87ZTADINekEVBAs3+2vUnmPT+
	 gMOO9g0Oi4qQQ==
Message-ID: <ad6dc564-82b9-4372-81ed-76be7ade68ba@kernel.org>
Date: Fri, 24 Apr 2026 11:48:42 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libahci: use ahci_nr_ports() helper
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20260423164329.1541337-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260423164329.1541337-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/26 01:43, Niklas Cassel wrote:
> Use ahci_nr_ports() helper instead of open coding the same.
> 
> No functional change.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
