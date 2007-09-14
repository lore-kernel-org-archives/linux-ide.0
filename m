From: Jeff Garzik <jeff@garzik.org>
Subject: Re: SG_IO and HDIO_DRIVE_TASKFILE issue
Date: Fri, 14 Sep 2007 13:12:14 -0400
Message-ID: <46EAC0EE.3000101@garzik.org>
References: <365498.12393.qm@web35414.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42320 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874AbXINRM0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Sep 2007 13:12:26 -0400
In-Reply-To: <365498.12393.qm@web35414.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kantor Zsolt <kantorzsolt@yahoo.com>
Cc: linux-ide@vger.kernel.org

Kantor Zsolt wrote:
> Can be executed a SG_IO command for a ATA hard drive ? because I have tried everything. I have

Yes.


> supported or SG_IO which is not working like HDIO_DRIVE_TASKFILE

SG_IO requires a vastly different format than HDIO_DRIVE_TASKFILE.  Read 
the sg documentation, and then reference SAT (http://www.t10.org/) for 
the definitions of ATA(12) and ATA(16) commands.

	Jeff



