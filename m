From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [BUG] libahci returns stale result tf much of the time.
Date: Fri, 24 Sep 2010 09:11:33 -0400
Message-ID: <4C9CA385.5090709@teksavvy.com>
References: <4C9C3878.9010206@teksavvy.com> <AANLkTi=85A9ueu9YYrh0jOKFgc+fqbaUhkRLt7=Bzx2M@mail.gmail.com> <4C9C44D0.1030409@teksavvy.com> <AANLkTinOECHi_7+y7yT-GZXxW0c4vrJOuRz80kejt2+N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:58170 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750816Ab0IXNMC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Sep 2010 09:12:02 -0400
In-Reply-To: <AANLkTinOECHi_7+y7yT-GZXxW0c4vrJOuRz80kejt2+N@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Seed <seedrubbish@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 10-09-24 03:01 AM, Seed wrote:
> On Fri, Sep 24, 2010 at 4:27 PM, Mark Lord<kernel@teksavvy.com>  wrote:
>> The bug seems to be in the libahci code somewhere.
>
> ahci_qc_fill_rtf seems to be the function converting FIS to result_tf.
..

Yeah, that's as far as I got with it last night.
If you apply this patch (below), it makes the problem more "obvious",
though I still don't see exactly how that struct gets updated.

--- a/drivers/ata/libahci.c	2010-09-24 02:40:24.722887047 -0400
+++ b/drivers/ata/libahci.c	2010-09-24 09:10:21.761520099 -0400
@@ -1838,6 +1838,7 @@
  		d2h_fis += qc->dev->link->pmp * AHCI_RX_FIS_SZ;
  
  	ata_tf_from_fis(d2h_fis, &qc->result_tf);
+	memset(d2h_fis, 0xfd, AHCI_RX_FIS_SZ);
  	return true;
  }
  
