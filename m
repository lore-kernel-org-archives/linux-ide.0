From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New driver mtipx2xx submission
Date: Tue, 3 May 2011 16:07:25 +0100
Message-ID: <20110503160725.1bd1cc0f@lxorguk.ukuu.org.uk>
References: <22A973199D2C2F46933448F6E7990A300204F2BC@ntxboimbx31.micron.com>
	<20110428230605.78c55c70@lxorguk.ukuu.org.uk>
	<x49oc3lndyu.fsf@segfault.boston.devel.redhat.com>
	<20110502195224.6175bfb0@lxorguk.ukuu.org.uk>
	<4DC0196C.3040309@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44720 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751083Ab1ECPGW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 May 2011 11:06:22 -0400
In-Reply-To: <4DC0196C.3040309@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Jeff Moyer <jmoyer@redhat.com>, "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]" <asamymuthupa@micron.com>, linux-ide@vger.kernel.org

On Tue, 03 May 2011 11:04:12 -0400
Mark Lord <kernel@teksavvy.com> wrote:

> On 11-05-02 02:52 PM, Alan Cox wrote:
> >
> > The queue depth and tag limits come from the SATA standard and also leak
> > fairly comprehensively into the AHCI spec so not unless the hardware has
> > extensions for it and is merely faked SATA (and if you are faking SATA
> > you have to wonder why if your goal is max performance)
> 
> 
> The reason to "fake" SATA and/or ATA is unchanged since the 1990s:
> so that the system BIOS can boot from the device, and the operating system
> can work up to the point where it finally loads hardware-specific drivers.

The BIOS emulation is for legacy IDE style interfaces not AHCI.

Alan
