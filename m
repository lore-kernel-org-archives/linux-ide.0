From: dalgoda@ix.netcom.com (Mike Castle)
Subject: CMD640 as a module: yes or no?
Date: Thu, 01 Jul 2004 14:51:48 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <kkder1x7m2.ln2@thune.mrc-home.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b.mail.sonic.net ([64.142.19.5]:1681 "EHLO b.mail.sonic.net")
	by vger.kernel.org with ESMTP id S266304AbUGAVvw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Jul 2004 17:51:52 -0400
Received: from thune.mrc-home.org (adsl-209-204-178-126.sonic.net [209.204.178.126])
	by b.mail.sonic.net (8.12.11/8.12.11) with ESMTP id i61Lpnol016114
	for <linux-ide@vger.kernel.org>; Thu, 1 Jul 2004 14:51:49 -0700
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Kernel 2.4.26 still has issues with building IDE as a module if you try to
also include CMD640.  That is the undefined init_cmd640_vlb problem.

I've often seen this trivial patch floating around:


--- Config.in.orig	2004-04-14 06:05:29.000000000 -0700
+++ Config.in	2004-07-01 14:06:09.000000000 -0700
@@ -27,8 +27,8 @@
 
    comment 'IDE chipset support/bugfixes'
    if [ "$CONFIG_BLK_DEV_IDE" != "n" ]; then
-      dep_bool '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640 $CONFIG_X86
-      dep_bool '    CMD640 enhanced support' CONFIG_BLK_DEV_CMD640_ENHANCED $CONFIG_BLK_DEV_CMD640
+      dep_tristate '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640 $CONFIG_X86
+      dep_mbool '    CMD640 enhanced support' CONFIG_BLK_DEV_CMD640_ENHANCED $CONFIG_BLK_DEV_CMD640
       dep_bool '  ISA-PNP EIDE support' CONFIG_BLK_DEV_ISAPNP $CONFIG_ISAPNP
       if [ "$CONFIG_PCI" = "y" ]; then
 	 bool '  PCI IDE chipset support' CONFIG_BLK_DEV_IDEPCI


But, Alan Cox, in a message at:
http://groups.google.com/groups?selm=20030510153020%24418a%40gated-at.bofh.it

Suggests that CMD640 should not be loaded as a module.

Yet at least one distribution (Debian) seems to be using the above patch.

So, I'm trying to get a definitive answer:

Are module IDE and CMD640 support mutually exclusive?  If so, can we get
it fixed so that if one builds IDE as a module, we can't select CMD640
and get rid of the unresolved init_cmd640_vlb error?  Also, should we
yell at said distributions and tell them not to do that?

If it IS supported, than is the above patch sufficient?  If so, can
we get it in for 2.4.27?  If not, what is sufficient, and can that get
into 2.4.27?  If it's too hard to do now, can we go back to preventing
the error for the moment by treating them as mutual exclusive?

Thanks,
mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
