From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET #upstream] libata: implement presence detection using polling IDENTIFY for ata_piix, take #2
Date: Fri, 10 Nov 2006 18:08:09 +0900
Message-ID: <11631496893280-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.194]:49171 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1946097AbWKJJIT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Nov 2006 04:08:19 -0500
Received: by nz-out-0102.google.com with SMTP id l1so257953nzf
        for <linux-ide@vger.kernel.org>; Fri, 10 Nov 2006 01:08:18 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the second take of polling-IDENTIFY patchset.  Other than
rebased on the current upstream, nothing has changed since the last
take[L].

Some SATA and many PATA controllers don't have reliable way to detect
device presence and some controllers report master device's signature
as slave's if slave isn't present.  This sometimes results in failure
to detect devices and at other times phantom devices which cause
considerable delay during boot.

This patchset implements device detection via polling IDENTIFY, which
is used by IDE and was used by old libata.  When no device present,
!BSY && !DRQ status is seen while trying to read the IDENTIFY block.
If a LLD specifies ATA_FLAG_DETECT_POLLING, IDENTIFY command is issued
using polling PIO and the HSM marks AC_ERR_NODEV_HINT if !BSY && !DRQ
is met.  Then the probing logic marks the device non-existent silently
and continues probing.

ata_piix is having a lot of problem involving missing and/or phantom
devices and converted to use polling IDENTIFY by this patchset.

This patchset contains 6 patches.

#01-02	: prep for ATA_FLAG_DETECT_POLLING implementation
#03	: implement ATA_DETECT_POLLING
#04	: apply ATA_DETECT_POLLING to ata_piix
#05	: kill unnecessary parts from ata_piix

This patchset is against

  upstream (cfd15b0011498986ef14b6c53f5eaba89d2171f3)

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/13284/focus=13284


