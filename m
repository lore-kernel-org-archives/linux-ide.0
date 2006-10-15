From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] implement ata_link, take 3
Date: Mon, 16 Oct 2006 07:54:39 +0900
Message-ID: <1160952879581-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:34230 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422927AbWJOWys (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 18:54:48 -0400
Received: by nf-out-0910.google.com with SMTP id c2so626616nfe
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 15:54:46 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the third take of implement ata_link patchset.  This patchset
contains 18 patches which can be categorized as follows.

#01-03: prep
#04-05: implement ata_link
#06-09: make libata deal with link instead of port
#10-12: misc link stuff (link init, reset_tries, ata_link_abort())
#13-19: add ap->pmp_link[] and update libata to deal with multiple
	links

ata_link abstracts PHY and sits between ata_port and ata_device.  The
following attributes are moved to ata_link from ata_port.

- active command state (active_tag, sactive)
- [hw_]sata_spd_limit
- eh_info and eh_context
- device array

With above and a few extra fields, a link can fully host attached
devices including qc management and EH/hotplug.  This patchset makes
libata ready to handle PM links.

Changes from the last take[L] are.

* updated to fit new #upstream
* __dev1 trick removed

This patchset is against

  upstream (da54f5fe54c7d75e2db7d17961fb36a8c28a8501)
  + [1] hp-poll patchset, take #5
  + [2] vt8251-ahci patchset, take #2

Thanks.

--
tejun

[L] http://article.gmane.org/gmane.linux.ide/11928
[1] http://article.gmane.org/gmane.linux.ide/13467
[2] http://article.gmane.org/gmane.linux.ide/13471


