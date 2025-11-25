Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32994A21
	for <linux-ide@vger.kernel.org>; Tue, 25 Nov 2025 11:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764070303; cv=none; b=n5jO0jPijoG9FQmrilFipXcD2PxasKD/gto1sh6gwIygwe89lh1bqOC0wbzKI/BRqjwDFYNBVRBjtoUbkk5bM/i1cEp2uylit+J2Q0lLAaaaSWzCuuDMHGt4F1BxY7JtqoZcRDb1ASyhIu7pxxGjNq2gCKv37FUNkfsFLMPlUew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764070303; c=relaxed/simple;
	bh=JPlPz+mOAu+v140CiJGGj3vsogWJ/rc0nPQrnFZSQiU=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pKLZwt8QDkQkIzwEA5GbHUUPjOZCXkCRbvJyQcqgS9NUW1hwJcvWJucBkLfQIC3JTZOrXqeUkEAeqT6/56IHiobzJfMbk3ZZ7LEGsAfGkxbaEqmS6grqW1Wx+v73+OQ++M3whZlAzq7sJwMVzADlasoVCGhhwzJySHtSZjaqi58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=p0DKZo6z; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="p0DKZo6z"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HhSvhc53MOIjoXSLcJL6cmUZIKD1yXehEj8M0Cq3LLI=;
	b=p0DKZo6zFEd8xvDQBIuBxcZDafcP/miVDaw5GVEy54szF4Dr87aw5PgwNYDiihx8YGot7DAJl
	kailgqEKbu/xRGR8ZYjzc6STvNV6tIk502XGP3zmbpYM0bKHqWCDQhHY1By94I/YkfLlO+rV34w
	VoKYqIDbkShhUjuFP6Y2FEs=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dG0pC57XNzcZxk;
	Tue, 25 Nov 2025 19:29:23 +0800 (CST)
Received: from kwepemh200005.china.huawei.com (unknown [7.202.181.112])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D02414022D;
	Tue, 25 Nov 2025 19:31:37 +0800 (CST)
Received: from [10.67.120.126] (10.67.120.126) by
 kwepemh200005.china.huawei.com (7.202.181.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Nov 2025 19:31:36 +0800
Subject: Re: [PATCH] ata: libata-core: Disable LPM on Silicon Motion
 MD619HXCLDE3TC
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
References: <20251124163433.3082331-2-cassel@kernel.org>
CC: <linux-ide@vger.kernel.org>, Yihang Li <liyihang9@h-partners.com>
From: Yihang Li <liyihang9@h-partners.com>
Message-ID: <8850d82e-6818-b67f-9acb-cdfe78b7cedd@h-partners.com>
Date: Tue, 25 Nov 2025 19:31:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251124163433.3082331-2-cassel@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemh200005.china.huawei.com (7.202.181.112)

Hi Niklas,

On 2025/11/25 0:34, Niklas Cassel wrote:
> According to a user report, the Silicon Motion MD619HXCLDE3TC SSD has
> problems with LPM.
> 
> Reported-by: Yihang Li <liyihang9@h-partners.com>
> Closes: https://lore.kernel.org/linux-ide/20251121073502.3388239-1-liyihang9@h-partners.com/
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Hello Yihang Li,
> 
> Please test this patch.

I found that the same issue also exists on another model of drive.
The information is as follows:

# lsblk -o MODEL /dev/sda
MODEL
MD619GXCLDE3TC

# lsblk -o REV /dev/sda
   REV
TCV35D

At the same time, while testing this patch, I found that the issue was not solved.
Therefore, I printed out the model_num and model_rev of MD619HXCLDE3TC SSD and discovered that
the actual model_rev should be "TCVAID" instead of "ID." However, the information obtained using
the `lsblk -o REV /dev/sdX` command showed "ID," and I am not sure why this is the case.

In any case, I suggest that the final modification should look like this, and after testing,
this modification has solved my problem.

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f48fb63d7e85..b721a8db11c4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4216,6 +4216,10 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
        /* Apacer models with LPM issues */
        { "Apacer AS340*",              NULL,   ATA_QUIRK_NOLPM },

+       /* Silicon Motion models with LPM issues */
+       { "MD619HXCLDE3TC",             "TCVAID", ATA_QUIRK_NOLPM },
+       { "MD619GXCLDE3TC",             "TCV35D", ATA_QUIRK_NOLPM },
+

Thanks,
Yihang
