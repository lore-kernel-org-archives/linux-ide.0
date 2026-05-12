Received: from mail.tkel.ly (mail.tkel.ly [149.248.17.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC4D19E7F7
	for <linux-ide@vger.kernel.org>; Tue, 12 May 2026 00:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.248.17.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778545519; cv=none; b=B9lNFLFFnrtOAT/MvbZUd8V3Iuti6ojUo4ouM7Ox4g66D1NOwMyqss9zUyKB52Ekm4LMBiQgAkkN5N79KH/702ti98QXybAMGyfIeGMG1CHT8fFHfBisXpFuHTMkFSyLEmxfcsKv/ieezbYp6qCT226ItUjFwlHxOLWyldn/Wzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778545519; c=relaxed/simple;
	bh=U/8aOgfDIBgWXykvksu0r/UVreCdFGr4b9qFjQc/KtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEhX2PQu2nFLz7Y/QRMFRa3Z0krKXXY5Jo4tdYpUrJ0TJMgP0XryoEWcNHpGLgHzySaZKcFNcOBMkz6UBHi7L6IP8tnOvtsMcw87dk81Tyz0xs1nPOPgPBeljy8a+xN+vFhvlqEc9lRkAbdN/h14r+0I31bHDEvI3m5QDROuANw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkel.ly; spf=pass smtp.mailfrom=tkel.ly; dkim=pass (2048-bit key) header.d=tkel.ly header.i=@tkel.ly header.b=tet9tBjN; arc=none smtp.client-ip=149.248.17.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkel.ly
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkel.ly
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkel.ly header.i=@tkel.ly header.b="tet9tBjN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkel.ly; s=mail;
	t=1778545511; bh=U/8aOgfDIBgWXykvksu0r/UVreCdFGr4b9qFjQc/KtY=;
	h=Subject:To:Cc:References:From:In-Reply-To;
	b=tet9tBjNO7FW2+QrQ4pabOWW4vjjBG86kE/Whxr2RAGoXYi9GTBeiMQxYQflEkhBe
	 0er6C2uKaKhnLlqEf4nrV2SNILWwroheqEfF+DUjK1sDEwZ7TcR9fTGGapje8unZ1A
	 gtc4uCqHT+O1vE/TUtZ725qAvvikopM3dD4lOOTT2AoKoXLbbsXvOacV35sxPFVNyC
	 3r6ciIV/j4T6sxFPusEEGH0R966ofvMpQLWzkgdeyOTCLstmKSJcuHeLuYaS8UtGAm
	 rnQSzd8SCZvHG3fHwu9ejcw+uOsRrS1WVKfGHTBIq4LkESY/E5fK71pNXaC00cpAZM
	 6NscYXBXi9uOg==
Message-ID: <6e98f088-abb2-4b82-9921-52a712a274da@tkel.ly>
Date: Mon, 11 May 2026 17:25:05 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/2] ata: fix deferred QC handling for port multipliers
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 John Garry <john.g.garry@oracle.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20260508195051.188207-4-cassel@kernel.org>
Content-Language: en-US
From: Tommy Kelly <linux@tkel.ly>
In-Reply-To: <20260508195051.188207-4-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/26 12:50, Niklas Cassel wrote:
> Hello all,
> 
> Tommy Kelly reported a regression with PMP that use CBS:
> https://lore.kernel.org/linux-ide/ce09cc21-a8e9-4845-b205-35411e22fba9@tkel.ly/
> 
> It turns out that the ap->excl_link logic used for PMP that use CBS is
> incompatible with the deferred qc issuing via a workqueue.
> This is fixed in patch 1/2.
> 
> While looking at the code, it turns out that the deferred qc issuing via
> workqueue is misdesigned. It assumed that we can't mix NCQ and non-NCQ
> commands on the same port. The limitation is that you can not mix NCQ and
> non-NCQ commands on the same drive. However, with a PMP with FBS, you can
> issue (mixed NCQ and non-NCQ commands) to the different drives. Thus, move
> the saved deferred QC from struct ata_port to struct ata_link. This is
> fixed in patch 2/2.
> 
> 
> Changes since v1:
> -Avoid a local variable in sata_pmp_qc_defer_cmd_switch(), call
>  ata_std_qc_defer(qc) inside the switch() directly instead.
> -Fix a typo, such that the the code actually compiles... Sorry for that.
> 
> 
> Niklas Cassel (2):
>   ata: libata-scsi: do not use the deferred QC feature on PMPs with CBS
>   ata: libata-scsi: do not needlessly defer commands when using PMP with
>     FBS
> 
>  drivers/ata/libata-core.c | 16 ++++---
>  drivers/ata/libata-eh.c   |  8 ++--
>  drivers/ata/libata-pmp.c  | 26 +++++++++--
>  drivers/ata/libata-scsi.c | 95 ++++++++++++++++++++++++---------------
>  include/linux/libata.h    |  8 ++--
>  5 files changed, 101 insertions(+), 52 deletions(-)
> 

Hi Niklas,

Interestingly, I got my first warning with the v6.19.12 code.
I run fsck on the PMP drives on boot and during the "check_alloc_info" part, I got

> WARNING: drivers/ata/libata-scsi.c:1677 at ata_scsi_deferred_qc_work+0x84/0x98
> CPU: 0 UID: 0 PID: 157 Comm: kworker/0:1H Tainted: G           OE       6.19.12-200.fc43.aarch64 #1 PREEMPT(voluntary) 
> Hardware name: hardkernel Hardkernel ODROID-M1/Hardkernel ODROID-M1, BIOS 2026.07-rc1-dirty 07/01/2026
> Workqueue: events_highpri ata_scsi_deferred_qc_work
> pc : ata_scsi_deferred_qc_work+0x84/0x98
> lr : ata_scsi_deferred_qc_work+0x50/0x98
> Call trace:
>  ata_scsi_deferred_qc_work+0x84/0x98 (P)
>  process_one_work+0x17c/0x400
>  worker_thread+0x19c/0x328
>  kthread+0x10c/0x128
>  ret_from_fork+0x10/0x20
>
> WARNING: drivers/ata/libata-core.c:5143 at ata_qc_issue+0x34/0x420, CPU#0: kworker/0:1H/157
> CPU: 0 UID: 0 PID: 157 Comm: kworker/0:1H Tainted: G        W  OE       6.19.12-200.fc43.aarch64 #1 PREEMPT(voluntary) 
> Hardware name: hardkernel Hardkernel ODROID-M1/Hardkernel ODROID-M1, BIOS 2026.07-rc1-dirty 07/01/2026
> Workqueue: events_highpri ata_scsi_deferred_qc_work
> pc : ata_qc_issue+0x34/0x420
> lr : ata_scsi_deferred_qc_work+0x68/0x98
> Call trace:
>  ata_qc_issue+0x34/0x420 (P)
>  ata_scsi_deferred_qc_work+0x68/0x98
>  process_one_work+0x17c/0x400
>  worker_thread+0x19c/0x328
>  kthread+0x10c/0x128
>  ret_from_fork+0x10/0x20

Everything else on that boot seemed fine. No crashes or usability issues.

These are the lines that threw warnings:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/ata/libata-scsi.c?h=v6.19.12#n1677
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/ata/libata-core.c?h=v6.19.12#n5143

I haven't been able to reproduce it though, it only happened once.


And now for the latest code: To build, I ran

> git checkout -b fedora-7.0-libata kernel-ark/fedora-7.0 # linux v7.0.4
> git merge libata/for-7.1
> git cherry-pick --empty=drop v7.1-rc1..libata/for-7.1-fixes
> git cherry-pick --empty=drop v7.1-rc1..libata/for-next
> git cherry-pick 5918bf2a17f4689abfb94d341c5240088f8bd16e # FBS support
> b4 shazam 20260508195051.188207-4-cassel@kernel.org # v3 patch series

And the boot worked fine. No observable issues.
I haven't done any perf testing. If you'd instruct me how, I could run perf tests for you.
Maybe not torture tests though because I need the drives to survive. :)

Thank you,
- Tommy


