From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH 3/4] davinci: da850: add support for SATA interface
Date: Fri, 25 Mar 2011 14:49:00 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C5326A1@dbde02.ent.ti.com>
References: <1300879949-16379-1-git-send-email-nsekhar@ti.com>
 <1300879949-16379-2-git-send-email-nsekhar@ti.com>
 <1300879949-16379-3-git-send-email-nsekhar@ti.com>
 <4D89E308.8060404@mvista.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024C47E42D@dbde02.ent.ti.com>
 <4D8B415A.2050706@mvista.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024C53228A@dbde02.ent.ti.com>
 <4D8B8715.2000407@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39574 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755229Ab1CYJTQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Mar 2011 05:19:16 -0400
In-Reply-To: <4D8B8715.2000407@mvista.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi Sergei,

On Thu, Mar 24, 2011 at 23:31:57, Sergei Shtylyov wrote:
> Hello.
> 
> Nori, Sekhar wrote:
> 
> >>>>> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> >>>>> index 68fe4c2..276199d 100644
> >>>>> --- a/arch/arm/mach-davinci/da850.c
> >>>>> +++ b/arch/arm/mach-davinci/da850.c
> >>>>> @@ -373,6 +373,14 @@ static struct clk spi1_clk = {
> >>>>>    	.flags		= DA850_CLK_ASYNC3,
> >>>>>    };
> >>>>>
> >>>>> +static struct clk sata_clk = {
> >>>>> +	.name		= "sata",
> >>>>> +	.parent		=&pll0_sysclk2,
> >>>>> +	.lpsc		= DA850_LPSC1_SATA,
> >>>>> +	.gpsc		= 1,
> >>>>> +	.flags		= PSC_FORCE,
> >>>>> +};
> >>>>> +
> >>>>>    static struct clk_lookup da850_clks[] = {
> >>>>>    	CLK(NULL,		"ref",		&ref_clk),
> >>>>>    	CLK(NULL,		"pll0",		&pll0_clk),
> >>>>> @@ -419,6 +427,7 @@ static struct clk_lookup da850_clks[] = {
> >>>>>    	CLK(NULL,		"usb20",	&usb20_clk),
> >>>>>    	CLK("spi_davinci.0",	NULL,		&spi0_clk),
> >>>>>    	CLK("spi_davinci.1",	NULL,		&spi1_clk),
> >>>>> +	CLK("ahci",		NULL,		&sata_clk),
> >>>>>    	CLK(NULL,		NULL,		NULL),
> >>>>>    };
> 
> >>>>      I'd put the above into a separate patch...
> 
> >>> Why should addition of clock data not be in the same patch
> >>> as the one which adds platform resources etc? It is not a big
> >>> deal to change, but I would like to know why you request this.
> 
> >>     I didn't request anything, I just said what I'd have done. :-)
> 
> > Okay. I guess I will keep it as is.
> 
> >> I think modifying the DA8xx-common and DA850-specific files should better be 
> >> done separately. Although in this case we're adding DA850 only device, so 
> >> perhaps the added code in devices-da8xx.c should be enclosed into #ifdef?
> 
> > Good point. Will add the #ifdef.
> 
>     Or perhaps the device should just be placed in da850.c instead?

Um, no. da850.c is currently free from any peripheral specific
functionality and would like to keep it that way. MMC/SD1 is
DA850 specific as well, and has been kept in devices-da8xx.c.
I think consolidating all peripheral specific code in devices-da8xx.c
is a better idea.

Thanks,
Sekhar

