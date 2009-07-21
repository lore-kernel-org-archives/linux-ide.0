From: Learner Study <learner.study@gmail.com>
Subject: command queue errors with 2.6.27
Date: Mon, 20 Jul 2009 20:08:40 -0700 (PDT)
Message-ID: <24580999.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kuber.nabble.com ([216.139.236.158]:58641 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754590AbZGUDIk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jul 2009 23:08:40 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1MT5ia-0007jC-TO
	for linux-ide@vger.kernel.org; Mon, 20 Jul 2009 20:08:40 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


I see the following command queue errors with kernel 2.6.27 and 2.6.31.

My setup has RocketRaid SATA controller and a few HDDs connected. The disks
are mapped to iSCSI initiator. When the initiator does Reads on the LUNs, I
get the following errors. I have tried various HDDs/contollers but no luck
;-( The same works well is 2.6.21.

Any ideas....Thanks!


ata1: mv_process_crpb_response: no qc for tag=10
ata1.00: qc timeout (cmd 0x2f)
ata1: failed to read log page 10h (errno=-5)
ata1.00: exception Emask 0x1 SAct 0xffff SErr 0x0 action 0x6 frozen
ata1.00: edma_err_cause=02000084 pp_flags=00000003, dev error, EDMA
self-disable
ata1.00: cmd 60/80:00:80:4f:00/00:00:00:00:00/40 tag 0 ncq 65536 in
         res 41/54:00:00:58:00/54:04:00:00:00/40 Emask 0x89 (media error)
ata1.00: status: { DRDY ERR }
ata1.00: error: { UNC IDNF ABRT }
ata1.00: cmd 60/80:08:00:52:00/00:00:00:00:00/40 tag 1 ncq 65536 in
         res 41/54:00:00:58:00/54:04:00:00:00/40 Emask 0x89 (media error)
ata1.00: status: { DRDY ERR }
ata1.00: error: { UNC IDNF ABRT }
ata1.00: cmd 60/80:10:00:47:00/00:00:00:00:00/40 tag 2 ncq 65536 in
         res 41/54:00:00:58:00/54:04:00:00:00/40 Emask 0x89 (media error)
ata1.00: status: { DRDY ERR }
ata1.00: error: { UNC IDNF ABRT }
ata1.00: cmd 60/80:18:80:54:00/00:00:00:00:00/40 tag 3 ncq 65536 in
         res 41/54:00:00:58:00/54:04:00:00:00/40 Emask 0x89 (media error)
ata1.00: status: { DRDY ERR }
ata1.00: error: { UNC IDNF ABRT }
ata1.00: cmd 60/00:20:00:58:00/04:00:00:00:00/40 tag 4 ncq 524288 in
         res 41/54:00:00:58:00/54:04:00:00:00/40 Emask 0x89 (media error)
ata1.00: status: { DRDY ERR }
-- 
View this message in context: http://www.nabble.com/command-queue-errors-with-2.6.27-tp24580999p24580999.html
Sent from the linux-ide mailing list archive at Nabble.com.

