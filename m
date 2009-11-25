From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 24/86] pata_cs5520: remove dead VDMA support
Date: Wed, 25 Nov 2009 17:28:46 +0000
Message-ID: <20091125172846.289e739b@lxorguk.ukuu.org.uk>
References: <20091125170218.5446.13513.sendpatchset@localhost>
	<20091125170511.5446.43970.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759443AbZKYR0q@vger.kernel.org>
In-Reply-To: <20091125170511.5446.43970.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, 25 Nov 2009 18:05:11 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] pata_cs5520: remove dead VDMA support
> 
> It has been dead for the last three years (== since the initial driver
> merge) and probability that it will ever get fixed is quite low.

Agreed entirely. SIL680 VDMA might be worth doing and in turn CS5520 in
passing but CS5520 is mostly an ex-chip
