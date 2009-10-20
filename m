From: Tejun Heo <tj@kernel.org>
Subject: Re: Problem with ICH10R and Port Multipliers
Date: Tue, 20 Oct 2009 10:49:59 +0900
Message-ID: <4ADD1747.5070000@kernel.org>
References: <4ADC9058.4090701@isp-services.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49860 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932437AbZJTBsq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Oct 2009 21:48:46 -0400
In-Reply-To: <4ADC9058.4090701@isp-services.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom van Klinken / ISP Services BV <tom@isp-services.nl>
Cc: linux-ide@vger.kernel.org

Tom van Klinken / ISP Services BV wrote:
> Hi,
> 
> I've got a Intel DG45FC motherboard that I would like to integrate into
> a NAS system.
> 
> This board has the ICH10R chipset and from what I have understood this
> chipset should support port multipliers.
> (http://www.intel.com/design/chipsets/matrixstorage_sb.htm)
> 
> However it does not, it also does not show 'pmp' support in the AHCI flags.
> 
> After contacting Intel they told me that Port Multipliers are not
> supported on their boards.
> 
> Did they deliberately turn PMP support off?

IIRC, since ICH8 or 9, intel ahcis do support PMP.  The flag can be
controlled by the BIOS.  Hmmm.... maybe you can just comment out the
code and force ahci to enable PMP.  My gut feeling is that it'll
probably work.  Maybe we need to add quirks or a parameter to force
it.  Can you please verify it works?

Thanks.

-- 
tejun
