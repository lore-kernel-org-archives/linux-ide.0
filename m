From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: implement runtime link powersave
Date: Mon, 17 Jul 2006 15:52:31 +0900
Message-ID: <11531191512028-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.207]:5519 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751340AbWGQGvN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Jul 2006 02:51:13 -0400
Received: by nz-out-0102.google.com with SMTP id x7so398405nzc
        for <linux-ide@vger.kernel.org>; Sun, 16 Jul 2006 23:51:13 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the first take of powersave patchset.  It implements runtime
link-level power management.  To avoid confusion with regular
device/controller power management (suspend/resume), it's callsed
powersave.  It primarily implements partial/slumber/phy-off power
states SATA standard specifies but if LLD has different way of
implementing link powersave, it's allowed to.  Both host-initiated and
device-initiated operations are supported.

This patchset contains the following patches.

#01-07	: misc fixes/preps for powersave
#08-10	: implements core powersave infrastructure
#11-12	: implement powersave feature for ahci and sata_sil24

Powersave can be configured at boot time or while running by writing
to kernel module parameter /sys/module/libata/parameters/powersave.
The following powersave modes are supported.

* none		: no powersave, link is powered up all the time
* HIPS		: host-initiated powersave
* DIPS		: device-initiated powersave
* static	: no powersave on occupied link, power off empty link
* HIPS/static	: HIPS on occupied link, power off empty link
* DIPS/static	: DIPS on occupied link, power off empty link

For more information, please read head messages of individual patches.

All supported modes are tested on ICH7R AHCI, ICH6M AHCI, SiI3124,
SiI3132.  Unfortunately SiI3112/4 family controllers don't support
HIPS and choke on DIPS and thus dropped from supported list.

Here are some results on my ICH6M which can only do static PS.  Each
entry is average of 10 battery discharge rate readings 10 secs apart.

 none       static     diff  pct
---------------------------------
 1140.1mA / 1222.7mA 82.6mA 6.8%
 1145.4mA / 1209.8mA 64.4mA 5.3%
 1148.6mA / 1209.9mA 61.3mA 5.0%
 1150.8mA / 1217.2mA 66.4mA 5.5%
 l153.0mA / 1220.5mA 67.5mA 5.5%

I'd really like to see how much power DIPS/HIPS can save.  If you have
a notebook with smarter ICH, please don't hesitate to benchmark.

This patchset is against.

  upstream (309bade002e9226781c2d7a015340d0089e399b5)
+ [1] fix-autopsy patch
+ [2] fix-eh_skip_recovery patch
+ [3] improve-EH-actions-and-EHI-handling patch
+ [4] PHY-reset-requires-writing-0x4-to-SControl

This patchset is also available in the following git tree.

 http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=powersave
 git://htj.dyndns.org/libata-tj powersave

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/11966
[2] http://article.gmane.org/gmane.linux.ide/12001
[3] http://article.gmane.org/gmane.linux.ide/12002
[4] http://article.gmane.org/gmane.linux.ide/11870


