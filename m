Received: from mail-108-mta203.mxroute.com (mail-108-mta203.mxroute.com [136.175.108.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6451CD1E4
	for <linux-ide@vger.kernel.org>; Mon, 12 Jan 2026 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234662; cv=none; b=SMYJs9DIZPuUhw46KsBWbmQriHBZFnhn98ucwr5XHU0+q/MhLkieurCqgoO7WcQ/x+2KK19o/71FtJzqF+X46ResXLpjz972gdknYF8nIZz2Pb66btSSpzDZJZpIu/KvPbI4k2VcdfntcmaviaqXaYcsB4had2Og9AYo3Q6Zcj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234662; c=relaxed/simple;
	bh=cnIpXcnvQQAl3tIFgAVj66A4ZUVA3chwzCJuOcuFuis=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fOu4TMzwKI3mjZmph82iJe+e3DukbFRF+1uCcsOfmgVL73wyqpBIzw8he4aDaPFUWlTxSk70a7y9GgC42hfGG2sdYJPDVTgGg/Q03Rgn90fF6OlbvgEyRtdkiQPgum8k12cTgJnMWzS7RfExBjIEoxArniMWYDL7zagACiAU0Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yoxt.cc; spf=pass smtp.mailfrom=yoxt.cc; dkim=pass (2048-bit key) header.d=yoxt.cc header.i=@yoxt.cc header.b=5/YGty4S; arc=none smtp.client-ip=136.175.108.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yoxt.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoxt.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoxt.cc header.i=@yoxt.cc header.b="5/YGty4S"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta203.mxroute.com (ZoneMTA) with ESMTPSA id 19bb2faf5450009140.003
 for <linux-ide@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 12 Jan 2026 16:12:29 +0000
X-Zone-Loop: 4495102ac28dbe1b1aa55547e396767603a1f73255b3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=yoxt.cc;
	s=x; h=Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Subject:
	Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=GbK6GWZLlnB9JJvhOK/uBFE25xOoADJEeyIt+/ZpUPU=; b=5/YGty4S2BokmqL8UG3aDHmLMu
	JIx1O+KjNDS8iGdqOlig3ieVgxKXR5L9dOBhygvCsdvZCYkLO72+Rj8mbWB9DLU4hS3e7LZ4sIevw
	GP9sU9bYdvTYighL5mnL6Ey/nX8XoIyBcw7qH9VlMiekGKwstFwVDiWZB8rkNmAP73ohnTPXMHnDp
	BoQJWEqV1FPYHVhbOymHWqZuWy/PrlboyD1xy29k1BAKPZxdNhJDNsA6JlEledbvxJzmta1COx2CE
	7ZucI3wScP4IrzuobX/rnAY2573csoxH+gsX84Ct2WwLY/iHc0fnugCYXDVloc8kW7HLqIkX9cjxO
	QQHcPF2A==;
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Jan 2026 17:12:27 +0100
From: wolf@yoxt.cc
To: Niklas Cassel <cassel@kernel.org>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 0/6] misc LPM related fixes
In-Reply-To: <20260112122044.143637-8-cassel@kernel.org>
References: <20260112122044.143637-8-cassel@kernel.org>
Message-ID: <e98be3fdac484ab807e04fe45c3514dd@yoxt.cc>
X-Sender: wolf@yoxt.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: wolf@yoxt.cc

On 2026-01-12 13:20, Niklas Cassel wrote:
> Hello there,
> 
> we had a recent bug report on the mailing list related to LPM, which 
> made
> me review the LPM related code.
> 
> While doing so, I found some issues. This series fixes those issues.
> 
> The most serious issue is that ATA_QUIRK_NOLPM was not getting applied 
> for
> ATAPI devices and that we read the per port area for unimplemented 
> ports,
> even though the AHCI specification explicitly forbids this.
> 
> 
> Kind regards,
> Niklas
> 
> 
> Changes since v1:
> -Fixed typos in commit messages
> -Split early return patch into two, so that they only have a single
>  Fixes-tag each.
> -Reordered patches to make it easier to only apply the important ones
>  for the current v6.19 kernel.
> 
> 
> Niklas Cassel (6):
>   ata: ahci: Do not read the per port area for unimplemented ports
>   ata: libata: Call ata_dev_config_lpm() for ATAPI devices
>   ata: libata-sata: Improve link_power_management_supported sysfs
>     attribute
>   ata: libata: Add cpr_log to ata_dev_print_features() early return
>   ata: libata: Add DIPM and HIPM to ata_dev_print_features() early
>     return
>   ata: libata: Print features also for ATAPI devices
> 
>  drivers/ata/ahci.c        | 10 +++++-----
>  drivers/ata/libata-core.c |  8 +++++++-
>  drivers/ata/libata-sata.c |  2 +-
>  3 files changed, 13 insertions(+), 7 deletions(-)
> 
> 
> base-commit: 97e01439e902b743b8f89497e9c144e3ddda5e59

Tested-by: Wolf <wolf@yoxt.cc>
