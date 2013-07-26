From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 4/5] sata, highbank: set tx_atten override bits
Date: Fri, 26 Jul 2013 13:38:24 -0500
Message-ID: <51F2C220.5040407@gmail.com>
References: <1374851518-4802-1-git-send-email-mark.langsdorf@calxeda.com> <1374851518-4802-4-git-send-email-mark.langsdorf@calxeda.com> <20130726162231.GD3528@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:57729 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab3GZSi1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Jul 2013 14:38:27 -0400
In-Reply-To: <20130726162231.GD3528@e106331-lin.cambridge.arm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "tj@kernel.org" <tj@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>

On 07/26/2013 11:22 AM, Mark Rutland wrote:
> On Fri, Jul 26, 2013 at 04:11:57PM +0100, Mark Langsdorf wrote:
>> Some board designs do not drive the SATA transmit lines within the
>> specification. The ECME can provide override settings, on a per board
>> basis, to bring the transmit lines within spec. Read those settings
>> from the DTB and program them in.
> 
> How variable is the use of this property going to be? Would it instead
> be possible to decide that this was necessary, and choose the
> appropriate values based on a compatible property?

It is based on compliance testing of the particular board design. Basing
on a compatible property would not work in this case.

Rob

