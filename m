From: Tim Small <tim@seoss.co.uk>
Subject: Re: decoding PMP errors with Marvel SATA controller
Date: Wed, 06 Jul 2011 21:55:02 +0100
Message-ID: <4E14CBA6.4010908@seoss.co.uk>
References: <20110626070820.GC24867@merlins.org> <20110626090309.GA12200@mtj.dyndns.org> <4E076E9E.9080400@pobox.com> <20110627000614.GA5362@merlins.org> <4E07DCF5.1090506@pobox.com> <B9B10C29375C5B40A2D240808654F60E5EE470A68B@SC-VEXCH2.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay0.allsecurenet.com ([109.169.27.60]:57279 "EHLO
	relay0.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756189Ab1GFUzY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Jul 2011 16:55:24 -0400
In-Reply-To: <B9B10C29375C5B40A2D240808654F60E5EE470A68B@SC-VEXCH2.marvell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hubert Bailey <hbailey@marvell.com>
Cc: 'Mark Lord' <mlord@pobox.com>, Marc MERLIN <marc@merlins.org>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Larry Li <lil@marvell.com>

On 27/06/11 02:58, Hubert Bailey wrote:
> Typically the biggest issues are with the PMPs that have internal RAID controllers.  These parts do not follow the SATA spec when they are not in RAID mode.
>   

FWIW, the errors and performance issues which I have been seeing with
the 88SE91xx are with a SiI 3726 - which is AFAIK the most common PMP
chip, and has no RAID features...

Cheers,

Tim.

-- 
South East Open Source Solutions Limited
Registered in England and Wales with company number 06134732.  
Registered Office: 2 Powell Gardens, Redhill, Surrey, RH1 1TQ
VAT number: 900 6633 53  http://seoss.co.uk/ +44-(0)1273-808309

