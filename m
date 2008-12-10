From: "Raz Ben-Yehuda" <razb@bitband.com>
Subject: Intel X25-M MLC SSD benchmarks
Date: Wed, 10 Dec 2008 23:15:12 +0200
Message-ID: <83CA05F64804AF43B8F733C4ABDFAA51022D04D4@mail1.bitband.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fw.bitband.com ([213.8.50.174]:45508 "EHLO mail.bitband.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754988AbYLJVPT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Dec 2008 16:15:19 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org

Hello
I am wondering if anyone tried Intel new disks. I benchmark them and I
am a bit confused.
According to the spec a single disk should provide 70MB/s write and 250
MB/s read. Reads are ok. I am reaching this number, but writes are bad.
With writes I am getting 20MB/s.
I am using a dd for the test, and a deadline-line scheduler. 
 
Thank you
Raz

