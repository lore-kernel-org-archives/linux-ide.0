From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] sata_via: add VT6421 PATA support
Date: Mon, 4 Dec 2006 15:12:54 +0000
Message-ID: <20061204151254.540ffe43@localhost.localdomain>
References: <45742FFA.6020604@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:57802 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-??-OK-FAIL) by vger.kernel.org with ESMTP
	id S936957AbWLDPHI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Dec 2006 10:07:08 -0500
In-Reply-To: <45742FFA.6020604@wpkg.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

On Mon, 04 Dec 2006 15:26:02 +0100
Tomasz Chmielewski <mangoo@wpkg.org> wrote:

> his patch adds VT6421 PATA support to sata_via.

NAK

This shouldn't be compile time
It doesn't handle MWDMA properly
It uses the old error/reset code

