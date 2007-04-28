From: "Geoff Kuchera" <geoff@abu.mn.org>
Subject: sata sil driver...
Date: Fri, 27 Apr 2007 21:10:10 -0500 (CDT)
Message-ID: <3062.192.168.25.101.1177726210.squirrel@mail.tortpro.net>
Reply-To: geoff@abu.mn.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from newann.skypoint.net ([199.86.32.14]:2713 "EHLO
	newann.skypoint.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030456AbXD1CwJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Apr 2007 22:52:09 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello I'm trying to get  an array of drives to work with the following
configuration:

7 SEAGATE 750GB ST3750640AS SATA300 16MB drives
2 4 drive hot swap SATA II Drive Bays
2 Silicon Image 3114 4 port SATA controllers w/ BIOS Ver 5.4.03 (not RAID
BIOS)

System:  ASUS A7N8X with an AMD 2800+ and 1gb ram.

a Debian Linux System with kernal 2.6.20.4
with the SATA_Sil driver compiled as a module.

------

Symptoms:  The system finds all the drives and everything appears to work
correctly, but when I partition and make a file system on the drive and
then copy files to the drive some of the files become corrupted in the
transfer process.  I have eliminated the drives from the issue by setting
them up on a different controller and testing them and they are fine.  Any
thoughts or recommendations?  I have tried everything I can think of, I'm
willing to test changes, anything to get this working reliably..

Thanks,
Geoff Kuchera



