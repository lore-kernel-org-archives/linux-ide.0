From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: improve transfer mode handling
Date: Mon, 6 Mar 2006 04:31:56 +0900
Message-ID: <11415871161709-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.177]:11619 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750733AbWCETcA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 14:32:00 -0500
Received: by pproxy.gmail.com with SMTP id o67so616044pye
        for <linux-ide@vger.kernel.org>; Sun, 05 Mar 2006 11:32:00 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, Jeff, Alan and Albert.

This is the second take of improve-transfer-mode-handling patchset.
The last take[1] made low level driver API uglier and Alan rejected
the API changes.  Changes from the last take are...

* No low level driver API change.  All changes are confined tolibata
  core layer proper.

* Fewer/simpler xfer_mask helpers.

* Better splitted patches.

This patchset makes transfer mode determination done in
ata_dev_xfermask() before any of actual configuration happens.  This
should help integrating Alan's changes easier.

This patchset is against the current upstream[2] + port_task
patchset[3].  However, all the patches except the last one applies
against upstream with offsets and the reject of the last patch is
trivial.  I'll post two versions of the last patch - one against
upstream + port_task, the other against upstream.

Thanks.

--
tejun

[1] http://marc.theaimsgroup.com/?l=linux-ide&m=114009896413075&w=2
[2] fbfda6e71bbdd3b4d41a56c3f20f31762c455a5e
[3] http://marc.theaimsgroup.com/?l=linux-ide&m=114154013813744&w=2
(dang, gmane still down.)


