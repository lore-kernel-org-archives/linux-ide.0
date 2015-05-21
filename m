From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v3 0/5] AHCI and SATA PHY support for Broadcom STB SoCs
Date: Thu, 21 May 2015 15:13:06 -0700
Message-ID: <20150521221306.GF11598@ld-irv-0074>
References: <1431473303-18873-1-git-send-email-computersforpeace@gmail.com>
 <555DDC2B.1040608@ti.com>
 <20150521220050.GF4914@htj.duckdns.org>
 <20150521220138.GG4914@htj.duckdns.org>
 <20150521220328.GE11598@ld-irv-0074>
 <20150521220430.GI4914@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35692 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754866AbbEUWNO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 May 2015 18:13:14 -0400
Content-Disposition: inline
In-Reply-To: <20150521220430.GI4914@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Kevin Cernekee <cernekee@gmail.com>

On Thu, May 21, 2015 at 06:04:30PM -0400, Tejun Heo wrote:
> On Thu, May 21, 2015 at 03:03:28PM -0700, Brian Norris wrote:
> > > [PATCH v3 3/5] ata: add Broadcom AHCI SATA3 driver for STB chips
> > 
> > Thanks. Also, this one?
> > 
> > [PATCH v3 1/5] Documentation: devicetree: add Broadcom SATA binding
> 
> devicetree patches usually haven't gone through libata tho.

Most subsystems take device tree binding patches for their constituent
drivers. And I see you've been merging others:

e35b98849f25 ata: sata_rcar: Add r8a7793 device support
8340bfeb03 ahci: st: Update the ahci_st DT documentation
af64dce4cb3a ahci: st: Provide DT bindings for ST's SATA implementation
a1a205df6ee2 ahci: add support for Hisilicon sata

All have your sign-off / commit stamp.

> Is this
> an exception?

Not that I know of. Where would you like it to go instead?

Brian
