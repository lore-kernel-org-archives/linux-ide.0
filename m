From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: 2.6.19.2 -> 2.6.20-rc5 libata regression
Date: Sun, 21 Jan 2007 05:16:21 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701210515510.3703@p34.internal.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751322AbXAUKQX@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

2.6.19.2:
# hddtemp /dev/sda
/dev/sda: WDC WD740GD-00FLC0: 27C

2.6.20-rc5:
# hddtemp /dev/sda
/dev/sda: ATA WDC WD740GD-00FL: S.M.A.R.T. not available
