Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAC17DA7A
	for <linux-ide@vger.kernel.org>; Thu, 15 Aug 2024 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723721771; cv=none; b=dVsUdvucgBBFtzwksowhBCOJQmCMIKugH5+DBSwMBGjNSK/vU9rdEWVZNAhv1TP4sTzWqiSKrMhfyEzBI3f2qgCHv9vxmRopN1YM8YccQzlIoFNKattjZmzkw8JbZDD0exzyKHxb5ZdhWB7XOqilEn1X6w3ie0EZl00KBnCWz1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723721771; c=relaxed/simple;
	bh=nETnvhLKr0IDMnBcfu+qe89910Zuhb7j+NRXnq33lIA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ECHOO+tDbo14lU2WrXlnep14yc9ePzvel+RxLbWwGZzhTRAmsprvSpxVC26jYIPty6tUPzUDnqupdZPknkICQHIoPozivpFa2pmQuh23suCzJhRfyyxKAR2SzzGBllJbq4Pt46b/Cxes2EO+RgnSMOyiCdBeoJhtqSCKREfAfxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuAwcvvz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuAwcvvz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0174C32786;
	Thu, 15 Aug 2024 11:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723721770;
	bh=nETnvhLKr0IDMnBcfu+qe89910Zuhb7j+NRXnq33lIA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=fuAwcvvz8Os3axm4zGwHtO5uNxPxsTldOd+p+DbkUrE7I1t0aVEtDeueBsKCMpmuV
	 15vYVEkNBSoqAYNSU40OdEQea9wTA91AYwtiiSLYAWbb44cswyF84NokCiMgeQMmW6
	 5mltt43+heKcduZfK8IgXrRPJaC1PQI4hOtnLbm8TWeHcCiubtMipsiLAOtoXYvdPZ
	 BYcpn9p1YzoXMYCPPimLjGIKkgklsHf6gShLMy7jkwvI5vVVGmM7PEQRBjEmQD8UYR
	 bJmQ4+gTjvYVNW5GWO2Pq1jufT9CWF+lnGvDNLk3lyMA1IYE9MFvRl3B9hTAsT2BE9
	 rQfeUgngPQqcw==
From: Niklas Cassel <cassel@kernel.org>
To: hdegoede@redhat.com, axboe@kernel.dk, dlemoal@kernel.org, 
 linux-ide@vger.kernel.org, Zhang Zekun <zhangzekun11@huawei.com>
In-Reply-To: <20240810023426.110624-1-zhangzekun11@huawei.com>
References: <20240810023426.110624-1-zhangzekun11@huawei.com>
Subject: Re: [PATCH v3] ata: libahci_platform: Simplify code with
 for_each_child_of_node_scoped()
Message-Id: <172372176937.1341946.4797767283291778580.b4-ty@kernel.org>
Date: Thu, 15 Aug 2024 13:36:09 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0

On Sat, 10 Aug 2024 10:34:26 +0800, Zhang Zekun wrote:
> for_each_child_of_node_scoped() can put the device_node automatically.
> So let's use it to make the code simpler by avoiding the need to
> explicitly call of_node_put().
> 
> 

Applied to libata/linux.git (for-6.12), thanks!

[1/1] ata: libahci_platform: Simplify code with for_each_child_of_node_scoped()
      https://git.kernel.org/libata/linux/c/aa3ca1fa

Kind regards,
Niklas

