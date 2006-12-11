From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata_piix: use piix_host_stop() in ich_pata_ops
Date: Mon, 11 Dec 2006 14:19:56 +0000
Message-ID: <20061211141956.5d161c9f@localhost.localdomain>
References: <b0943d9e0612091454j6df1fb0ej2fa006c3fa33abae@mail.gmail.com>
	<20061211132625.GA18947@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52024 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762918AbWLKONL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Dec 2006 09:13:11 -0500
In-Reply-To: <20061211132625.GA18947@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, 11 Dec 2006 22:26:25 +0900
Tejun Heo <htejun@gmail.com> wrote:

> piix_init_one() allocates host private data which should be freed by
> piix_host_stop().  ich_pata_ops wasn't converted to piix_host_stop()
> while merging, leaking 4 bytes on driver detach.  Fix it.
> 
> This was spotted using Kmemleak by Catalin Marinas.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>
