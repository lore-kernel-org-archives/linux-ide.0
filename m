Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A510E784A4
	for <linux-ide@archiver.kernel.org>; Mon,  2 Oct 2023 06:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbjJBGV2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Oct 2023 02:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbjJBGV0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Oct 2023 02:21:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D63A7
        for <linux-ide@vger.kernel.org>; Sun,  1 Oct 2023 23:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696227683; x=1727763683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=S62AwAKNDm/m2EK7pgZ2AOtrcjlexBkTmciv5g4BtXo=;
  b=Q0q6v5W8TrW4IcENYiv5VfbO7JaOuUxMWVotWJ3eKdQrIOn+IrKlTVwf
   UCMX21cf/e9FApJfT2H4UPXVFnE19gjs5p/deLBaKFkI55rbaSBezZSC+
   dsLmCNVJ7PgNcdcGY6rc7CmRTIj0NtvBxIbN7/B5kUQw6/g+XPjS5NLnC
   uHlN456IMyeDafIaNS1fpshBYEklGPA2U0hVQZoSXFZ73lyScv/JvbDJS
   NNJaRinR1gg7N22Xnn/XVke+W/xMtCn7y6XHh+yw3mQpTs0KVNdMP5wqk
   f5UYglPcveFOOg/Vr8J+MiDXCtTp2byZ+5U947vsRshb3iYvgTRce6tc2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="381472256"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; 
   d="scan'208";a="381472256"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 23:21:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="750493827"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; 
   d="scan'208";a="750493827"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 01 Oct 2023 23:21:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 167A894; Mon,  2 Oct 2023 09:21:20 +0300 (EEST)
Date:   Mon, 2 Oct 2023 09:21:20 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Koba Ko <koba.ko@canonical.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: ahci: Add Intel Alder Lake-P AHCI controller to low
 power chipsets list
Message-ID: <20231002062120.GB3208943@black.fi.intel.com>
References: <20230925080538.2894982-1-mika.westerberg@linux.intel.com>
 <e58ddf0f-3b7e-9599-dd7d-c6ed322d1184@kernel.org>
 <20230925091339.GM3208943@black.fi.intel.com>
 <385141b8-4d02-cecb-7393-7375f095198f@kernel.org>
 <CAJB-X+UdB-+O8O97hCRQNbFpU7CuNisVCQkaJZ4JD01qZ-JqJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJB-X+UdB-+O8O97hCRQNbFpU7CuNisVCQkaJZ4JD01qZ-JqJA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Sep 26, 2023 at 12:55:05PM +0800, Koba Ko wrote:
> On Mon, Sep 25, 2023 at 5:27 PM Damien Le Moal <dlemoal@kernel.org> wrote:
> >
> > On 2023/09/25 11:13, Mika Westerberg wrote:
> > > Hi,
> > >
> > > On Mon, Sep 25, 2023 at 11:09:01AM +0200, Damien Le Moal wrote:
> > >> On 2023/09/25 10:05, Mika Westerberg wrote:
> > >>> Intel Alder Lake-P AHCI controller needs to be added to the mobile
> > >>> chipsets list in order to have link power management enabled. Without
> > >>> this the CPU cannot enter lower power C-states making idle power
> > >>> consumption high.
> > >>>
> > >>> Cc: Koba Ko <koba.ko@canonical.com>
> > >>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > >>
> > >> Looks OK, but given that there is a tendency of the low power stuff to be buggy,
> > >> was this well tested ?
> > >
> > > Yes it was tested (Koba Cc'd can confirm this). We also confirmed from
> > > Intel AHCI folks that the ADL (and RPL) AHCI controllers fully support
> > > this configuration.
> 
> I verified on an ADL platform with odd and disk devices and
> they work fine.

Thanks!

@Damien, just checking whether this fell through cracks because I do not
see it applied to libata.git next branches?
