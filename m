From: Marvin Schmidt <marvin_schmidt@gmx.net>
Subject: end_request: I/O error, dev hda, sector 0
Date: Fri, 17 Jul 2009 15:31:53 +0200
Message-ID: <1247837513.12567.16.camel@pythagoras.homenetwork>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:46575 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934605AbZGQNac (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Jul 2009 09:30:32 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

After updating from 2.6.30 to 2.6.31-rc1 i got a lot of

	end_request: I/O error, dev hda, sector 0

messages when working on my dm-crypt'ed ext4 partition and I'm still
facing that issue with 2.6.31-rc3.

I'm able to reproduce it doing:
# cryptsetup luksOpen /dev/hda4 crypt-home
# mount /home
login as user
$ cp /path/to/some/file .

The relevant fstab-entry looks like:
/dev/mapper/crypt-home  /home  ext4  defaults,noauto  0  0

I bisected it to the following commit:

commit 647c7db14ef9cacc4ccb3683e206b61f0de6dc2b
Author: Mikulas Patocka <mpatocka@redhat.com>
Date:   Mon Jun 22 10:12:23 2009 +0100

    dm crypt: support flush
    
    Flush support for dm-crypt target.
    
    Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
    Signed-off-by: Alasdair G Kergon <agk@redhat.com>


--

Do you need any more information/my config/etc.?

Best regards,
Marvin Schmidt

	
	


