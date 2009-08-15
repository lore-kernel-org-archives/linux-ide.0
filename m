From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: ata_tf_read_block() question
Date: Sat, 15 Aug 2009 22:48:43 +0900 (JST)
Message-ID: <20090815.224843.240484147.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754474AbZHONsr@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

I have a question on CHS calculation in ata_tf_read_block().

The calculation in ata_tf_read_block() is:
	block = (cyl * dev->heads + head) * dev->sectors + sect;

but ata_build_rw_tf() does:
	track = (u32)block / dev->sectors;
	cyl   = track / dev->heads;
	head  = track % dev->heads;
	sect  = (u32)block % dev->sectors + 1;

It seems inconsistent.  The correct calculation is:
	block = (cyl * dev->heads + head) * dev->sectors + sect - 1;
isn't it?

I don't have any real problem.  Just noticed by code reading.
---
Atsushi Nemoto
