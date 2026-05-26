Received: from server-g12.dreschner.net (server-g12.dreschner.net [159.195.37.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC913C063A
	for <linux-ide@vger.kernel.org>; Tue, 26 May 2026 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.195.37.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779821767; cv=none; b=oayPkwE+4yn7/bvpGgJQ40dvimUbAd24+rvOurh3mPIQhudftJKi2e+gvLzAzsGKjU/A/MPjUHOnDmtB7Mclapj7rS1nYJQ0cMxjRZvN0y8OR9Qq6QZVwrVX5d9R8+VogYh2DViyEuD/L5bwl6pjVAJZZESQaqbC6Km3vpvnCzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779821767; c=relaxed/simple;
	bh=bUoM9rW0L8buY09Zm8cDVWrYGuyW8lVNUWvBvrlfEQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NnzqecFiE4O85vLKVnZQutR2XXnblQpFjBu2I58E4TEAgOe0aiapb8eYNMhXchzicwJr6GhRmzfT+CNlVqZNilRbwrDeSxVh0BE3hjVaeHj8q97i0A5o9eELTbRNrXgb4Mjjoo1fc/bAFMB9oUS3PGXTtBKjt7zMxgo+PGxMjPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dreschner.net; spf=pass smtp.mailfrom=dreschner.net; dkim=pass (4096-bit key) header.d=dreschner.net header.i=@dreschner.net header.b=JPDUIlUt; arc=none smtp.client-ip=159.195.37.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dreschner.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dreschner.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=dreschner.net header.i=@dreschner.net header.b="JPDUIlUt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dreschner.net;
	s=202602; t=1779821274;
	bh=bUoM9rW0L8buY09Zm8cDVWrYGuyW8lVNUWvBvrlfEQ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JPDUIlUtlJ+iWQgDl1BS8h4E5JWFRpmfDlb+ltFPMuxNgp8FpwooQBuIK3WQvikHU
	 ZT5Ij6z1/wnXCxEZ1VPW9VeBJ4sRy8XSTlZxPyDqbxE6tYOy4MkPIhfyTNkD/YBFW4
	 7tzdooxeNJ/jz2svNlyIPrdStggyxQXw7/QI7A4PupBeH+ePssD0B2MMVJ/edJvQj8
	 aipiDxNzELdIpGRMOMZgyFGhYGb1/CVShZWHIrxIRfO0GjjH9gyNQGpLeTYsq/D3wa
	 g8wB5ZlcU+Xw01LXcoOBm5MIn0YU6HxK0ldMkKM5xlGgaxkxZnzt3ZFGJqDeSySL9o
	 PZeD33VAaPKAxxFhZqUOMJnJ7hcF7cMWdAT57UxC4XbnQdKl1G28nEcdvX8tLn0dY3
	 Uw+LDsri376y/ffUrBV4DioY7jrSRlZyPWILoCpKLEupM7OeEcSW8zN3cgbZcesau9
	 utVJxQDZ/AAibaKLx2inma7qBRXmN5eVjPHj4rIgS0uhDb2jjF7CLJhpPRDYi6PJdn
	 J70X0NiBnctDD7aC6RmQjsZzf/QoQbdbk9UXVtQsIWzInAv31HxuzUuyszEo/mXqbj
	 XYaVN1SYsBVoh18t1k+s9UO/n7u+GoEOOfgXqkS2l2I8gFPzMYI3gc85EJySZsnLtC
	 DVPXESVqZlT1R54buGe0IyCg=
Received: from [192.168.100.208] (p5dc2d49d.dip0.t-ipconnect.de [93.194.212.157])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by server-g12.dreschner.net (Postfix) with ESMTPSA id 3F5535F8CF;
	Tue, 26 May 2026 20:47:54 +0200 (CEST)
Message-ID: <0685a2fa-1c79-4c38-a6c1-39427d65c267@dreschner.net>
Date: Tue, 26 May 2026 20:47:53 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] ata: fix deferred QC handling for port multipliers
To: Niklas Cassel <cassel@kernel.org>, Tommy Kelly <linux@tkel.ly>,
 Damien Le Moal <dlemoal@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 John Garry <john.g.garry@oracle.com>
Cc: linux-ide@vger.kernel.org
References: <20260514073858.1175072-6-cassel@kernel.org>
Content-Language: de-DE, en-US
From: David Dreschner <kernel-2026@dreschner.net>
In-Reply-To: <20260514073858.1175072-6-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Niklas,

thank you very much for fixing the issue!

I tested the first three patches manually on my Debian 13 machine with 
kernel 6.12.90 and can indeed confirm that your patches fixes the issue. 
The fourth patch had some merge-conflicts and were therefore skipped - 
I'm unable to test the changes anyway (my HBA only supports CBS).

Machine: HP MicroServer Gen8
HBA: HP Dynamic Smart Array B120i
Port multiplier: StarTech S322M225R (SATA to 2x M.2 SATA using ASM1092R 
chipset in JBOD mode)

Could you please make sure that the fixes are being backported to all 
versions that contain the faulty commit 0ea84089dbf6? Looks like that is 
necessary for v7.0, v6.18, v6.12 and v6.6.

If not, it would be great to get the fixes at least merged into v6.12, 
as I'm otherwise forced to manually build any new stable kernel that's 
being pushed by the Debian team.

Thanks again and greetings from Germany!
David

On 5/14/26 09:38, Niklas Cassel wrote:
> Hello all,
> 
> Tommy Kelly reported a regression with PMP that use CBS:
> https://lore.kernel.org/linux-ide/ce09cc21-a8e9-4845-b205-35411e22fba9@tkel.ly/
> 
> It turns out that the ap->excl_link logic used for PMP that use CBS is
> incompatible with the deferred qc issuing via a workqueue.
> This is fixed in patch 3/4.
> 
> While looking at the code, it turns out that the deferred qc issuing via
> workqueue is misdesigned. It assumed that we can't mix NCQ and non-NCQ
> commands on the same port. The limitation is that you can not mix NCQ and
> non-NCQ commands on the same drive. However, with a PMP with FBS, you can
> issue (mixed NCQ and non-NCQ commands) to the different drives. Thus, move
> the saved deferred QC from struct ata_port to struct ata_link. This is
> fixed in patch 4/4.
> 
> 
> Changes since v4:
> -Fix ATA_DEFER_LINK_EXCL to use the correct goto label. While refactoring,
>   I accidentally used the wrong label goto defer_qc instead of goto free_qc,
>   which of course broke PMP CBS in v4.
> 
> 
> Niklas Cassel (4):
>    ata: libata-scsi: improve readability of ata_scsi_qc_issue()
>    ata: libata-scsi: do not use the deferred QC feature for
>      ATA_DEFER_PORT
>    ata: libata-scsi: do not use the deferred QC feature on PMPs with CBS
>    ata: libata-scsi: do not needlessly defer commands when using PMP with
>      FBS
> 
>   drivers/ata/libata-core.c |  9 ++--
>   drivers/ata/libata-eh.c   |  8 ++--
>   drivers/ata/libata-pmp.c  | 18 +++++++-
>   drivers/ata/libata-scsi.c | 89 +++++++++++++++++++++++----------------
>   drivers/ata/sata_sil24.c  |  6 ++-
>   include/linux/libata.h    |  7 +--
>   6 files changed, 87 insertions(+), 50 deletions(-)
> 
> 
> base-commit: 0926c1b731b73e7296e4ad4f7d055918e16ae6ab

