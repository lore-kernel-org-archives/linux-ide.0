From: Oliver Elphick <olly@bray-healthcare.com>
Subject: libata with sata_sis does not detect SATA connections
Date: Tue, 20 Sep 2005 12:09:53 +0100
Message-ID: <1127214593.7434.18.camel@ruth.lfix.co.uk>
Reply-To: olly@bray-healthcare.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:58380 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S964975AbVITLKG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Sep 2005 07:10:06 -0400
Received: from lfix.demon.co.uk ([80.177.205.209] helo=cerberus.lfix.co.uk)
	by anchor-post-35.mail.demon.net with esmtp (Exim 4.42)
	id 1EHfvH-000AnG-GQ
	for linux-ide@vger.kernel.org; Tue, 20 Sep 2005 11:04:27 +0000
Received: from ruth.lfix.co.uk ([192.168.1.4])
	by cerberus.lfix.co.uk with esmtp (Exim 4.50)
	id 1EHg0S-0007Uk-FJ
	for linux-ide@vger.kernel.org; Tue, 20 Sep 2005 12:09:48 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Kernel 2.6.12 with Debian patches
Asus K8S-MX-EAYZ motherboad with Sis chipset
2 SATA drives

lspci reports a Sis RAID bus controller with id 0182 (subsystem 8139).

libata loads but does not detect anything.  There is no output from
sata_sis in dmesg.  The BIOS does report 2 SATA drives.  (The
motherboard's RAID is not used and the BIOS reports the two drives as
singles.)

I see there have been some patches relating to this chip, but this is my
first experience of SATA, so I don't know what to look for.  Will
uploading a patch be sufficient? or do I need to go to a later kernel
version?

(I can supply further information as required.)

Oliver Elphick

