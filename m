From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 16/86] pata_efar: MWDMA0 is unsupported
Date: Wed, 25 Nov 2009 17:25:52 +0000
Message-ID: <20091125172552.6817e3da@lxorguk.ukuu.org.uk>
References: <20091125170218.5446.13513.sendpatchset@localhost>
	<20091125170415.5446.15073.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759363AbZKYRXv@vger.kernel.org>
In-Reply-To: <20091125170415.5446.15073.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, 25 Nov 2009 18:04:15 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] pata_efar: MWDMA0 is unsupported
> 
> MWDMA0 timings cannot be met with the PIIX based controller
> programming interface.

The efar documentation makes no reference to not being capable of MWDMA0,
so where does this come from ? No MWDMA0 is an Intel erratum it appears.
