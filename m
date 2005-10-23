From: Douglas Gilbert <dougg@torque.net>
Subject: [PATCH 0/2] libata: MODE SELECT
Date: Sun, 23 Oct 2005 16:23:03 +1000
Message-ID: <435B2C47.8070708@torque.net>
Reply-To: dougg@torque.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zorg.st.net.au ([203.16.233.9]:50108 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S1751408AbVJWGWH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Oct 2005 02:22:07 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, htejun@gmail.com

Jeff,
Here is another shot at adding MODE SELECT to
libata. I have used sat-r06, sbc-3 and spc-4 as
a guide. Compliance on the ATA side has some issues:
  - no mechanism to issue 2 or more ATA commands
    when translating a single SCSI command [in the
    upstream branch, there have been patches ...]
  - relies on the dev->id array (IDENTIFY DEVICE response)
    always being up to date. Despite assurances I cannot
    see how that is the case when multiple hosts
    (initiators) can access a SATA disk.

This patch is broken into two parts and is against
libata-dev's upstream branch:
  1) strengthen MODE SENSE processing and make
     default mode pages visible within libata-scsi.c
  2) add MODE SELECT SCSI command support.

Two attributes can be changed with these patches:
  - WCE: write cache enable [cache mode page]
  - DRA: disable read ahead [cache mode page]

Testing: upstream branch seems to be broken wrt SG_IO
as the largest amount of data that can be sent per
command is 4 KB. A 50 MB write (segmented to 4 KB per
command) slowed down from 14 seconds with WCE=1 to
107 seconds with WCE=0. sg_dd was used for the transfer
and sdparm to change WCE. ST380013AS disk and
sata_sil LLD.

The attachments are mime text because I wasn't able
to do otherwise.

Signed-off-by: Douglas Gilbert <dougg@torque.net>

Doug Gilbert
