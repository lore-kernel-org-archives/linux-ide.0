From: "McDonald, Mike-P56995" <Michael.McDonald@gdc4s.com>
Subject: Promise SATA378 driver fro RHEL4?
Date: Mon, 17 Apr 2006 18:07:16 -0700
Message-ID: <EC96F708FFAAEC4CBFD479171F34120801DA95A4@AZ25EXM04.gddsi.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.gdds.com ([63.226.32.21]:4882 "EHLO az25ege01.gdc4s.com")
	by vger.kernel.org with ESMTP id S932097AbWDRBHc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Apr 2006 21:07:32 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org


  One of the guys here ordered a couple of the Alienware 7700 laptops
that contain the Promise PDC20378 SATA controller (PCI id: 105a 3373).
It has IDE drives connected to it.

  Unfortunately, for reasons beyond my immediate control, we have to run
RedHat Enterprise Linux 4 on the machines. It does not recognize the
controller. I know Fedora 4 sort of supports it in non RAID mode. (The
machines are flakey running this kernel.) Fedora 5 supports the RAID
mode and seems stable. 

  I've tried backporting the FC5 driver to the RHEL4 kernel buit it
always hangs right after detecting the second drive. (libata has been
changed between FC5's 2.6.15 and RHEL4's 2.6.9 making it a non trivial
job.)

  So, do you know of anyone who has gotten the Promise 378 controller to
work successfully in RHEL4's 2.6.9 kernel? Or anyone else's 2.6.9
kernel?

  Thanks,

  Michael McDonald
  michael.mcdonald@gdc4s.com
  (480) 441-0548 
