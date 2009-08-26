From: Kurt Newman <knewman@globaldataguard.com>
Subject: aic94xx and the adaptec sata raid controller (aic-9410)
Date: Wed, 26 Aug 2009 12:09:45 -0500
Message-ID: <4A956C59.2010709@globaldataguard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.globaldataguard.com ([67.210.231.115]:57255 "EHLO
	mail2.globaldataguard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbZHZRQK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Aug 2009 13:16:10 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Since the e-mail for Luben Tuikov, the original writer of the aic94xx
driver, no longer works, I was hoping to ask someone a couple simple
questions since it relates to the SATA subsystem.

If this is the incorrect mailing list, I'm very sorry.  Could you refer
me to the proper one?  I'm at a dead end and hoping someone can point me
in a better direction.

My question is:
Does the aic94xx driver enable the use of the Adaptec SATA Raid
functionality, such that, I'm able to see a single "raided" drive,
instead of multiple, individual ones.

Background information:
Thus far, loading the aic94xx module simply says:
"aic94xx: Adaptec aic94xx SAS/SATA driver version 1.0.2-2 loaded".

However, beyond that message and several /sys entries added, I'm unable
to access the raid-1 "drive" created by the adaptec utility.  With or
without that driver loaded, I still only have access to each individual
drive (/dev/sda and /dev/sdb) using ata_piix.

I'm currently attempting to use kernel 2.6.18 (which is patched by
RedHat to create kernel-2.6.18-128.7.1.el5).
