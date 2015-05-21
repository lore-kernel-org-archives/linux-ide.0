From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v3 0/5] AHCI and SATA PHY support for Broadcom STB SoCs
Date: Thu, 21 May 2015 15:38:25 -0700
Message-ID: <20150521223825.GA27753@ld-irv-0074>
References: <1431473303-18873-1-git-send-email-computersforpeace@gmail.com>
 <555DDC2B.1040608@ti.com>
 <20150521220050.GF4914@htj.duckdns.org>
 <20150521220138.GG4914@htj.duckdns.org>
 <20150521220328.GE11598@ld-irv-0074>
 <20150521220430.GI4914@htj.duckdns.org>
 <20150521221306.GF11598@ld-irv-0074>
 <20150521222350.GN4914@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36280 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066AbbEUWjQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 May 2015 18:39:16 -0400
Content-Disposition: inline
In-Reply-To: <20150521222350.GN4914@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Kevin Cernekee <cernekee@gmail.com>

I can explain part of this, but I'm curious if anyone else has different
info.

On Thu, May 21, 2015 at 06:23:50PM -0400, Tejun Heo wrote:
> But the rules have never been clear to me.  If the subsystem
> maintainer is okay with it, I'm happy to take the patches.  I'm just
> kinda curious why this doesn't go through devicetree tree while some
> other devicetree patches go through there.

AFAIK, there is no official tree for device tree bindings. There's just
a mailing list and several reviewers, who usually try to help on the big
picture binding review. Note that there's no tree listed in MAINTAINERS
under:

  OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS

But you will see several MAINTAINERS entries for different subdirs of
Documentation/devicetree/bindings/. Maybe you should add one for .../ata
if you're going to continue taking patches?

It's possible you're confusing binding documentation with .dts source
files? The DTS files (arch/*/boot/dts/) go through arch trees. For
instance, the arm-soc maintainers have a structured process by which
sub-architecture maintainers track .dts(i) file updates for their
boards/chips and filter them up to Arnd, Olof, etc., via their separate
'dts' branches. That's why Florian took patch 5 to his tree.

> Can somebody explain the
> overall policy to me?  I'm not looking for some absolute rules and
> exceptions are fine but I do wanna have a general direction.

Brian
