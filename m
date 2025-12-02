Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D102F6934
	for <linux-ide@vger.kernel.org>; Tue,  2 Dec 2025 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764670868; cv=none; b=QeWlmX2AKnLq43CjUFssQcWSaFKO16ssoQ7wUhtCWXKOlOEbauOT2OFyH1Op4dgi5AUabVBOtSI0bve7qh4yoitS7p+memDAc/OsoEWb1OQZa//l2aTeTtrhHxR8go2UjeEGe5EKQBdOM+gAlhzMLB78goOXZbyf/dD2E98FruE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764670868; c=relaxed/simple;
	bh=R4X3Fj5da71vAorCOQjlbycE+nYCzt3FmPm4H0g6SyM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eyUz6vYpojAeFZMWW6t6cwMG8TZ7VNmDBVJcfeWb6BSaXP9qi/FkO8R34RKFkibT4I1h+JP5VW+NlbHTP6UEnU6N1OV2To3AO+BrmcAS0xhrBBkeOSlVTmOPZmnQ3XrEq4Yb/zd9FZaWYhJfEuF3bIo4aJXWHYpPvR3lLNK5XMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocVR+WE7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocVR+WE7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74271C4CEF1;
	Tue,  2 Dec 2025 10:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764670866;
	bh=R4X3Fj5da71vAorCOQjlbycE+nYCzt3FmPm4H0g6SyM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ocVR+WE7vBezUV5HSxIxVkN3rQMME+4PfQJRqEuZdSmwf0V4Q+hNTjf48dYtnVXhD
	 IJbcpAuU1QKt28yFTpJ1EGM4ow4Ccud3gr5pujfu7P0McbQEG98IIHuznJqy1dpV3g
	 yQaI3aBzjD5do5BRukUzLqKdiS5gXBxYQ0/HuyeuggUK7/23kiYPIOjckvocXq/582
	 3dpqA92ce9wFtLvkbTmHiD9MrXTmvaa0UpKLCtwgPlOSGNFjUTPEwsJEit6nwaWn2o
	 EnxWdZBKMpgp55iVNRv7ZC/1o8XJNHQNJSw71owY0DDL8rAbb+/VmKXgXHuuYWqXgF
	 qptssplFTVs9g==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, xxjack12xx@gmail.com, 
 "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20251201123501.246282-10-cassel@kernel.org>
References: <20251201123501.246282-10-cassel@kernel.org>
Subject: Re: (subset) [PATCH v3 0/8] ata: libata: Quirk DELLBOSS VD
 max_sectors
Message-Id: <176467086520.364377.182740446463637461.b4-ty@kernel.org>
Date: Tue, 02 Dec 2025 11:21:05 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 01 Dec 2025 13:35:02 +0100, Niklas Cassel wrote:
> a recent change:
> commit 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")
> 
> bumped the default max_sectors_kb from 1280 to 4096.
> 
> It seems like a lot for SATA controllers are buggy and don't really like
> this, see:
> https://bugzilla.kernel.org/show_bug.cgi?id=220693
> 
> [...]

Applied to libata/linux.git (for-6.19), thanks!

[1/8] ata: libata: Move quirk flags to their own enum
      https://git.kernel.org/libata/linux/c/a42b71d4
[2/8] ata: libata-core: Quirk DELLBOSS VD max_sectors
      https://git.kernel.org/libata/linux/c/2e983271

Kind regards,
Niklas

