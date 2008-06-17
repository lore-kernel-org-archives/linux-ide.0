From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/4] ide-pmac: media-bay support fixes
Date: Tue, 17 Jun 2008 11:41:08 +0200
Message-ID: <200806171141.08865.bzolnier@gmail.com>
References: <200806162124.43005.bzolnier@gmail.com> <1213673979.8129.156.camel@pasglop> <1213674572.8129.159.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:13343 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbYFQJjc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jun 2008 05:39:32 -0400
Received: by yw-out-2324.google.com with SMTP id 9so3349084ywe.1
        for <linux-ide@vger.kernel.org>; Tue, 17 Jun 2008 02:39:32 -0700 (PDT)
In-Reply-To: <1213674572.8129.159.camel@pasglop>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 17 June 2008, Benjamin Herrenschmidt wrote:
> On Tue, 2008-06-17 at 13:39 +1000, Benjamin Herrenschmidt wrote:
> > Your patches don't apply on today upstream, I'll try against
> > linux-next or is there a git I can clone to test things ?
> 
> Ok, I'm lost. I have 3 different series of patches from you partially
> overlapping with different amount of patches in them. I don't have
> time to sort that out right now. Can you send me a single serie that
> I can apply on top of either upstream or tonight linux-next which
> should have your stuff removed hopefully ?

This patch series (from yesterday, the rest of can be ignored) should
apply fine to the next revision of linux-next (later than -next-20080616,
it is not out yet), if you prefer upstream patches I can look into it
tonight.

Thanks,
Bart
