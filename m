From: "Dan Carpenter" <error27.lkml@gmail.com>
Subject: Re: [PATCH][INCOMPLETE] sata_nv: merge ADMA support
Date: Wed, 7 Jun 2006 15:09:31 -0700
Message-ID: <b263e5900606071509o3b06c7a4y84aae7802a5aece2@mail.gmail.com>
References: <20060317232339.GA5674@ti64.telemetry-investments.com>
	 <20060319232317.GA25578@ti64.telemetry-investments.com>
	 <441F56AD.8020001@garzik.org>
	 <200603262014.35466.lkml@lpbproductions.com>
	 <20060327160845.GG9411@ti64.telemetry-investments.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:7136 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932438AbWFGWJc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Jun 2006 18:09:32 -0400
Received: by nf-out-0910.google.com with SMTP id l23so250815nfc
        for <linux-ide@vger.kernel.org>; Wed, 07 Jun 2006 15:09:31 -0700 (PDT)
In-Reply-To: <20060327160845.GG9411@ti64.telemetry-investments.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Bill Rugolsky Jr." <bill@rugolsky.com>, Matt Heler <lkml@lpbproductions.com>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Bill Rugolsky Jr. <bill@rugolsky.com> wrote:
> Here is an incomplete attempt to get the sata_nv ADMA code working.
>
> I made another pass through my merge of the sata_nv driver to fix and
> clean up a few things.  I've only made the minimal changes necessary
> to get it into a testable state; methinks it could do with a lot of
> refactoring and cleanup, instead of all the "if (host->...host_type == ADMA)" tests.
>

Did you ever figure this out?

It looks like you're mixing two completely seperate bugs.  The ata
timeouts and the lost ticks messages.

> BIOS Information
>         Vendor: Phoenix Technologies Ltd.
>         Version: 2004Q3
>         Release Date: 10/12/2005
>

This is causing the sata failures:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=190856
Downgrade to match your other system (version 1.01).  That will fix
the ata timeouts at least.

I'm still interested in the lost ticks messages though...

regards,
dan carpenter
