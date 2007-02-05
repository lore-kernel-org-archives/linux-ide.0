From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] (2.6.20) pata_mpiix: fix PIO setup issues
Date: Mon, 5 Feb 2007 19:00:36 +0000
Message-ID: <20070205190036.68388b4c@localhost.localdomain>
References: <200702052024.57511.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53033 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933289AbXBESrz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 13:47:55 -0500
In-Reply-To: <200702052024.57511.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Mon, 5 Feb 2007 20:24:57 +0300
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Fix clearing/setting the wrong TIME/IE/PPE bits for a slave drive caused by a
> wrong shift count.
> Fix the PIO mode 1 being overclocked by wrongly selecting the fast timing bank.
> Also, fix/rephrase some comments while at it.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Thanks - I've not managed to find an MPIIX with two devices on it yet.

Acked-by: Alan Cox <alan@redhat.com>
