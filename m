From: Nicholas Miell <nmiell@comcast.net>
Subject: SATA timeouts with Seagate disk on VIA VT6420 controller
Date: Wed, 15 Feb 2006 21:44:14 -0800
Message-ID: <1140068654.3274.12.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932481AbWBPFoS@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

>From time to time, I've been experiencing timeouts with my SATA disk (a
Seagate ST3300831AS) attached to a VIA VT6420 controller on a VIA
K8T800-based MSI motherboard. This has happened somewhat rarely on a
variety of Fedora kernel versions.

Basically, sometimes IO will get really slow and I'll start getting
"ata1: command 0x35 timeout, stat 0x50 host_stat 0x4" in my logs, with
the occasional "ata1: command 0x25 timeout, stat 0x50 host_stat 0x4" and
"ata1: command 0xb0 timeout, stat 0x50 host_stat 0x0" thrown in for good
measure.

The disk (and/or controller) isn't unresponsive -- I can do a smartctl
-a -d ata /dev/sda and it'll complete (eventually), and IO to the disk
continues (very slowly), but it's generally unusable until the next
reboot.

Any help would be appreciated.

	Thanks, Nicholas.

-- 
Nicholas Miell <nmiell@comcast.net>
