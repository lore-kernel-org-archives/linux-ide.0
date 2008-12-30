From: hongbinghu <huhb@lemote.com>
Subject: STD problem about IDE
Date: Tue, 30 Dec 2008 21:12:08 +0800
Message-ID: <495A1E28.3000405@lemote.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020102020000030401070705"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [222.92.8.141] ([222.92.8.141]:45822 "EHLO lemote.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751551AbYL3NXS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Dec 2008 08:23:18 -0500
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id EEC6731C925
	for <linux-ide@vger.kernel.org>; Tue, 30 Dec 2008 20:58:22 +0800 (CST)
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ec0k4iQm800V for <linux-ide@vger.kernel.org>;
	Tue, 30 Dec 2008 20:58:16 +0800 (CST)
Received: from [172.16.2.246] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id A27F531C924
	for <linux-ide@vger.kernel.org>; Tue, 30 Dec 2008 20:58:16 +0800 (CST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020102020000030401070705
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit

hi, everyone.

I want to ask some problems.

when i use Hitachi disk, STD(suspend to disk) works ok.
I debug it ,and find when the IDE resumes, it issues many many interrupts
and these interrups don't be handled. Finally, kernel disable the irq.

why ? and what happened?

Thanks.


--------------020102020000030401070705
Content-Type: text/x-vcard; charset=utf-8;
 name="huhb.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="huhb.vcf"

YmVnaW46dmNhcmQNCmZuO3F1b3RlZC1wcmludGFibGU6PUU4PTgzPUExPUU2PUI0PUFBPUU1
PTg1PUI1DQpuO3F1b3RlZC1wcmludGFibGU6Oz1FOD04Mz1BMT1FNj1CND1BQT1FNT04NT1C
NQ0Kb3JnO3F1b3RlZC1wcmludGFibGU7cXVvdGVkLXByaW50YWJsZTo9RTQ9Qjg9QUQ9RTc9
QTc9OTE9RTk9QkU9OTk9RTY9QTI9QTY9RTc9QTc9OTE9RTY9OEE9ODA9RTY9OUM9ODk9RTk9
OTk9OTA9RTU9DQoJPTg1PUFDPUU1PThGPUI4Oz1FOT04Mz1BOD1FOT05Nz1BODo9RTg9QkQ9
QUY9RTQ9QkI9QjY9RTk9ODM9QTgNCmFkcjtxdW90ZWQtcHJpbnRhYmxlO2RvbTo7Oz1FNj1C
MT05Rj1FOD04Qj04Rj1FNz05Qz04MT1FNT1COD1COD1FNz04Nj05Rj1FNT1COD04Mj1FOD05
OT05RT1FNT1CMT1CMT1FOT0NCgk9OTU9ODc9RTY9QTI9QTY9RTU9ODU9QjA9RTU9Qjc9QTU9
RTQ9Qjg9OUE9RTU9OUI9QUQNCmVtYWlsO2ludGVybmV0OkUtbWFpbDpodWhiQGxlbW90ZS5j
b20NCnRpdGxlO3F1b3RlZC1wcmludGFibGU6PUU4PTgxPThDPUU1PThBPUExOj1FOD1CRD1B
Rj1FND1CQj1CNj1FNT1CNz1BNT1FNz1BOD04Qj1FNT1COD04OA0KdGVsO3dvcms6VGVsOjEz
MDYzNzcyNzQ3DQp0ZWw7aG9tZTpNU046aHVoYjA0QGdtYWlsLmNvbQ0KdmVyc2lvbjoyLjEN
CmVuZDp2Y2FyZA0KDQo=
--------------020102020000030401070705--
