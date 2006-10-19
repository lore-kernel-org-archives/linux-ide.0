From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] sata_sil: implement Mod15Write workaround by split request processing
Date: Thu, 19 Oct 2006 14:51:38 +0900
Message-ID: <1161237098656-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:47017 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030304AbWJSFvr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Oct 2006 01:51:47 -0400
Received: by nf-out-0910.google.com with SMTP id c2so923944nfe
        for <linux-ide@vger.kernel.org>; Wed, 18 Oct 2006 22:51:46 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, Jeff.

This is updated version of the Mod15Write workaround I've been
maintaining for a year now.  This patchset contains the following
patches.

#01-03 : Prepare libata for m15w workaround.  All three patches are
	 justifiable by themselves.
#04    : implement Mod15Write workaround by split request processing

The core split processing code is in production use on many machines
and I haven't heard about malfucntion for a very long time, so I
suppose they're pretty stable.

For mainline inclusion, I've added code to handle PIO mode.  When the
device is switched to PIO mode, sata_sil turns of split request
processing and limits max_sectors to 15 and vice versa when it exits
PIO mode.

This patchset is against the current #upstream
(da54f5fe54c7d75e2db7d17961fb36a8c28a8501).

Thanks.

--
tejun


