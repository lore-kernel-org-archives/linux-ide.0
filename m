From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata_piix: Add Fujitsu-Siemens Lifebook S6120 to short
 cable IDs
Date: Mon, 18 Sep 2017 20:32:32 -0700
Message-ID: <20170919033232.GQ378890@devbig577.frc2.facebook.com>
References: <20170918200008.16139-1-ville.syrjala@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:52945 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbdISDcg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 18 Sep 2017 23:32:36 -0400
Received: by mail-qk0-f170.google.com with SMTP id o77so2449943qke.9
        for <linux-ide@vger.kernel.org>; Mon, 18 Sep 2017 20:32:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170918200008.16139-1-ville.syrjala@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: linux-ide@vger.kernel.org

On Mon, Sep 18, 2017 at 11:00:08PM +0300, Ville Syrjala wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> Fujitsu-Siemens Lifebook S6120 misdetects the cable type for some
> drives. The problematic one in this case is an mSATA SSD hooked up via a
> mSATA->PATA bridge. With regular hard disks the detection seems to work
> correctly.
> 
> Strangely an older Lifebook model (S6020) detects the cable as 80c
> with the mSATA SSD, even if using the exact same flex cable.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

Applied to libata/for-4.14-fixes.

Thanks.

-- 
tejun
