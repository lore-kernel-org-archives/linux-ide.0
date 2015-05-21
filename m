From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 3/5] ata: add Broadcom AHCI SATA3 driver for STB chips
Date: Thu, 21 May 2015 18:03:18 -0400
Message-ID: <20150521220318.GH4914@htj.duckdns.org>
References: <1431473303-18873-1-git-send-email-computersforpeace@gmail.com>
 <1431473303-18873-4-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:34324 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754853AbbEUWDX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 May 2015 18:03:23 -0400
Content-Disposition: inline
In-Reply-To: <1431473303-18873-4-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Kevin Cernekee <cernekee@gmail.com>

On Tue, May 12, 2015 at 04:28:21PM -0700, Brian Norris wrote:
> Pretty straightforward driver, using the nice library-ization of the
> generic ahci_platform driver.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>

Applied to libata/for-4.2.

Hans, if you see any issues, please let me know.

Thanks.

-- 
tejun
