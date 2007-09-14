From: Kantor Zsolt <kantorzsolt@yahoo.com>
Subject: SG_IO and HDIO_DRIVE_TASKFILE issue
Date: Fri, 14 Sep 2007 09:58:39 -0700 (PDT)
Message-ID: <365498.12393.qm@web35414.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web35414.mail.mud.yahoo.com ([66.163.179.123]:44511 "HELO
	web35414.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754295AbXINQ6j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Sep 2007 12:58:39 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Can be executed a SG_IO command for a ATA hard drive ? because I have tried everything. I have
deeply studied the hdparm (version 7.7) source code and I came to realize that ATA commands like
setting the acoustic value, setting the drive write-caching, identify device can not be executed
with the SG_IO, so after hdparm tries with SG_IO which can't be executed jumps with a goto to the
legacy command (HDIO_DRIVE_CMD) to execute the required task. And I also know that libata don't
include support for the HDIO_DRIVE_TASKFILE command, so my question is how can I have full control
over a hard drive because for that you must to use either HDIO_DRIVE_TASKFILE but that is not
supported or SG_IO which is not working like HDIO_DRIVE_TASKFILE


      ____________________________________________________________________________________
Catch up on fall's hot new shows on Yahoo! TV. Watch previews, get listings, and more!
http://tv.yahoo.com/collections/3658 
