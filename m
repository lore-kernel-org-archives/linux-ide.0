From: Kantor Zsolt <kantorzsolt@yahoo.com>
Subject: no data with HDIO_DRIVE_TASK
Date: Wed, 5 Sep 2007 16:03:09 -0700 (PDT)
Message-ID: <273942.73452.qm@web35406.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web35406.mail.mud.yahoo.com ([66.163.179.115]:38603 "HELO
	web35406.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757518AbXIEXDK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Sep 2007 19:03:10 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

HI, I have a question. The HDIO_DRIVE_TASK can not return data on the PIO or DMA protocol ? Only
the HDIO_DRIVE_CMD and HDIO_DRIVE_TASKFILE can do that ? Because HDIO_DRIVE_TASK with the
WIN_IDENTIFY command for example returns 0, so ioctl was executed successful, but no data can be
found in the additional 512 bytes. 
 
Thanks
  Kantor


      ____________________________________________________________________________________
Luggage? GPS? Comic books? 
Check out fitting gifts for grads at Yahoo! Search
http://search.yahoo.com/search?fr=oni_on_mail&p=graduation+gifts&cs=bz
