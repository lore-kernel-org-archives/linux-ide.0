From: Tejun Heo <htejun@gmail.com>
Subject: prep for PMP support, take 3
Date: Mon, 16 Oct 2006 08:47:17 +0900
Message-ID: <11609560371552-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:9616 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932220AbWJOXr0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 19:47:26 -0400
Received: by nf-out-0910.google.com with SMTP id c2so636810nfe
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 16:47:25 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, htejun@gmail.com

Hello,

This is the third take of libata-pmp patchset.  This patchset contains
12 patches and implements PMP support.

#01-05: implement libata PMP support
#06-12: implement sata_sil24 PMP support

ATM, the only sata_sil24 supports PMP and only sil3726 and sil4726
PMPs are tested.

Changes from the last take[L] are.

* updated to fit new #upstream
* sil24 PMP configuration sequence updated

This patchset is against

  upstream (da54f5fe54c7d75e2db7d17961fb36a8c28a8501)
  + [1] hp-poll patchset, take #5
  + [2] vt8251-ahci patchset, take #2
  + [3] libata-link patchset, take #3
  + [4] prep-pmp patchset, take #4

Git tree can be accessed at

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=pmp
  git://htj.dyndns.org/libata-tj pmp

Jeff, I kept the behavior of ATA_LFLAG_DISABLED as the discussion
didn't proceed from there.  If you still don't agree with it, please
let me know.

Thanks.

--
tejun

[L] http://article.gmane.org/gmane.linux.ide/11946
[1] http://article.gmane.org/gmane.linux.ide/13467
[2] http://article.gmane.org/gmane.linux.ide/13471
[3] http://article.gmane.org/gmane.linux.ide/13478
[4] http://article.gmane.org/gmane.linux.ide/13500


