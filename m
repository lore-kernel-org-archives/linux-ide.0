From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: improve ata_bus_probe failure handling, take 2
Date: Sun, 2 Apr 2006 17:54:46 +0900
Message-ID: <11439680863256-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:47513 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932149AbWDBIyv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 04:54:51 -0400
Received: by zproxy.gmail.com with SMTP id o37so1438211nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 00:54:51 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, Jeff, Alan and Albert.

This is the second take of improve-ata_bus_probe-failure-handling
patchset.  9 patches were accepted (%1-%8, %11) from the last take[1].
Changes from the last take are...

* ata_dev_absent() implemented (new patch)
* move sata_spd_limit from dev to ap
* move spd configuration into hardreset
* lengthen inter-reset delay to 5 sencs and add info message
* implement-ata_down_xfermask_limit patch is pushed back in series to
  just before its usage.

This patchset is against the current #upstream[2].

Jeff, ICH7 doesn't apply SPD configuration set while PHY is turned
off.  Sil3124 applies the change whether it's done before turning off
PHY or while PHY is off.  It seems that, SPD configuration should be
done before turning off PHY until more information is collected.

Note that even if the SPD configuration doesn't work, it doesn't cause
any harm other than retrying limited number of resets, and it is easy
to tell whether SATA SPD configuration works from the info messages.

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/9170
[2] 852ee16a914fb3ada2f81e222677c04defc2f15f


