Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6127B304BCB
	for <linux-ide@vger.kernel.org>; Mon, 31 Aug 2026 07:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160250; cv=none; b=YkkRPu5R+DhZWiUuSNqD3wpHLBl2hmZUIJoAw/F02J9xjGK0PIvcn3Ekx+Alb53LTcQcxHfzXAU5nF/300BqcJnulAEigRtKww0PBhq1VNN7OvNz6O9Ug6r93ISMe3i3Z9PYWPyw5GYuCOYb9NnzL2Xh2Ln+0+FuIJs8IXl0Wn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160250; c=relaxed/simple;
	bh=xt/mBfpbbcqpSuW7Tixz3bOlBlQlkIZuSy6W83eTbIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alChQuxLv14xfVmzxfGZiRhKU7vIK6LF+cRYZtc2TqSc2njILcZnA9tE+LbxCVqtyaRlXcyex9sXwMXGUwGqnvu5UQrcBy2wJ0+tQ2ZPHK/9ZxYLWtg2V/tuHfqpI5sr+m4hukId21j8FucbXGtVhYTC/6CuPLh2MeYSSVj6ZzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsgD6YVu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsgD6YVu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADABF1F000E9;
	Mon, 31 Aug 2026 07:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788160249;
	bh=ZMpSrB0AL6ShOxPTmfu14SRl5VPfjTs8eAFYg14m40o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MsgD6YVu1RUQd0xRPNBOuIcH2tRzxaQXGoXGvjqQTb7XlXvfz72k6SOrGARsf1f7E
	 8n+QRApJNKq6LD1pvkD54z5xvzP1BoyYku7bNff1wXVS06bqxsJRr7dQRMlbD8Uoe8
	 yke7SzSOrBCVXoAx4vo6xJNtMw2ZmgTXASKf+g+BZ4Dg6XZHXvLtaf4SKxYPaSNLIV
	 JyJAqPVoWABXQ+o6CcHGRPbmyaIiISL2K5EGkUMvZ14X1gsN0MnQSxFp9t6g/9LoOs
	 WPWpL6GMgP1/yHEvB3ZMDYIwVNPluzALuBHQjnwWM3vjzbH5Uz/H4JLtSI9FtYp6KP
	 +OrrXwSIdnxpw==
Date: Mon, 31 Aug 2026 09:10:44 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: Hajo Noerenberg <hajo-linux-ide@noerenberg.de>,
	linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	risc4all@yahoo.com
Subject: Re: [PATCH v2] ata: ahci: work around lost interrupts on Marvell
 88SE61xx
Message-ID: <apUo9Jc2f61cH4WE@ryzen>
References: <3d72cab2-d491-4e86-8e69-a735242ec862@noerenberg.de>
 <20260828190452.ic5j5bdnnbx2hs4f@pali>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260828190452.ic5j5bdnnbx2hs4f@pali>

On Fri, Aug 28, 2026 at 09:04:52PM +0200, Pali Rohár wrote:
> On Friday 28 August 2026 09:05:21 Hajo Noerenberg wrote:
> > ahci_single_level_irq_intr() services the ports first and clears the
> > global HOST_IRQ_STAT afterwards, as recommended by AHCI 1.1 section
> > 10.6.2.  The Marvell 88SE6111/6121/6145 family stops reporting interrupts
> > for a port when HOST_IRQ_STAT is cleared while PxIS still holds bits:
> > PxIS keeps its content, HOST_IRQ_STAT reads back as 0, the port is never
> > looked at again, and the command in flight only ends in a timeout.
> > 
> > Measured on a Seagate Blackarmor NAS440 (Marvell 88F6281 Kirkwood,
> > 88SE6121 rev B2 behind PCIe) by polling the AHCI registers from userspace
> > while an IDENTIFY was outstanding:
> > 
> >   t=303.046  irqs 127  PxIS 0x00000000  PxCI 0x00000001
> >              IDENTIFY issued
> >   t=303.057  irqs 128  PxIS 0x00000020  PxCI 0x00000000
> >              CI cleared, DPS set, one interrupt taken
> >              ... PxIS stays 0x00000020, HOST_IRQ_STAT stays 0 ...
> >   t~308.05   qc timeout after 5000 msecs
> > 
> > The command had completed - PxCI was clear and PxIS had DPS set - so
> > ahci_qc_complete() would have completed it.  It never got the chance
> > because the handler read HOST_IRQ_STAT as 0 and returned IRQ_NONE.
> > 
> > Marvell's own driver for these chips clears the two registers in the
> > opposite order and says so ("clear global before channel"), and
> > ahci_xgene handles its broken edge latch the same way.  Since the
> > reordering costs at most one spurious interrupt per valid one on
> > conforming controllers, do it in a private interrupt handler selected for
> > board_ahci_mv instead of changing libahci for everyone.
> > 
> > With this applied, SATA-2 and SATA-3 disks work at 3.0 Gbps on the
> > 88SE6121 without the drive-side 1.5 Gbps jumper that was needed before.
> > Time from link up to a successful IDENTIFY:
> > 
> >   WDC WD5000AADS-00S9B0  port 0    7 ms  (never identified before)
> >   WDC WD3202ABYS-01B7A0  port 1   28 ms
> >   WDC WD30EFRX-68EUZN0   port 1  200 ms  (3 TB, HPA detection ok)
> > 
> > Only the 88SE6121 was tested; board_ahci_mv also covers the 88SE6145,
> > which Marvell's driver treats identically.
> > 
> > Link: https://lore.kernel.org/linux-ide/db6b48b7-d69a-564b-24f0-75fbd6a9e543@noerenberg.de/
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216094
> > Signed-off-by: Hajo Noerenberg <hajo-linux-ide@noerenberg.de>
> 
> Thank you for successfully addressing this issue after working on it for
> a longer time.  It is very nice to see a successful story at the end.
> 
> For me the change looks good.
> 
> Acked-by: Pali Rohár <pali@kernel.org>
> 
> As this change is fixing the support for more disks, I would suggest to
> backport this change also into older kernels, ideally by cc: stable
> line (so it would be automatic).


This patch does not apply.

Looking at the line numbers, this patch looks like it is based on some ancient kernel.

Please:
1) Rebase patch on top of 7.3-rc1
2) Add Cc: stable@vger.kernel.org
3) Add Fixes: cd70c26617f4 ("[libata] AHCI: Add support for Marvell AHCI-like chips (initially 6145)")


Tip: if you use:
$ git format-patch --base=HEAD~ -1

the SHA1 that your patch is based on will be included in the patch trailer.


Kind regards,
Niklas
