From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC: 2.6 patch] schedule BLK_DEV_IDE_SATA for removal
Date: Fri, 22 Jun 2007 10:10:19 +0100
Message-ID: <20070622101019.0f3b0d3d@the-village.bc.nu>
References: <20070621235211.GH23017@stusta.de>
	<1182483586.10524.33.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755213AbXFVJGw@vger.kernel.org>
In-Reply-To: <1182483586.10524.33.camel@shinybook.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Fri, 22 Jun 2007 11:39:45 +0800
David Woodhouse <dwmw2@infradead.org> wrote:

> On Fri, 2007-06-22 at 01:52 +0200, Adrian Bunk wrote:
> > Users should use the libata based drivers for SATA drives.
> 
> NAK. Not all IDE drivers are converted yet. Not even all the relatively
> common ones.

All the common SATA ones are. Just the PowerPC people are falling behind.
Really we should obsolete powerpc instead ;)

Alan
