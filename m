From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/11] ide-pmac: don't check kauai_lookup_timing() return value
Date: Mon, 23 Jul 2007 23:21:08 +0200
Message-ID: <200707232321.08194.bzolnier@gmail.com>
References: <200707222020.55609.bzolnier@gmail.com> <1185141244.5439.58.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:53048 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758100AbXGWVZ0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jul 2007 17:25:26 -0400
Received: by ug-out-1314.google.com with SMTP id j3so40025ugf
        for <linux-ide@vger.kernel.org>; Mon, 23 Jul 2007 14:25:25 -0700 (PDT)
In-Reply-To: <1185141244.5439.58.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org

On Sunday 22 July 2007, Benjamin Herrenschmidt wrote:
> On Sun, 2007-07-22 at 20:20 +0200, Bartlomiej Zolnierkiewicz wrote:
> > kauai_lookup_timing() should always return non-zero return value:
> > 
> > * BUG() in kauai_lookup_timing() if the timing info cannot be found.
> > 
> > * Remove code checking for zero return value from all callers.
> > 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

added
