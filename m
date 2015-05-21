From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 0/5] AHCI and SATA PHY support for Broadcom STB SoCs
Date: Thu, 21 May 2015 18:01:38 -0400
Message-ID: <20150521220138.GG4914@htj.duckdns.org>
References: <1431473303-18873-1-git-send-email-computersforpeace@gmail.com>
 <555DDC2B.1040608@ti.com>
 <20150521220050.GF4914@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:36323 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755414AbbEUWBn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 May 2015 18:01:43 -0400
Content-Disposition: inline
In-Reply-To: <20150521220050.GF4914@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Brian Norris <computersforpeace@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Kevin Cernekee <cernekee@gmail.com>

On Thu, May 21, 2015 at 06:00:50PM -0400, Tejun Heo wrote:
> Hello,
> 
> On Thu, May 21, 2015 at 06:52:51PM +0530, Kishon Vijay Abraham I wrote:
> > I'll pick "[PATCH v3 2/5] Documentation: devicetree: add Broadcom SATA PHY
> > binding" and
> > "[PATCH v4] phy: add Broadcom SATA3 PHY driver for Broadcom STB SoCs"
> > in the linux-phy tree.
> 
> Applying patch 5 to libata/for-4.2.  If more need to go through
> libata, please let me know.

lol not patch 5, the following one.  Sorry.

[PATCH v3 3/5] ata: add Broadcom AHCI SATA3 driver for STB chips

-- 
tejun
