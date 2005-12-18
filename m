From: Tejun Heo <htejun@gmail.com>
Subject: [RFC/PATCHSET] libata: new reset mechanism
Date: Sun, 18 Dec 2005 22:33:05 +0900
Message-ID: <20051218133305.GA31571@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:43080 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932702AbVLRNdL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Dec 2005 08:33:11 -0500
Received: by zproxy.gmail.com with SMTP id 13so1082893nzn
        for <linux-ide@vger.kernel.org>; Sun, 18 Dec 2005 05:33:10 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, liml@rtr.ca
Cc: linux-ide@vger.kernel.org

Hello, all.

Currently libata uses ->phy_reset to reset ports.  However,
->phy_reset is tightly woven into probing process (directly
manipulating device[]->class and disabling ports on failure) and thus
awkward to use for error handling or other purposes.

Another problem with the current scheme is that libata doesn't have
much control over reset process, which isn't very nice for both
initialization and error handling.

This patchset implements new reset mechanism.  The new mechanism can
peacefully live side-by-side with ->phy_reset mechanism and low level
drivers can be converted gradually.  This patchset converts sata_sil,
sata_sil24, ata_piix and ahci as a start.

This patchset is composed of the following 14 patches.

#01-03	: implement new reset mechanism and standard callbacks
#04	: preparation for low level driver conversion
#05	: convert sata_sil
#06-07	: convert sata_sil24 and add hardreset
#08-09	: convert ata_piix
#10-14	: convert ahci and add softreset

Thanks.

-- 
tejun
