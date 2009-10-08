From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2] ata: New PATA driver for Altera CompactFlash.
Date: Thu, 8 Oct 2009 14:12:41 +0100
Message-ID: <20091008141241.550a09bd@lxorguk.ukuu.org.uk>
References: <1254967110-3495-1-git-send-email-thomas@wytron.com.tw>
	<20091008105503.6ce414f5@lxorguk.ukuu.org.uk>
	<4ACDCB6E.4040905@mev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758133AbZJHNMJ@vger.kernel.org>
In-Reply-To: <4ACDCB6E.4040905@mev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Abbott <abbotti@mev.co.uk>
Cc: Thomas Chou <thomas@wytron.com.tw>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Nios2 development list <nios2-dev@sopc.et.ntust.edu.tw>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ian Abbott <ian.abbott@mev.co.uk>
List-Id: linux-ide@vger.kernel.org

On Thu, 8 Oct 2009 12:22:22 +0100
Ian Abbott <abbotti@mev.co.uk> wrote:

> On 08/10/09 10:55, Alan Cox wrote:
> > On Thu,  8 Oct 2009 09:58:30 +0800
> > Thomas Chou <thomas@wytron.com.tw> wrote:
> > 
> >> This patch adds a new PATA driver to support the Altera SOPC Builder
> >> CompactFlash component as a PATA device with support for insertion
> >> and removal of CF cards.  It uses the platform driver model.
> > 
> > Can you explain why you remove the interface rather than the device on
> > the interface when you detect a card removal ?
> 
> As the originator of the driver, the only answer I have is "I don't know
> how."  I was hoping for inspiration from some of the other PATA CF
> drivers, but alas, I couldn't find it.  I admit that removing the whole
> ATA host is a bit on the extreme side.

I think the bit you want is something like:

	struct ata_eh_info *ehi = &ap->link->eh_info;
	if (mumblemumble & whatever) {
		ata_ehi_clear_desc(ehi);
		ata_ehi_hotplugged(ehi);
		ata_ehi_push_desc(ehi, "CF connection changed");
		ata_port_freeze(ap);
	}

The core code also assumes your freeze method will mask any further
connection change reports until the port is unfrozen (so you don't get
multiple parallel "in/out/in/out" events at once)

Alan
