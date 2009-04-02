From: Matthew Wilcox <willy@linux.intel.com>
Subject: Re: [PATCH 5/5] libata: Add support for TRIM
Date: Thu, 2 Apr 2009 10:55:40 -0700
Message-ID: <20090402175539.GR2661@linux.intel.com>
References: <1238683047-13588-1-git-send-email-willy@linux.intel.com> <1238683047-13588-2-git-send-email-willy@linux.intel.com> <1238683047-13588-3-git-send-email-willy@linux.intel.com> <1238683047-13588-4-git-send-email-willy@linux.intel.com> <1238683047-13588-5-git-send-email-willy@linux.intel.com> <49D4F3C1.3070200@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:46051 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751402AbZDBRzo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Apr 2009 13:55:44 -0400
Content-Disposition: inline
In-Reply-To: <49D4F3C1.3070200@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@redhat.com, David Woodhouse <David.Woodhouse@intel.com>

On Thu, Apr 02, 2009 at 01:20:01PM -0400, Mark Lord wrote:
> Now we just need an implementation of ata_discard_fn()
> that issues the CFA ERASE SECTORS command instead of TRIM
> when speaking to a CFA device.

Yes, should be quite straightforward.  The only minor wrinkle I can see
is that CFA ERASE SECTORS only allows you to erase up to 256 sectors at a
time.  I think Dave's infrastructure for Discard lets us handle that ...

> Ah, life is good!

Isn't it though?
