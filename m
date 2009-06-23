From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] IDE: Save a call to PageHighMem()
Date: Tue, 23 Jun 2009 12:11:02 +0200
Message-ID: <200906231211.03094.bzolnier@gmail.com>
References: <20090623101239.2f510604@hyperion.delvare> <200906231148.32675.bzolnier@gmail.com> <20090623120018.4dff40f5@hyperion.delvare>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:31424 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbZFWKF3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 06:05:29 -0400
Received: by fg-out-1718.google.com with SMTP id e12so66756fga.17
        for <linux-ide@vger.kernel.org>; Tue, 23 Jun 2009 03:05:31 -0700 (PDT)
In-Reply-To: <20090623120018.4dff40f5@hyperion.delvare>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-ide@vger.kernel.org, David Miller <davem@davemloft.net>

On Tuesday 23 June 2009 12:00:18 Jean Delvare wrote:
> Hi Bartlomiej,
> 
> On Tue, 23 Jun 2009 11:48:31 +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Tuesday 23 June 2009 10:12:39 Jean Delvare wrote:
> > > PageHighMem() isn't cheap so avoid calling it twice on the same page.
> > > 
> > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > > Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > 
> > Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Thanks.
> 
> > PS Please send IDE patches to Dave in the future, thanks.
>
> I followed what MAINTAINERS says, and will keep doing so in the future.

Yeah, I know.. ;)

> If the information stored there is outdated, please update it.

Dave has already sent a patch to update it but it is not applied yet.
