From: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 0/5] libata: various queued changes
Date: Thu, 28 Sep 2006 20:26:01 -0400
Message-ID: <20060929002601.GA7397@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161211AbWI2A0J@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org


These five patches are random bits I've queued in
libata-dev.git#upstream:

[libata] Use new PCI_VDEVICE() macro to dramatically shorten ID lists
[libata] minor PCI IDE probe fixes and cleanups
[libata] init probe_ent->private_data in a common location
[libata] Print out Status register, if a BSY-sleep takes too long
[libata] PCI ID table cleanup in various drivers
