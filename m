From: Steve Graham <stgraham2000@yahoo.com>
Subject: SIL3512 lockup problem using driver verion 0.9 and Linux 2.6.14
Date: Thu, 7 Dec 2006 08:08:50 -0800 (PST)
Message-ID: <74342.74582.qm@web52304.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web52304.mail.yahoo.com ([206.190.48.147]:30991 "HELO
	web52304.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1032339AbWLGQIw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Dec 2006 11:08:52 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi Jeff,

My name is Steve Graham and I work for a small
startup.  Our company is developing a server board
with the Silicon Images 3512 and we are getting some
strange lockups during high levels of disk activity. 
The test I'm currently running to cause the problem is
to run the following concurrently: 'nbench',
'tiobench', and an 'scp' of a 200Meg file to the sata
drive.  Every so often I will get the following
message:

ata1: status=0x51 { DriveReady SeekComplete Error }
  ata1: error=0x04 { DriveStatusError }

This doesn't mean the drive is locked up and doesn't
appear to have any side effects on its own but
eventually I will get the above message that is
immediately followed by the next block of messages
that do result in a lockup:

ata1: command 0x35 timeout, stat 0xd1 host_stat 0x1
  ata1: status=0xd1 { Busy }
  sd 0:0:0:0: SCSI error: return code = 0x8000002
  sda: Current: sense key=0xb
      ASC=0x47 ASCQ=0x0
  end_request: I/O error, dev sda, sector 17033103
  ata1: Abnormal status 0xD1 on port 0xC001E087
  ata1: Alternate status 0xD1 on port 0xC001E08A
  ata1: Error 0xd1
  ata1: Abnormal status 0xD1 on port 0xC001E087
  ata1: Alternate status 0xD1 on port 0xC001E08A
  ata1: Error 0xd1
  ata1: Abnormal status 0xD1 on port 0xC001E087
  ata1: Alternate status 0xD1 on port 0xC001E08A

These messages will repeat every 30 seconds and at
this point all disk accesses are locked.

This problem has occured with both a Seagate and
Western Digital drive so I don't think I've got drive
issues.  Unfortunately I'm not at my desk or I would
tell you the model numbers on the above drives.

It looks like after the DriveStatusError the drive
will sometimes report that it is in the 'Busy' state
and it never returns from that state.  That causes the
WRITE_REQ ATA command to always timeout waiting for
the drive to become ready.

>From reading the forums, it looks like this isn't a
new problem but it also looks like it was a problem
that should have been resolved in earlier versions of
the driver.

Do you know of any other fixes that have been made to
this driver that I can try and if not do you have any
suggestions on where I may start to look to try to
debug this problem.  Also, is there a safe way to
'force' the drive out of this 'busy' state that will
not result in us losing data.

Thanks,

Steve Graham... 


 
____________________________________________________________________________________
Do you Yahoo!?
Everyone is raving about the all-new Yahoo! Mail beta.
http://new.mail.yahoo.com
