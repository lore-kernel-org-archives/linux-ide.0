From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: use single unsigned int xfer_mask
Date: Thu, 16 Feb 2006 23:09:06 +0900
Message-ID: <11400989462656-git-send-email-htejun@gmail.com>
References: <43F3244B.2010600@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.193]:37839 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932282AbWBPOJN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Feb 2006 09:09:13 -0500
Received: by xproxy.gmail.com with SMTP id h26so119578wxd
        for <linux-ide@vger.kernel.org>; Thu, 16 Feb 2006 06:09:13 -0800 (PST)
In-Reply-To: <43F3244B.2010600@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, bzolnier@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Hello, all.

Here's the patchset to unify trasnfer mode/mask representation into
single unsigned int xfer_mask.  Transfer mode/mask are always stored
in single xfer_mask and a few transformation helpers are supplied to
help manipulating it.

This patchset is against...

upstream (f1b318793dcd2d9ff6b5ac06e7762098fa079cee)
+ ahci-softreset patch [1]
+ configure-reorganize patchset [2]
+ revalidation patchset [3]

This patchset is composed of three patches.

#01 : minor fix to sata_sil24 regarding mwdma_mask setting

#02 : make ata_device and ata_port use xfer_mask.  This patch changes
      most of transfer mode handling in libata core layer but doesn't
      affect low level drivers much.

#03 : make ata_port_info and ata_probe_ent use xfer_mask.  This patch
      doesn't change libata core layer any significant way.  It just
      changes the way low level drivers report supported transfer
      modes.

Decoding device transfer mode from IDENTIFY data is now done in
ata_id_xfermask() proper.  Determining device transfer mode is done
soley in ata_dev_xfermask().  base_from_shift() and offset calculation
are substitued by ata_xfer_modeval().

Thanks.

--
tejun

