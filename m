From: "Eric A. Cottrell" <eac@shore.net>
Subject: Re: LIBATA AHCI engine timeout hang with ATAPI devices
Date: Thu, 14 Apr 2005 22:54:29 -0400
Message-ID: <425F2CE5.2010904@shore.net>
References: <4256D1A9.6080401@shore.net> <4256D7CA.7030908@pobox.com> <42570F07.6080406@shore.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp3.primushost.com ([209.58.220.67]:32991 "EHLO
	smtp3.primushost.com") by vger.kernel.org with ESMTP
	id S261726AbVDOCyb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Apr 2005 22:54:31 -0400
In-Reply-To: <42570F07.6080406@shore.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org

Hello,

I made some progress fixing ATAPI problems even with my system being down a few days due to a video card failure.

One ATAPI problem area is the lack of filling the sense buffer when there is an error.  There are ata to scsi mapping functions for 
hard drives but nothing for ATAPI.  The SCSI system sends some commands that are not supported by ATAPI so an illegal request sense 
key should be sent up from the driver.

I recently noticed the docs for the PACKET command said that ATAPI devices return error information in the task file.  One of the 
bytes looks like information in the third byte of the sense information.  I added a function that translated the ATAPI error 
information into a basic SCSI sense block without any additional sense information.

Using the AHCI driver I do see valid sense information.  The request luns command returns a illegal request as it is not supported 
by the drive.  The ata_piix driver always returned a zero for the sense.  I need to do some more work to fix it and other problems.

73 Eric  eac@shore.net
