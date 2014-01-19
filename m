From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC v3 09/13] ARM: sunxi: Add support for Allwinner SUNXi
	SoCs sata to ahci_platform
Date: Sun, 19 Jan 2014 19:56:42 +0000
Message-ID: <20140119195642.GU15937@n2100.arm.linux.org.uk>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com> <1390088935-7193-10-git-send-email-hdegoede@redhat.com> <20140119122216.GM15937@n2100.arm.linux.org.uk> <52DC2282.4040702@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:41968 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751878AbaAST4w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Jan 2014 14:56:52 -0500
Content-Disposition: inline
In-Reply-To: <52DC2282.4040702@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-ide@vger.kernel.org, Oliver Schinagl <oliver@schinagl.nl>, Richard Zhu <Hong-Xing.Zhu@freescale.com>, linux-sunxi@googlegroups.com, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org

On Sun, Jan 19, 2014 at 08:07:46PM +0100, Hans de Goede wrote:
> Hi,
>
> On 01/19/2014 01:22 PM, Russell King - ARM Linux wrote:
>> On Sun, Jan 19, 2014 at 12:48:51AM +0100, Hans de Goede wrote:
>>> +	timeout = 0x100000;
>>> +	do {
>>> +		reg_val = sunxi_getbits(reg_base + AHCI_PHYCS0R, 0x7, 28);
>>> +	} while (--timeout && (reg_val != 0x2));
>>> +	if (!timeout) {
>>> +		dev_err(dev, "PHY power up failed.\n");
>>> +		return -EIO;
>>> +	}
>>
>> This is not a good way to detect failure - there's several things wrong
>> here.
>>
>> First, how long does sunxi_getbits() take?  What does that depend on?
>> Therefore, how long does it take to time out?
>
> You're interpreting the timeout in the above code as an actual timeout, but
> that is not what it is, it is a means to avoid looping forever if something
> is seriously amiss. The only time I've ever seen the timeout trigger is when
> I forgot to enable some clks iirc.
>
> I can rename the variable from timeout to max_tries to make this more clear.
>
>> Secondly, what if the success condition becomes true at the same time that
>> a timeout occurs?
>
> We should never get anywhere near timeout becoming 0, so if both happen at
> the same time, then something is pretty seriously broken and the returning of
> an error as the code does now is the right thing to do.

Yes... and if we look back in history, there's been lots of stuff just
like this where the loop has had to have the number of iterations
increased as CPUs have become faster and compilers become better?

So... my question stands: but let me put it a different way in two parts:

1. What is the maximum expected time for the success condition to be
   satisfied?
2. How long does it actually take for the loop to time out in existing
   CPUs/compilers?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
