From: Matthew Wilcox <matthew@wil.cx>
Subject: ATA support for 4k sector size
Date: Wed, 25 Feb 2009 17:24:56 -0500
Message-ID: <1235600698-6446-1-git-send-email-matthew@wil.cx>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762495AbZBYWZT@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


The two patches following this add support for drives which have sector
sizes other than 512 bytes.  I haven't been able to test this as I don't
have the hardware.

Individual host drivers will have to be updated to support sizes other
than 512 bytes.

Support for logical sector sizes that differ from physical sector sizes
depends on the READ CAPACITY 16 patch I posted in December that isn't in
scsi-misc yet.

The approach I've taken to generating the tables of which commands need
a 512-byte transfer size and which use the drive's sector size command is
'innovative'.  Review is encouraged ;-)
