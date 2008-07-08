From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: ide-cd.c fix sparse endianness warnings
Date: Tue, 8 Jul 2008 19:58:29 +0200
Message-ID: <200807081958.29405.bzolnier@gmail.com>
References: <1215128085.16647.40.camel@brick> <20080706072540.GA31524@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:1788 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475AbYGHSu5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jul 2008 14:50:57 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1214191ywe.1
        for <linux-ide@vger.kernel.org>; Tue, 08 Jul 2008 11:50:57 -0700 (PDT)
In-Reply-To: <20080706072540.GA31524@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Harvey Harrison <harvey.harrison@gmail.com>, linux-ide <linux-ide@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Sunday 06 July 2008, Borislav Petkov wrote:
> On Thu, Jul 03, 2008 at 04:34:45PM -0700, Harvey Harrison wrote:
> > drivers/ide/ide-cd.c:1276:46: warning: Using plain integer as NULL pointer
> > drivers/ide/ide-cd.c:1298:19: warning: cast to restricted __be32
> > drivers/ide/ide-cd.c:1300:4: warning: cast to restricted __be32
> > drivers/ide/ide-cd.c:1522:14: warning: cast to restricted __le16
> > drivers/ide/ide-cd.c:1523:14: warning: cast to restricted __le16
> > drivers/ide/ide-cd.c:1525:14: warning: cast to restricted __be16
> > drivers/ide/ide-cd.c:1526:14: warning: cast to restricted __be16
> > drivers/ide/ide-cd.c:1667:37: warning: cast to restricted __be16
> > 
> > Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> 
> Acked-off-by: Borislav Petkov <petkovbb@gmail.com>

applied

BTW ide-cd & co can as well use kernel typedefs (without "__" prefix)
