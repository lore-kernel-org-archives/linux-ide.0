From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: [PATCH 0/3] at91_ide driver submission
Date: Tue, 3 Feb 2009 11:46:35 +0100
Message-ID: <200902031146.35562.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:62136 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751652AbZBCKqx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Feb 2009 05:46:53 -0500
Received: from ebg226.internetdsl.tpnet.pl (HELO staszek-desktop.local) (stf_xl@wp.pl@[83.14.136.226])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
          for <linux-ide@vger.kernel.org>; 3 Feb 2009 11:46:42 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>
Cc: linux-arm-kernel@lists.arm.linux.org.uk

Hi

I would like to submit patches related with at91_ide driver. 

This is driver for AT91SAM9 Static Memory Controller configured
to work in Compact Flash True IDE logic.

Driver is divided into tree parts: generic IDE, processor specific 
(currently only AT91SAM9263 is supported) and board specific.
However I not submit support for any board yet.

Driver was tested with Kevlatek's custom board and it works very
well. Current performace on PIO4 is 6.2 MB/s (hdparm -t /dev/hda).

We still is not tested with Atmel Evaluation Kit. We have
some serious hardware problem with our SAM9263EK board.
When connecting CF through HDD 1,8'' adapter system
hangs during boot. After connecting Toshiba HDD,
drive is always in BUSY state and driver can not do any probe.
So currently I submit patches without any board code
modification. Maybe we will submit Kelvatek's board file
soon.

The patches are against Bart's ide-2.6 tree:

1 - allow to wrap interrupt handler
2 - add at91_ide driver
3 - add IDE support for AT91SAM9263 cpu

Regards
Stanislaw Gruszka
