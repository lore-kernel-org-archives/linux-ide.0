From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: improve sense data generation
Date: Tue, 14 Nov 2006 22:37:35 +0900
Message-ID: <11635114553453-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:33407 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965711AbWKNNhl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Nov 2006 08:37:41 -0500
Received: by wr-out-0506.google.com with SMTP id i22so142367wra
        for <linux-ide@vger.kernel.org>; Tue, 14 Nov 2006 05:37:40 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, Jeff.

This patchset fixes and improves SCSI sense data generation.

* resul_tf->flags is synced to command tf->flags so that sense
  generation functions can tell which address format is in use

* length field in passthru sense data fixed

* failed block is now properly reported for all three address formats
  - CHS, LBA and LBA48.

* other cleanups

Thanks.

--
tejun

