From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: improve media error handling
Date: Tue, 14 Nov 2006 22:47:09 +0900
Message-ID: <1163512029469-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.195]:58664 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965773AbWKNNrQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Nov 2006 08:47:16 -0500
Received: by nz-out-0102.google.com with SMTP id l1so973558nzf
        for <linux-ide@vger.kernel.org>; Tue, 14 Nov 2006 05:47:16 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, Jeff.

This patchset improves media error handling.  The problem is that ATA
devices transfer "indeterminate" amount of data on device error making
handling media errors difficult for highlevel driver to handle.  The
current high level driver, sd, assumes that data upto the first failed
block has been transferred successfully, so data corruption is
possible.

This patchset makes libata-eh perform IO upto the first failed block
and report the first failed block to highlevel driver iff the partial
transfer was successful.  Note that after this patchset LLDs using old
EH don't report the first failed block to high level.  It wasn't safe
to begin with and no libata driver properly reported the first failed
sector before improve-sense-data-generation patchset anyway.

With this patchset applied, libata media error handling is well
integrated with sd.

This patchset is against

  upstream(cfd15b0011498986ef14b6c53f5eaba89d2171f3)
  + improve-sense-data-generation patchset[1]

Thanks.

--
tejun

[1] http://thread.gmane.org/gmane.linux.ide/14035/focus=14035


