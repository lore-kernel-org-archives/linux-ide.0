Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E3BE75420
	for <linux-ide@archiver.kernel.org>; Tue,  3 Oct 2023 04:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjJCEg2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Oct 2023 00:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjJCEg2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 3 Oct 2023 00:36:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F45A4
        for <linux-ide@vger.kernel.org>; Mon,  2 Oct 2023 21:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696307785; x=1727843785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rGaJabltA5jr13RlIMzbyz2XumCD3+oReazU11Fs30E=;
  b=RtmveB0om06NulJIL6OC6/6RtjVE7/ejlBZlNm1vezo9R1ihr1ZCqn3y
   vf2IkT9bhX237UGflyGHIQqGZiMaNHkZTwp9xJvigcuc440QjA80odlFm
   MKFrBaZPnhCRk9dKNcp7Zp8S8vBdZDYeC0DWaCIUgDPzVqK8z996v/JIl
   PX6FoURkgKF0yvVxBGmsRIKHspCO5zz1DPQJNMUJn1Z1PbFzaTL1une7I
   K1nfOWzhU0PrjkA/L5Lwk1vi4NuJ+X6vTUvMCt+3SFZrZUQ0sLGAYVqKA
   e/th0BSGSTdHs/qajZ6X7sz3gXPWdhVqU4Nx9aOGL4kGaVHVWjMLb2+ES
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="386667815"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="386667815"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 21:36:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="700556624"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="700556624"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 02 Oct 2023 21:36:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id F396B163; Tue,  3 Oct 2023 07:36:21 +0300 (EEST)
Date:   Tue, 3 Oct 2023 07:36:21 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Koba Ko <koba.ko@canonical.com>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: ahci: Add Intel Alder Lake-P AHCI controller to low
 power chipsets list
Message-ID: <20231003043621.GE3208943@black.fi.intel.com>
References: <20230925080538.2894982-1-mika.westerberg@linux.intel.com>
 <e58ddf0f-3b7e-9599-dd7d-c6ed322d1184@kernel.org>
 <20230925091339.GM3208943@black.fi.intel.com>
 <385141b8-4d02-cecb-7393-7375f095198f@kernel.org>
 <CAJB-X+UdB-+O8O97hCRQNbFpU7CuNisVCQkaJZ4JD01qZ-JqJA@mail.gmail.com>
 <20231002062120.GB3208943@black.fi.intel.com>
 <42141dac-88eb-cbb7-0836-5fe51e35ac36@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42141dac-88eb-cbb7-0836-5fe51e35ac36@kernel.org>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On Tue, Oct 03, 2023 at 09:49:20AM +0900, Damien Le Moal wrote:
> On 10/2/23 15:21, Mika Westerberg wrote:
> > On Tue, Sep 26, 2023 at 12:55:05PM +0800, Koba Ko wrote:
> >> On Mon, Sep 25, 2023 at 5:27 PM Damien Le Moal <dlemoal@kernel.org> wrote:
> >>>
> >>> On 2023/09/25 11:13, Mika Westerberg wrote:
> >>>> Hi,
> >>>>
> >>>> On Mon, Sep 25, 2023 at 11:09:01AM +0200, Damien Le Moal wrote:
> >>>>> On 2023/09/25 10:05, Mika Westerberg wrote:
> >>>>>> Intel Alder Lake-P AHCI controller needs to be added to the mobile
> >>>>>> chipsets list in order to have link power management enabled. Without
> >>>>>> this the CPU cannot enter lower power C-states making idle power
> >>>>>> consumption high.
> >>>>>>
> >>>>>> Cc: Koba Ko <koba.ko@canonical.com>
> >>>>>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >>>>>
> >>>>> Looks OK, but given that there is a tendency of the low power stuff to be buggy,
> >>>>> was this well tested ?
> >>>>
> >>>> Yes it was tested (Koba Cc'd can confirm this). We also confirmed from
> >>>> Intel AHCI folks that the ADL (and RPL) AHCI controllers fully support
> >>>> this configuration.
> >>
> >> I verified on an ADL platform with odd and disk devices and
> >> they work fine.
> > 
> > Thanks!
> > 
> > @Damien, just checking whether this fell through cracks because I do not
> > see it applied to libata.git next branches?
> 
> Sorry about the delay. I was traveling and the suspend/resume fixes used all my
> bandwidth. Will queue this today. Do you want this for 6.7 or as a fix for 6.6 ?
> The latter is OK.

6.7 is fine, thanks!
