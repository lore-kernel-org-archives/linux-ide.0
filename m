From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 18/19] ide: add ide_use_fast_pio() helper
Date: Fri, 12 Jan 2007 10:08:36 +0000
Message-ID: <20070112100836.58738dbc@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
	<20070112042800.28794.95095.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161051AbXALJ5P@vger.kernel.org>
In-Reply-To: <20070112042800.28794.95095.sendpatchset@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Fri, 12 Jan 2007 05:28:00 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> [PATCH] ide: add ide_use_fast_pio() helper
> 
> * add ide_use_fast_pio() helper for use by host drivers
> * add DMA capability and autodma checks to ide_use_dma()
>   - au1xxx-ide/it8213/it821x drivers didn't check for (id->capability & 1)

For the IT8211/2 in SMART this check shouldn't be made.

>   - ide-cris driver didn't set ->autodma

You've changed the behaviour there. Should the default be autodma=0 ?
