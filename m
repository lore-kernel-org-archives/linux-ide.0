From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: fix out-of-bounds access in pata_oldpiix.c
Date: Fri, 18 Jul 2008 09:55:41 +0100
Message-ID: <20080718095541.6bf01fff@the-village.bc.nu>
References: <488040E4.1090500@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:36470 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858AbYGRJiL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jul 2008 05:38:11 -0400
In-Reply-To: <488040E4.1090500@gmx.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David =?UTF-8?B?TcO8bGxlcg==?= <dave.mueller@gmx.ch>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Fri, 18 Jul 2008 09:06:12 +0200
David M=C3=BCller <dave.mueller@gmx.ch> wrote:

> The "pata_oldpiix" driver in linux-2.6.26 is calling its "set_dmamode=
"=20
> routine also locally, but under different preconditions as the=20
> corresponding call in libata-core.c. This may cause an "out-of-array=20
> bounds" access in "oldpiix_set_dmamode".

This looks wrong adev->dma_mode should never be invalid at this point.
Are you not confusing dma_mask and dma_mode. Can you provide the
backtraces of the failing case and the actual chip variant you are usin=
g ?

Either way the fix is not in oldpiix if this is appearing as 0xFF but i=
n
the core code so NAK

