From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 0/5] AHCI and SATA PHY support for Broadcom STB SoCs
Date: Sun, 24 May 2015 20:08:33 -0400
Message-ID: <20150525000833.GF7099@htj.duckdns.org>
References: <1431473303-18873-1-git-send-email-computersforpeace@gmail.com>
 <555DDC2B.1040608@ti.com>
 <20150521220050.GF4914@htj.duckdns.org>
 <20150521220138.GG4914@htj.duckdns.org>
 <20150521220328.GE11598@ld-irv-0074>
 <20150521220430.GI4914@htj.duckdns.org>
 <20150521221306.GF11598@ld-irv-0074>
 <20150521222350.GN4914@htj.duckdns.org>
 <20150521223825.GA27753@ld-irv-0074>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33359 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbbEYAIh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 May 2015 20:08:37 -0400
Content-Disposition: inline
In-Reply-To: <20150521223825.GA27753@ld-irv-0074>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Kevin Cernekee <cernekee@gmail.com>

Hello, Brian.

On Thu, May 21, 2015 at 03:38:25PM -0700, Brian Norris wrote:
> It's possible you're confusing binding documentation with .dts source
> files? The DTS files (arch/*/boot/dts/) go through arch trees. For
> instance, the arm-soc maintainers have a structured process by which
> sub-architecture maintainers track .dts(i) file updates for their
> boards/chips and filter them up to Arnd, Olof, etc., via their separate
> 'dts' branches. That's why Florian took patch 5 to his tree.

Yeah, I think that's why I'm constantly getting confused, so the
binding documentation and actual libata changes through libata and the
rest through arch trees.  Got it.

Thanks for the explanation.

-- 
tejun
