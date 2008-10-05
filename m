From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/3] ide-cd: small drive type print fix
Date: Sun, 5 Oct 2008 17:54:15 +0200
Message-ID: <200810051754.24062.bzolnier@gmail.com>
References: <1222669799-6565-1-git-send-email-petkovbb@gmail.com> <200810031918.15455.bzolnier@gmail.com> <20081004082827.GA4160@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:40222 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759532AbYJEQlf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Oct 2008 12:41:35 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1966563muf.1
        for <linux-ide@vger.kernel.org>; Sun, 05 Oct 2008 09:41:33 -0700 (PDT)
In-Reply-To: <20081004082827.GA4160@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Saturday 04 October 2008, Borislav Petkov wrote:
> On Fri, Oct 03, 2008 at 07:18:15PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Monday 29 September 2008, Borislav Petkov wrote:
> > > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> > 
> > applied (though I fail to see "an added value" of this change)
> 
> It simply makes the format consistent with the lines below: CD-R/RW - which is
> the more common way of enumerating supported media you find in different specs
> than DVD-R-RAM, don't you think?

Indeed, thanks for explaining it.
