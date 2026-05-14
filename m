Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA7E27FB2E
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2026 02:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778726938; cv=none; b=gFFNniyyhuvhaF9qgI5CJOxiKGUl84vZ7ycOxy/6eX1neX7v7ymzzf99VXrQC4ldMe7EFMlIpL+w6PmG0r0jY1c1upfb09ReDOnPZ7x7BIaVRHYldVfXFtJXuQNHnCQwTMREsJ6WyyjANi4zY8zzEWtxWU9HuwgBcIeUbg5Rp8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778726938; c=relaxed/simple;
	bh=6I50pBj91fFxKSV0EAm2n5WyXD7MbdLN91U0UdQvPlg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QjBpitgFtFRLSjfhaFzkLEZS7xYCFqWjBlRJ4ZWGhd62PxwkF8+MoYcoI1l9o0UDOCnHWLqrKELIr2RkOw/o5GiXkB768MItiqS6LWgyQelL5SxQtRiRj/I7dD4m17Bj6/BB68HzVXdhYu3zZC4HiPtLY3Z4Vv1d1P52BfbcTLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfIeH8RQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfIeH8RQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E1CC19425;
	Thu, 14 May 2026 02:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778726938;
	bh=6I50pBj91fFxKSV0EAm2n5WyXD7MbdLN91U0UdQvPlg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=rfIeH8RQJ/xZMbvpOUMIdfLw0uH/ywxhXs+oLhbbpp2Fhl+oiTqIt6yvoyxEQuiiz
	 5Af3FB1DsOzd4mwr0pjT82g0ARWLrQBFryjQnK6xCShkO77WinETNSeSuj9qyBq9Tb
	 cPYXeExM4de5pfzxj0vGZFjLS3nIBfZeIUcWF1oXqm5vKQSpLGkGBGHVpFEfW2HFun
	 QkEHMvD6vgloyCY8ctPoVeNorBMH9/sikRcxoX1fA/HnpBMPpH5YFa+akXUyAt9/zD
	 h6G7eZURcOc1LxKp4I2WIl8RBlEWS+FQqTc2W90/o0g4UYXVNwcT4g+FbGImYMAK06
	 Zsnw4OgrbC4PA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/6] scsi: scsi_devinfo: add COMPAQ PD-1 multi-LUN
 ATAPI device quirk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Phil Pemberton" <philpem@philpem.me.uk>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260512202728.299414-7-philpem@philpem.me.uk>
References: <20260512202728.299414-7-philpem@philpem.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 02:48:57 +0000
Message-Id: <20260514024858.32E1CC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Inconsistent application of the `BLIST_NO_LUN_1F` quirk for iden=
tical OEM hardware variants.
--

commit ab42e7feb93cffa0988b57200c3b29ed1da7f1c2
Author: Phil Pemberton <philpem@philpem.me.uk>

scsi: scsi_devinfo: add COMPAQ PD-1 multi-LUN ATAPI device quirk

This commit adds a SCSI device quirk for the COMPAQ PD-1 combo drive. It
adds BLIST_FORCELUN, BLIST_SINGLELUN, and BLIST_NO_LUN_1F to ensure
correct LUN scanning and serialize commands on the single transport.

> diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
> index 68a992494b121..bfc2cbd438975 100644
> --- a/drivers/scsi/scsi_devinfo.c
> +++ b/drivers/scsi/scsi_devinfo.c
> @@ -150,6 +150,8 @@ static struct {
>  	{"COMPAQ", "MSA1000", NULL, BLIST_SPARSELUN | BLIST_NOSTARTONADD},
>  	{"COMPAQ", "MSA1000 VOLUME", NULL, BLIST_SPARSELUN | BLIST_NOSTARTONADD=
},
>  	{"COMPAQ", "HSV110", NULL, BLIST_REPORTLUN2 | BLIST_NOSTARTONADD},
> +	{"COMPAQ", "PD-1", NULL, BLIST_FORCELUN | BLIST_SINGLELUN |
> +				 BLIST_NO_LUN_1F},

The commit message notes that the COMPAQ PD-1 is an OEM Panasonic/Matsushita
drive. Since scsi_static_device_list already contains entries for MATSHITA
PD-1 and NEC PD-1 ODX654P which share the same underlying hardware, should
those entries also be updated to include the BLIST_NO_LUN_1F quirk?

Without it, wouldn't the MATSHITA and NEC variants still generate spurious
entries for unpopulated LUNs during scans? For example, the MATSHITA and NEC
entries currently only specify:

    {"MATSHITA", "PD-1", NULL, BLIST_FORCELUN | BLIST_SINGLELUN},
    ...
    {"NEC", "PD-1 ODX654P", NULL, BLIST_FORCELUN | BLIST_SINGLELUN},

>  	{"DDN", "SAN DataDirector", "*", BLIST_SPARSELUN},
>  	{"DEC", "HSG80", NULL, BLIST_REPORTLUN2 | BLIST_NOSTARTONADD},
>  	{"DELL", "PV660F", NULL, BLIST_SPARSELUN},

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512202728.2994=
14-1-philpem@philpem.me.uk?part=3D6
