From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-cd: move the remaining cdrom.c ioctl handling code to ide-cd_ioctl.c
Date: Thu, 27 Dec 2007 16:50:52 +0100
Message-ID: <200712271650.52533.bzolnier@gmail.com>
References: <20071226205014.GA7228@gollum.tnic> <20071226215431.GA11415@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:1096 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbXL0R2U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Dec 2007 12:28:20 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1677042ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 27 Dec 2007 09:28:18 -0800 (PST)
In-Reply-To: <20071226215431.GA11415@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bbpetkov@yahoo.de
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wednesday 26 December 2007, Borislav Petkov wrote:
> On Wed, Dec 26, 2007 at 09:50:14PM +0100, Borislav Petkov wrote:
> 
> Actually you should drop the previous one for it wasn't incomplete. Here's,
> hopefully, a better one :).
> --
> From: Borislav Petkov <bbpetkov@yahoo.de>
> 
> There should be no functional changes from this.
> 
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>

applied, thanks
