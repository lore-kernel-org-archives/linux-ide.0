From: "Adam J. Richter" <adam@yggdrasil.com>
Subject: 2.5.70-bk[56] breaks disk partitioning with multiple IDE disks
Date: Sun, 1 Jun 2003 15:59:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200306012259.h51Mx2i14095@freya.yggdrasil.com>
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

	Disk partition under linux-2.5.70-bk[56] systems with two
IDE disks is broken.  Under these kernels, the first disk gets
the partitioning of the second disk.  Reverting drivers/ide/ide.c
to the 2.5.70-bk4 version makes the problem go away.

	However, there were other changes made to ide.c that are
probably not related to this problem, and I haven't yet analyzed the
problem enough to suggest a potentially correct patch.

	Note that I use user-level disk partition table parsing via
partx from util-linux and run ide as a loadable module.  It is
possible that other configuations might not experience this problem.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
