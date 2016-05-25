From: Tejun Heo <tj@kernel.org>
Subject: Converting ipr to use ata_port_operations->error_handler
Date: Wed, 25 May 2016 15:32:58 -0400
Message-ID: <CAOS58YO65A8TpH22tEdM4SUcn8ncpY1f_YFMzomCN09OvhoRaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-scsi-owner@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
To: Brian King <brking@linux.vnet.ibm.com>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hello, Brian.

So, of all the ata drivers, ipr seems to be the only driver which
doesn't implement ata_port_opeations->error_handler and thus depends
on the old error handling path. I'm wondering whether it'd be possible
to convert ipr to implement ->error_handler and drop the old path.
Would that be difficult?

Thanks.

-- 
tejun
