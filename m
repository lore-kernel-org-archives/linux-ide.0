From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 03/10] ata: ahci_brcmstb: add support 40nm platforms
Date: Mon, 26 Oct 2015 10:47:27 -0700
Message-ID: <20151026174727.GZ13239@google.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
 <1445564663-66824-4-git-send-email-jaedon.shin@gmail.com>
 <20151023212558.GS13239@google.com>
 <DE776F55-6D75-4AD7-B3AA-52E45C9D99C0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:32769 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbbJZRra (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Oct 2015 13:47:30 -0400
Content-Disposition: inline
In-Reply-To: <DE776F55-6D75-4AD7-B3AA-52E45C9D99C0@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org, Linux MIPS Mailing List <linux-mips@linux-mips.org>, devicetree@vger.kernel.org

Hi Jaedon,

On Sat, Oct 24, 2015 at 01:50:54PM +0900, Jaedon Shin wrote:
> On Oct 24, 2015, at 6:25 AM, Brian Norris <computersforpeace@gmail.com> wrote:
> > On Fri, Oct 23, 2015 at 10:44:16AM +0900, Jaedon Shin wrote:
> > So, your patch gets phy control 1 correct for both ports, but it doesn't
> > get phy control 2 correct. (Or at least, even if my guess at the 40nm
> > layout is wrong, your patch makes "port 0, phy control 2" collide with
> > "port 1, phy control 1", which is most certainly a bug.)
> > 
> > Are you sure you're testing this properly? Did you try using both ports
> > at the same time? And please, apply the same scrutiny to the PHY driver.
> > (e.g., did you test SSC? did you test both ports?)
> > 
> > Brian
> > 
> 
> You are right. This must be changed. 
> 
> I found the 28nm chipsets have four phy interface control registers. But, 
> the the 40nm chipsets have only three registers. I did not testing with 
> two ports at the same time. It seems we should check more.

OK. So you don't just need more testing, you need to make sure the code
actually matches the documentation at all. If there are only 3 PHY
control registers for 40nm, then this driver (as patched by you) doesn't
make any sense. It will need a much different patch than what you gave.

Brian
