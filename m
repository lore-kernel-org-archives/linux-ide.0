Received: from mail.tkel.ly (mail.tkel.ly [149.248.17.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F01527442
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2026 04:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.248.17.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778733759; cv=none; b=ofGdfQHy17BHw90awL2x4GIACLb0Bt7H9hnyAPvgREznLxkn5nwuLBu4PubLeFl29VUsjMu6vs+lN3I3rpV3Secw3cFHIW54Uonz3O5AIBdffsdv6RAt0aTCLi0EoIhn2PekT6OL8ZUDGVQ9AARi2/1uD1Tc+8+wV65lXWnZmb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778733759; c=relaxed/simple;
	bh=R90sKVVKmgtewPKeHWVUmLxTYKcVvC7nvjpzKnojqdk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BOvRRDQ4OEGssqvp84F3TJKDyeN0qPSsA2W9F7kDuyxLuEZofzq9atg4x+KE/pocyFHxDI3GlG/ZbiDHvgyyYTOt73crTkeXNsXfVpTDjDH7kWnwah66VUgJxkKXJpZpnGvzM/+/u74zRt6dw7LgcBrqw9GtGdocMgzFr0b3gBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkel.ly; spf=pass smtp.mailfrom=tkel.ly; dkim=pass (2048-bit key) header.d=tkel.ly header.i=@tkel.ly header.b=ayIr9Xtk; arc=none smtp.client-ip=149.248.17.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkel.ly
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkel.ly
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkel.ly header.i=@tkel.ly header.b="ayIr9Xtk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkel.ly; s=mail;
	t=1778733758; bh=R90sKVVKmgtewPKeHWVUmLxTYKcVvC7nvjpzKnojqdk=;
	h=Subject:From:To:Cc:References:In-Reply-To;
	b=ayIr9XtkScw7MbIu52rUlHEvzWmIVAp/gnn2g2X5+O1RXYH8oU9ZJorzNARE9tNDE
	 K2iDP2euE4DkNvQ0BzEZQtEh32FjpjSGWoMd+67PXiwlLbJs07LJQfNJt/Qw3doURs
	 UgQcX+NldIiD4uf35uRfy1/NjVut8b6lJGlmV4kMafz3cUA2OCbTerx8CDhLZSqX9Y
	 TGb6pPjmixvrbkTifp8dSayVDflD02UQoi0Jh2BhKTKqbc00ucVV1R2MrJT9AlI70Y
	 ZDWRA4r/jg0EhWMQbi2r8w//4bM4q+0qEnptvjpyonSbzpUpZBTm/NhTSeSJZaIkaR
	 tZhcxatr+DW7g==
Message-ID: <4b37d9a7-0083-4bb6-ba38-cc243afe0305@tkel.ly>
Date: Wed, 13 May 2026 21:42:35 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/4] ata: fix deferred QC handling for port multipliers
From: Tommy Kelly <linux@tkel.ly>
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20260513151359.1075403-6-cassel@kernel.org>
 <5ef17ab9-5941-4268-b537-9e4f6cf7e602@tkel.ly>
Content-Language: en-US
In-Reply-To: <5ef17ab9-5941-4268-b537-9e4f6cf7e602@tkel.ly>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/26 21:09, Tommy Kelly wrote:
>
> The second boot, I got the libata-scsi warning in the exact same spot, right at the beginning of fsck. Same call trace.
> 
>> bcachefs: accounting_read... done (0 seconds)
>> WARNING: drivers/ata/libata-scsi.c:1682 at ata_scsi_deferred_qc_work+0x88/0x98
> 
> Fsck completed without issue. The filesystem was mounted.
> Then this smartd error log showed up for the first (and only) time.
> 
>> smartd[1045]: Device: /dev/sdd [SAT], no ATA CHECK POWER STATUS support, ignoring -n Directive
> 
> Then, some power issue(?) caused the system to go read-only and I can't debug
> anything because I can't execute any programs. This has happened in the past a
> few times. The system crashes after a few minutes in this state. No logs are
> available because the log system fails. Unsure if its related to these patches
> but seems to happen when I build my own kernels. For these CBS tests I'm using the
> unpatched fdt from u-boot v2026.04.
> My root/boot filesystems are on an nvme drive, not the SATA PMP.
Hi again,

Quick followup.
I reinstalled u-boot + devicetree FBS patch, booted into Linux v7.1-rc3 + v4 patchset.
And I got the full system failure again. Unable to run any commands.
My root filesystem is btrfs on NVMe.
It happened 6 minutes after fsck completed and the system was running normally without any error logs.
I went and plugged in the UART cable and got a few logs this time from the serial terminal. 

> U-Boot 2026.07-rc2-dirty
> kernel: Linux version 7.1.0-0.rc3.1d5dcaa3bd65.25.test.fc44.aarch64
> [ 1539.481926] BTRFS error (device nvme0n1p4 state EA): run_delalloc_nocow failed, root=5 inode=103820306 start=274432 len=4096 cur_offset=274432 oe_cleanup=274432 oe_cleanup_len=0 untouched_start=274432 untouched_len=4096: -5
> [ 1539.483785] BTRFS error (device nvme0n1p4 state EA): failed to run delalloc range, root=5 ino=103820306 folio=274432 submit_bitmap=0 start=274432 len=4096: -5
> [ 1596.136409] systemd-journald[800]: Failed to rotate /var/log/journal/c5b05402ed674946a0b721d8b2c649d1/system.journal: Read-only file system (Dropped 122276 similar message(s))

Those 2 `BTRFS error` lines repeated over and over every couple seconds.

This one seems to happen randomly, unable to reproduce consistently.
No idea why its happening.
But it has happened with both patched and un-patched u-boot devicetree.

Thanks,
Tommy
