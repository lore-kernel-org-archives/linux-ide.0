From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New driver mtipx2xx submission
Date: Wed, 1 Jun 2011 21:21:29 +0100
Message-ID: <20110601212129.11534c55@lxorguk.ukuu.org.uk>
References: <22A973199D2C2F46933448F6E7990A300204F2BC@ntxboimbx31.micron.com>
	<20110428230605.78c55c70@lxorguk.ukuu.org.uk>
	<22A973199D2C2F46933448F6E7990A300204F728@ntxboimbx31.micron.com>
	<20110502184206.25907c5e@lxorguk.ukuu.org.uk>
	<22A973199D2C2F46933448F6E7990A300214B0D6@ntxboimbx31.micron.com>
	<20110511202013.075b07cc@lxorguk.ukuu.org.uk>
	<4DD722DB.8030303@micron.com>
	<x49lixuyhhs.fsf@segfault.boston.devel.redhat.com>
	<22A973199D2C2F46933448F6E7990A300239EA77@ntxboimbx31.micron.com>
	<x49ipsp9voy.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35329 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758845Ab1FAUTp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Jun 2011 16:19:45 -0400
In-Reply-To: <x49ipsp9voy.fsf@segfault.boston.devel.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]" <asamymuthupa@micron.com>, linux-ide@vger.kernel.org

> Thanks, Asai!  I don't think cfq is the ideal I/O scheduler to be
> testing.  Could you run again with deadline and/or noop and see how that
> changes your throughput and perf report?  Also, just for completeness,
> could you tell us which kernel you ran this against?

How many processors is this system, just looking at the lock contention
which is pretty horrible.

I'd been expecting various red flags in the AHCI/libata/scsi queue code
but it seems at first glance that the block queue stuff is killing us and
the scsi/ata code is a distraction (unless of course its causing a lot of
the lock time)

No-op would be most interesting but the I/O scheduler numbers don't look
pretty.

Alan
