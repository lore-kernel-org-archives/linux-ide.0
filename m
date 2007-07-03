From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] hpt366: blacklist MAXTOR STM3320620A for UltraDMA/66
Date: Tue, 3 Jul 2007 21:04:48 +0200
Message-ID: <200707032104.48710.bzolnier@gmail.com>
References: <200706292357.17374.sshtylyov@ru.mvista.com> <20070703162758.GB4302@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:58842 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757864AbXGCU0t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 16:26:49 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1348824nze
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 13:26:48 -0700 (PDT)
In-Reply-To: <20070703162758.GB4302@austin.ibm.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org


On Tuesday 03 July 2007, Linas Vepstas wrote:
> On Fri, Jun 29, 2007 at 11:57:17PM +0400, Sergei Shtylyov wrote:
> > Add the MAXTOR STM3320620A drive into the UltraDMA/66 mode blacklist
> > for the HPT36x chips.
> > 
> > Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> Acked-by: Linas Vepstas <linas@austin.ibm.com>

added

> Applied & tested & it worked for me.

Thanks for reviewing/testing both patches.

Bart
