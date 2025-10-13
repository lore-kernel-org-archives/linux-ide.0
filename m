Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEAD27F01E;
	Mon, 13 Oct 2025 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340942; cv=none; b=ThPuNbomnujLXFDHB89wEhdweP4tS8PbJVDrtg3oPXt8ucw7SE9/khQqxN6SbKyrfxHWq2qjn4yk4qdsSfRpw4n5vK3fFhwsw8pY3/7kxEAi7YP/3EJiwDwL6gGvhamrxax4AgkVlyXLTbSxlPtl8w4Gu7Br0NHZhL4XUcVm7fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340942; c=relaxed/simple;
	bh=iEUdbvJi3pvRf67skvtGxBMrtqXcvV211k+jm08OGhU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O40XBN8LabfGVijzAh83ca6ssqJPF1VOJsmR/ftkPr67ZH/59GgObXDKDfuutGbyVQo840I4VHJ6wxAMQgZuyvSmr0AZRl2BZyHDVKO2Wb6hCa15vz3h64aB4J9PqM0EV+CH5DJhl/wqTuxen198/BrHxUXVD7yc1HWeMnh/V+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dONLhkKO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dONLhkKO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821B8C4CEE7;
	Mon, 13 Oct 2025 07:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760340941;
	bh=iEUdbvJi3pvRf67skvtGxBMrtqXcvV211k+jm08OGhU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dONLhkKOkRfQ1gfZWRMsLMyO+WZ55No0e2fE/1IaDDXtWKE0bVuZEH5nEx0Q7qLhZ
	 hL4ylUxEic8jlcihASCKXPZwhYeSOwA+v0mbsE1C6w8srDGqpqIU9JZBn7ysVJrToH
	 XJxJ7guXu7obEE1UUR24KabvyEjIXYT3NiHjW3RJ/Pc3T4QaiSjAILHSZUlHzo9ub/
	 m1G5v4bkhuxV3zJoX7LvYjCbXYTZiq/LUTZEjmt7MwjwAarBvKxrAWuT14Hz4TveT3
	 gnzNw7Wo4dXxmvnjb5vLovYWukW18YYWn7FYjP09qSMpz33jDZUNLi2+gJB/chkRCO
	 uHsmVds/S9Brg==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, vkoul@kernel.org, kishon@kernel.org, 
 linux-phy@lists.infradead.org, Yulin Lu <luyulin@eswincomputing.com>
Cc: ningyu@eswincomputing.com, zhengyu@eswincomputing.com, 
 linmin@eswincomputing.com, huangyifeng@eswincomputing.com, 
 fenglin@eswincomputing.com, lianghujun@eswincomputing.com
In-Reply-To: <20250930083754.15-1-luyulin@eswincomputing.com>
References: <20250930083754.15-1-luyulin@eswincomputing.com>
Subject: Re: (subset) [PATCH v5 0/3] Add driver support for Eswin EIC7700
 SoC SATA Controller and PHY
Message-Id: <176034093826.2889433.376970186266993861.b4-ty@kernel.org>
Date: Mon, 13 Oct 2025 09:35:38 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 30 Sep 2025 16:37:54 +0800, Yulin Lu wrote:
> This series depends on the config option patch [1].
> 
> [1] Https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250929&id=ce2d00c6e192b588ddc3d1efb72b0ea00ab5538f
> 
> Updates:
>   v5 -> v4:
>     - eswin,eic7700-ahci.yaml
>       - Add "dt-bindings: ata:" prefix to the subject.
>       - Wrap at 80 characters in the YAML description field.
>     - Link to v4: https://lore.kernel.org/lkml/20250915125902.375-1-luyulin@eswincomputing.com/
> 
> [...]

Applied to libata/linux.git (for-6.19), thanks!

[1/3] dt-bindings: ata: eswin: Document for EIC7700 SoC ahci
      https://git.kernel.org/libata/linux/c/c9d869fb

Kind regards,
Niklas

