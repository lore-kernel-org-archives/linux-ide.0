From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: pata_cs5536: ATA driver for Geode companion chip
Date: Wed, 10 Oct 2007 13:39:00 -0400
Message-ID: <76366b180710101039s344b588ap1e264ef893db87ea@mail.gmail.com>
References: <yq14ph8xg3z.fsf@sermon.lab.mkp.net> <470C2A16.1040606@garzik.org>
	 <yq1641flhbc.fsf@sermon.lab.mkp.net>
	 <20071010152026.GA1616@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:28158 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669AbXJJRjB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Oct 2007 13:39:01 -0400
Received: by rv-out-0910.google.com with SMTP id k20so250506rvb
        for <linux-ide@vger.kernel.org>; Wed, 10 Oct 2007 10:39:00 -0700 (PDT)
In-Reply-To: <20071010152026.GA1616@cosmic.amd.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On 10/10/07, Jordan Crouse <jordan.crouse@amd.com> wrote:
> I never heard back from anybody - so either nobody is using pata_amd
> (which I suspect), or they didn't have any problems.  Go ahead and merge,
> and I'll do a sanity check on a few boards next week just to make sure.

I am using the CS5536 currently with pata_amd and it worked without
issue. I only used the PATA port for a short time, though, before
switching to USB + SATA. I will now be going back to using the PATA
this week, so I'll try out the new driver in place of pata_amd and
write back if there are any problems.

Thanks,
-Andrew
