From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_sil680: Only enable MMIO on Cell blades
Date: Tue, 25 Mar 2008 23:49:29 +0000
Message-ID: <20080325234929.7c52d5c6@core>
References: <20080325235112.C29CDDE1D9@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58835 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755785AbYCZAGj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 20:06:39 -0400
In-Reply-To: <20080325235112.C29CDDE1D9@ozlabs.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@ozlabs.org>
Cc: jgarzik@pobox.com, Linux IDE <linux-ide@vger.kernel.org>, linux-kernel@vger.kernel.org

On Wed, 26 Mar 2008 10:50:41 +1100
Benjamin Herrenschmidt <benh@ozlabs.org> wrote:

> There have been reported regressions of the SIL 680 driver when
> using MMIO, so this makes it only try MMIO on Cell blades where
> it's known to be necessary (the host bridge doesn't do PIO on these).
> 
> We'll try to find the root problem with MMIO separately.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Alan Cox <alan@redhat.com>
