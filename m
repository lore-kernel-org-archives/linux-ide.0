From: devzero@web.de
Subject: ata_piix init/performance regression ?
Date: Sat, 08 Dec 2007 00:46:59 +0100
Message-ID: <32463620@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756649AbXLGXrV@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello !

on my old fujitsu-siemens lifebook, booting is at least 20 seconds slower as before.

on ata_piix init i can see 2 longer delays of ~10 seconds each, which didn`t happen before.

i`m using SuSE kernel of the day from http://ftp.suse.com/pub/projects/kernel/kotd/

problem exists with these kernels:
kernel-vanilla-2.6.24_rc3_git3-20071201095839
kernel-default-2.6.24_rc3_git3-20071201095839
kernel-default-2.6.24_rc4_git3-20071206172629
kernel-vanilla-2.6.24_rc4_git3-20071206172629

problem didn`t exist with this one:
kernel-default-2.6.22.12-0.1 (opensuse 10.3 default)

please see https://bugzilla.novell.com/show_bug.cgi?id=345442 for more details.

regards
roland

_____________________________________________________________________
Der WEB.DE SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
http://smartsurfer.web.de/?mc=100071&distributionid=000000000066

