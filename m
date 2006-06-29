From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: [DOC] SATA status report updated
Date: Thu, 29 Jun 2006 10:41:34 -0400
Message-ID: <87f94c370606290741v45e63336n30df5fdc6a5c2bac@mail.gmail.com>
References: <44A0B50F.40404@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:23174 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750708AbWF2Olg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jun 2006 10:41:36 -0400
Received: by nf-out-0910.google.com with SMTP id l35so82051nfa
        for <linux-ide@vger.kernel.org>; Thu, 29 Jun 2006 07:41:34 -0700 (PDT)
In-Reply-To: <44A0B50F.40404@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 6/27/06, Jeff Garzik <jeff@garzik.org> wrote:
> Updated the SATA status report(s) found at
>
>         http://linux-ata.org/
>
> In particular, I created a matrix of drivers and features, to give
> people an idea of fine-grained driver status:
>
>         http://linux-ata.org/driver-status.html#matrix
>
> As always, comments, questions, and additions are welcome.
>
>         Jeff
Jeff / Tejun,

Great work.  If the feedback about reversion issues continues to be as
minimal as it currently is it appears you appear to have rolled out a
great enhancement with minimal errors introduced.  I expect to be
using sata/e-sata much more extensively now that this new EH process
is in place.

Any practical experience about which PCI controllers and/or enclosures
would be best to get if I wanted to use e-Sata and the
hotplug/warmplug logic?

I have about 20 computers I would like to be able to plug e-Sata
drives into so I could move the drives around as needed.

The computers will be a mix of Linux (2.6.18+) and Windows 2K/XP/2003.

Greg
-- 
Greg Freemyer
The Norcross Group
Forensics for the 21st Century
