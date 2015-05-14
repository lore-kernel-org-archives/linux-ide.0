From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v3 4/5] phy: add Broadcom SATA3 PHY driver for Broadcom
 STB SoCs
Date: Thu, 14 May 2015 10:42:30 -0700
Message-ID: <5554DE86.8020005@gmail.com>
References: <1431473303-18873-1-git-send-email-computersforpeace@gmail.com> <1431473303-18873-5-git-send-email-computersforpeace@gmail.com> <55533059.6050705@ti.com> <20150513184921.GE11598@ld-irv-0074> <55543837.5030100@ti.com> <20150514173902.GK11598@ld-irv-0074>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33546 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964886AbbENRm5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 May 2015 13:42:57 -0400
In-Reply-To: <20150514173902.GK11598@ld-irv-0074>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Kevin Cernekee <cernekee@gmail.com>

On 14/05/15 10:39, Brian Norris wrote:
> On Thu, May 14, 2015 at 11:22:55AM +0530, Kishon Vijay Abraham I wrote:
>> While sending the next version please also add a
>> MAINTAINERs entry for this driver.
> 
> I think this has it covered, right?
> 
> https://lkml.org/lkml/2015/3/18/932

Kishon, this patch is on its way to arm-soc via a pull request:
http://www.spinics.net/lists/arm-kernel/msg418276.html

this should address your concern. Thanks!
-- 
Florian
