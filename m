From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 4/4] implement PMP support, take 5
Date: Mon, 16 Jul 2007 18:46:03 +0900
Message-ID: <1184579163885-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:53686 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755046AbXGPJqI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 05:46:08 -0400
Received: by nz-out-0506.google.com with SMTP id s18so784842nze
        for <linux-ide@vger.kernel.org>; Mon, 16 Jul 2007 02:46:08 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>, htejun@gmail.com

Hello, all.

his is the fourth take of libata-pmp patchset.  This patchset contains
8 patches and implements PMP support.

Changes from the last take[L] are.

* PMP error message fixed.
* build fix when PM and/or ACPI is disabled
* ahci/sata_sil24 prep patches moved to misc-updates patchset as
  requested by Jeff.

Tested extensively with sil3214/32, ICH9R, JMB360/3 combined with
sil3726, 4726 and 5744 port multipliers.  Disks from all major vendors
and an SATAPI device is used as downstream devices.  sil5744 and 3726
behave very nicely on all controllers.  Hotplugging and suspend/resume
work well too.  There are some remaining issues.

* When attached to AHCI controller (ICH9R, JMB360/3), NCQ doesn't
  work.  Things look okay as long as only one command is in flight but
  as soon as the second command is issued (to the same device), hell
  breaks loose and all sorts of errors occur including device abort,
  bad PMP number and interface fatal error.  This behavior is common
  across all PMP chips.  I've disabled NCQ if PMP is attached to an
  ahci controller for now.

* Sil4726 is a bit too quirky.  Without the first fan-out port
  occupied, the thing acts really weirdly.  As long as the first port
  is occupied, it works okay.  This is reportedly fixed by new
  firmware.  I tried to update the firmware but installing 3124 driver
  on Windows was just too difficult for me and I gave up after thirty
  painful minutes.  Anyone up for testing?

* Again, Sil4726 doesn't like ahci driver initialization sequence.
  During driver initialization, the whole controller is reset and the
  PHY seems to go offline and back online.  Sil4726 doesn't like it
  and goes out for lunch for several secs after that which makes
  initial probing think that the port is empty.  After probing is
  complete, Sil4726 comes back and gets detected but at that point
  detection is asynchronous and if boot device is on one of fan-out
  ports, it can be a problem.  Again, this might have been fixed by
  new firmware.  Anyone up for testing?

* The long boot delay on ASUS boards with on-board PMP chips should be
  fixed by this patchset but I don't have such a board or Sil4723
  which is used on those baords, so I'm not sure.  Anyone up for
  testing?

This patchset is against

  libata-dev#upstream (d79eb6de54f180dc83b488b20747f0097fde3dea)
  + [1] misc-updates patchset
  + [2] libata-link patchset
  + [3] libata-pmp-prep patchset

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/20128
[1] http://thread.gmane.org/gmane.linux.ide/20824
[2] http://thread.gmane.org/gmane.linux.ide/20842
[3] http://thread.gmane.org/gmane.linux.ide/20857


