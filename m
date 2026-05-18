Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02E9305699
	for <linux-ide@vger.kernel.org>; Mon, 18 May 2026 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095944; cv=none; b=qlcmA7n6sRlDDYFA3FWKm7Jb3Jbz8w/ph1PIxc5ESFaz3hYpm6nbXObpPJtSUv7jVMOfWeexBc8rdmf6OMIAaEmwJjrh3IvozZNs8AEhW0dxYmechc7XczbPAcmLxuzGhjPRQ9ipL+SJvmX5NW8H0yXKi8lXE3xbtwNHXn2VEkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095944; c=relaxed/simple;
	bh=+4gasICwmq/6jnU5uEnZhE/eY48uShKQnroEx4tLjRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fES+ek4MznVQZmbiXRRrZ+mIl4jWm6Jaw9GEEtiLt+kGrI27NmVZa7rWKxUB8RsZL5OTG7Ewn3l/UzHsvNLsU/14A4Y5y2ycszYwOeLHwkRpSZuJ4QG5tMaevu82kQcBdjrV4b71DYHO0b9WmiMJlb8DoGxszy2j4PWdsDSe/TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoX+CBeN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoX+CBeN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E54C2BCB7;
	Mon, 18 May 2026 09:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779095944;
	bh=+4gasICwmq/6jnU5uEnZhE/eY48uShKQnroEx4tLjRQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VoX+CBeNOPR+WeSnV8nT04HDBb9ruEJXUc80lDhG/KtGtt4BZluxKUDYJzxV+XNgO
	 x3HrUH6VIXSoRjtmoag4mPSB1BbEAk4vtFXI9hUlG57ZEB0Y/msi/9KZXeYb2CHcu5
	 pI6ZWBzxxxQogYgGjqN1Yj6/P9n9uWNcx4PZvxT/eW2De+aRLmQVer+ogiAUC59t72
	 96obISZSmFkhwt3d9Wrr7LSA980sMQ9BNrngz59CHUx88nf23RY3uNsybuN69ds1fX
	 adEXHQnOoYLqLl8GuV8SxNlwNENXtW2pjlJvSWdUQ9cVH7XESVrEVN/aMCchxYVXK6
	 QkGbVUxn//zcg==
Message-ID: <b3e60dbe-2fc0-49f6-889e-34144d4fe42a@kernel.org>
Date: Mon, 18 May 2026 11:19:01 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] ata: libata-scsi: improve readability of
 ata_scsi_qc_issue()
To: Niklas Cassel <cassel@kernel.org>, Tommy Kelly <linux@tkel.ly>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 John Garry <john.g.garry@oracle.com>, linux-ide@vger.kernel.org
References: <20260514073858.1175072-6-cassel@kernel.org>
 <20260514073858.1175072-7-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260514073858.1175072-7-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/05/14 9:38, Niklas Cassel wrote:
> Improve readability of ata_scsi_qc_issue().
> 
> No functional changes.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
