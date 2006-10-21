From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET] ahci updates regarding vt8251 support, take #2
Date: Sat, 21 Oct 2006 15:23:58 -0400
Message-ID: <453A73CE.60205@pobox.com>
References: <11609522031228-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:14062 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1422839AbWJUTYC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Oct 2006 15:24:02 -0400
In-Reply-To: <11609522031228-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, aalderd.boac@wanadoo.nl, linux-ide@vger.kernel.org

Patchset looks OK to me, with a few notes:

1) might want to separate out this change and forward it to #upstream-fixes:
-	ahci_tf_read(ap, &tf);
-	if (tf.command & (ATA_BUSY | ATA_DRQ)) {
+	if (ahci_check_status(ap) & (ATA_BUSY | ATA_DRQ)) {



2) In general, it's a good idea to clear SError after twiddling with the 
phy.  Not just on vt8521.

3) Any positive test results yet?

