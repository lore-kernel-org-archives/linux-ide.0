From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev-2.6:sil24 00/03] sil24: update interrupt handling and implment tf reading
Date: Thu,  6 Oct 2005 11:43:24 +0900 (KST)
Message-ID: <20051006024322.E428BF34@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.197]:46984 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750714AbVJFCnd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Oct 2005 22:43:33 -0400
Received: by xproxy.gmail.com with SMTP id i30so190580wxd
        for <linux-ide@vger.kernel.org>; Wed, 05 Oct 2005 19:43:32 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, efalk@google.com
Cc: linux-ide@vger.kernel.org

 Hello, Jeff.  Hello, Edward.

 This patchset updates error interrupt handling and implements tf
reading according to Edward's sample code.  Both success and failure
cases seem to work fine on my machine.

 I still couldn't get signature after phy reset from my harddrive,
but, as before, my dvd writer reports proper signature.  Well, as we
still don't support SATA ATAPI, I don't think this is a showstopper.
If you guys know how to do it, please fix it.

 Thanks Edward.

[ Start of patch descriptions ]

01_sil24_ignore-non-error-exception-irqs.patch
	: ignore non-error exception irqs

	Do not error-finish commands for non-error exception irqs -
	just ignore them.  This is taken from Edward's driver.

02_sil24_remove-cmderr-clearing.patch
	: remove CMDERR clearing

	CMDERR register doesn't need clearing.  This is from Edward's
	driver.

03_sil24_add-tf-reading.patch
	: implement proper TF register reading & caching

	This patch implements proper TF register reading back and
	caching and bumps up version to 0.22.  This is taken from
	Edward's driver.

[ End of patch descriptions ]

--
tejun

