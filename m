Received: from mx.bauer-kirch.com (mx.bauer-kirch.com [217.11.56.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498713016FB
	for <linux-ide@vger.kernel.org>; Tue, 25 Aug 2026 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.11.56.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787644709; cv=none; b=AJ6z8dLBQqVe/JU7G+SKMmpJyLabPQtbknXF3y9EHMgFF2X4rUkhAcqPeVyAdC9150L1pE3XaGdA791SWMnWADm4AZp0JTcvvYDMGXoduvBYz1ZanIC/emCR0a/7GS3GOcohcnKNNShD4FTIvztr6TnGuiPdta2U2EJfm0gu3fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787644709; c=relaxed/simple;
	bh=QhjmY9Oy3AmRqFyNwvvPgwydO7zFCWQyLR697kIMIhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gx6MuXh8/0vkhDclOsG9uvDYzE8ohYUd9VdpMVbVpe7pPNZlHeMtwo3kf9fIE5yqtNjZlecJXbNRYDDiYszWGa++f2uXdo0SSj0QSgLMf3QkfG+bCLKoeo3D64UkqzrB1BUm4n4xc70Z+5v1dZ+uP7ci9eUF5MTgUOLeKS6eMbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noerenberg.de; spf=pass smtp.mailfrom=noerenberg.de; dkim=pass (2048-bit key) header.d=noerenberg.de header.i=@noerenberg.de header.b=p/5UWtxB; arc=none smtp.client-ip=217.11.56.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noerenberg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noerenberg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=noerenberg.de header.i=@noerenberg.de header.b="p/5UWtxB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=noerenberg.de; s=bauerkirch; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eMqmVhWJNAgOENa5/oiCh+CYFRVuPym9kc4Wh1m0MEQ=; b=p/5UWtxBVPIPr0j9LlDhwa3K2S
	N4mOQ92WcubqwPMleSoVVvi/X/XJCrOLVVJQCBUdIi8R8AiCYw8ylZB0gdonIzj9vhsGkmhEC6KOa
	04DpW78MY3+8whdL1vefJWVJJYKVd7xg6K2li3pZ5n6bZhriBTsMeip1eYvX0eEmFjDbil/FkN9kE
	9ONbzWlciPUz+jMYfE8zxnMx4dqlTQmwYUs0sNGuP4uVxRKcJ9cDOG+BMWESVTqfKLfeo746WTnB0
	ux7OY2qYerqOBV+S63SrT3GTj+uE22qkt/S7XffxDV7ZTpDUM9OmkTHQ7q8swHfXTChxbLBbVkrwj
	CfUJ1JgQ==;
Received: by mail.bauer-kirch.de with ESMTPSA id 1wym2y-000000028eV-3yAT
	authenticated id <420001312>
	(TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128);
	Tue, 25 Aug 2026 09:58:17 +0200
Message-ID: <ed203607-19a9-4dd3-89b2-ba94b1bde4c0@noerenberg.de>
Date: Tue, 25 Aug 2026 09:58:15 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci: clear HOST_IRQ_STAT before the ports on
 Marvell 88SE61xx
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Cc: Pali Rohar <pali@kernel.org>, risc4all@yahoo.com
References: <50ebd35a-086f-40fb-887e-576e36e7a2b8@noerenberg.de>
 <df91dc9a-58a5-49e1-b208-507cb9593cd1@kernel.org>
From: Hajo Noerenberg <hajo-linux-ide@noerenberg.de>
In-Reply-To: <df91dc9a-58a5-49e1-b208-507cb9593cd1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Damien,

thank you for the quick review.

On 8/25/26 02:51, Damien Le Moal wrote:
> The commit title is not great as "before the ports" is not very clear.
> What does "clear the ports" mean? Though I do not have a better alternative
> title (yet).

Agreed, and "the ports" was meant to be the ports' PxIS registers, which the
title does not say.  Would this be better?

  ata: ahci: work around lost interrupts on Marvell 88SE61xx

That names the symptom rather than the mechanism.  Happy to take any other
suggestion.

> This looks very similar to what ahci_thunderx_irq_handler() does, minus the
> loop. That loop does make sense to me though, so shouldn't this be the same?
> Maybe try using that same function to see if it works?
> If it does, we can rename that function to something more generic and reuse it.

I tried exactly that: a build that registers the existing
ahci_thunderx_irq_handler() unchanged for board_ahci_mv, taken out of the
#ifdef CONFIG_ARM64, with a dev_info() so I could be certain which handler was
really active.  It does not work.  The controller fails exactly as it does
without any patch.

Both of the following are from one and the same boot of the same machine, on
the same drive in the same slot, 86 seconds apart.  I only swapped the module
with rmmod/insmod in between, nothing else changed:

  [  853.732695] ahci 0000:01:00.0: TEST BUILD: setting hpriv->irq_handler =
                                    ahci_thunderx_irq_handler
  [  854.155483] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
  [  859.313008] ata6.00: qc timeout after 5000 msecs (cmd 0xec)
  [  859.318692] ata6.00: failed to IDENTIFY (I/O error, err_mask=0x4)
  [  869.808790] ata6.00: qc timeout after 10000 msecs (cmd 0xec)
  [  869.814554] ata6.00: failed to IDENTIFY (I/O error, err_mask=0x4)
  [  869.820702] ata6: limiting SATA link speed to 1.5 Gbps
  [  901.808101] ata6.00: qc timeout after 30000 msecs (cmd 0xec)
  [  901.813867] ata6.00: failed to IDENTIFY (I/O error, err_mask=0x4)

  ... rmmod ahci ; insmod ahci.ko with the patch from this thread ...

  [  940.249339] ahci 0000:01:00.0: version 3.0-mv1
  [  940.661512] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
  [  940.668285] ata9.00: HPA detected: current 5860531055, native 5860533168
  [  940.675076] ata9.00: ATA-9: WDC WD30EFRX-68EUZN0, 80.00A80, max UDMA/133
  [  940.694325] ata9.00: configured for UDMA/133

With the ThunderX handler the drive is given up after 48 seconds and three
timeouts.  With the patch from this thread it is identified 7 ms after link
up.

The reason is that the difference between the two handlers is not really the
loop -- it is the order of the two accesses, and the loop cannot substitute
for it:

  ThunderX:  rc = ahci_handle_port_intr(host, irq_masked);
             writel(irq_stat, mmio + HOST_IRQ_STAT);     /* IS after ports */

  Marvell:   writel(irq_stat, mmio + HOST_IRQ_STAT);     /* IS before ports */
             rc = ahci_handle_port_intr(host, irq_masked);

The 88SE61xx stops reflecting PxIS in IS once IS is written while PxIS still
holds bits.  With the ThunderX order, ahci_handle_port_intr() clears PxIS and
then IS is written; if the device raised a new event in that window, the write
to IS discards the pending indication, and -- this is the part the loop cannot
fix -- the controller never re-asserts it.  The re-read of IS therefore
returns 0, the loop exits, and the completion is lost.  The loop only catches
events that manage to set IS *after* the write, which is precisely the case
that is not broken here.  Clearing IS first means IS is never written while an
unserviced PxIS bit is standing.

So for this chip the ordering is load-bearing and the loop is not.

I think the function this patch resembles is not the ThunderX one but
xgene_ahci_irq_intr() in ahci_xgene.c, which does the same reordering for the
same kind of reason and says so:

  /*
   * HOST_IRQ_STAT behaves as edge triggered latch meaning that
   * it should be cleared before all the port events are cleared.
   */
  writel(irq_stat, mmio + HOST_IRQ_STAT);

  rc = xgene_ahci_handle_broken_edge_irq(host, irq_masked);

That is this patch, except that X-Gene needs a second workaround on top: its
wrapper re-reads HOST_IRQ_STAT and, if it reads back as zero, checks
PORT_IRQ_STAT by hand on the ports that IS did not flag and folds those in.
The 88SE61xx does not need that part -- I tried the equivalent rescan on its
own, without the reordering, and it did not help.  Marvell's own 6121 driver
also clears in this order, with the comment "clear global before channel".

As for sharing the code: a single handler that clears IS first *and* loops
would in theory serve both chips, but I would rather not propose it.  Each of
the three users needs something different -- X-Gene the port rescan, ThunderX
the loop, the 88SE61xx neither -- so the merged version would be a superset
that nobody actually wants, and I would be changing ThunderX behaviour on
hardware I do not have and cannot test.  Keeping the handlers separate, as in
this patch, costs about fifteen duplicated lines and no risk.

For the record, the fix has meanwhile carried a full mdadm RAID10 resync
across four 2 TB drives -- two of them on the 88SE6121, two on the Kirkwood
SoC controller -- with no errors, so it holds up under sustained parallel load
and not just during probe.  All of this on a machine whose SoC was released in
2008 -- eighteen years is a long time to wait for an interrupt :)

Thanks,
Hajo

