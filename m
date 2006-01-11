From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [PATCH 2.6.14.3] Necessary evil to get sata_vsc to initialize with Intel iq3124h hba
Date: Wed, 11 Jan 2006 01:39:26 -0800
Message-ID: <20060111093925.GB44861@sgi.com>
References: <20051214201049.GA20640@dwillia2-linux.ch.intel.com> <20051218091904.GA39033@sgi.com> <e9c3a7c20512271127v36eb56c9m54568a79784412e@mail.gmail.com> <20060105075732.GA323621@sgi.com> <e9c3a7c20601091530g7c5a5ac2vb0e2f24ed5198911@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:48595 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751408AbWAKJj3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jan 2006 04:39:29 -0500
Content-Disposition: inline
In-Reply-To: <e9c3a7c20601091530g7c5a5ac2vb0e2f24ed5198911@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@gmail.com>
Cc: linux-ide@vger.kernel.org

On Mon, Jan 09, 2006 at 04:30:56PM -0700, Dan Williams wrote:
> 
> Surprisingly, I still get the endless error interrupts with this patch applied.

Do you get the endless interrupts even after the mask is cleared?
I'm thinking that maybe you're getting them before that point, in
which case, we could move the clearing earlier.

If you get error interrupts even after the mask is cleared, then
that's very strange.

jeremy

> I integrated this patch with the previous explicit clear patch, and
> added debug prints to see when vsc_intr_mask_update is called relative
> to the interrupt handler.  Below is the debug output, and attached is
> the integrated patch with the interrupt mask changes (trimmed for
> white space against 2.6.15).
> 
> Dan
