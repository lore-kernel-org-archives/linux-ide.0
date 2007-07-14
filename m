From: Petr Vandrovec <petr@vandrovec.name>
Subject: Re: [PATCH] Unbreak build of PMP with ACPI disabled
Date: Sat, 14 Jul 2007 05:13:57 -0700
Message-ID: <4698BE05.2080003@vandrovec.name>
References: <20070713065600.GB8320@vana.vc.cvut.cz> <46972519.80703@gmail.com> <46980AFD.3000503@shaw.ca> <6.2.0.14.2.20070713175627.031aada0@linux.sysreset.com> <4698356D.60605@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060508000603080206010003"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailgw.cvut.cz ([147.32.3.235]:43977 "EHLO mailgw.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155AbXGNMr4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Jul 2007 08:47:56 -0400
In-Reply-To: <4698356D.60605@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Ryan Power <rpower@sysreset.com>, Robert Hancock <hancockr@shaw.ca>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------060508000603080206010003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
> Ryan Power wrote:
>> I'm also experiencing this problem on a with the sata_nv module.  I
>> suspect that it may at least not be controller dependant, as it's also
>> occurring on my silicon image controller (sata_sil, SiI3512).  It looks
>> like something is zeroing out part of the return registers for the
>> overall smart status.
>>
>> Tested with Maxtor 6L300S0 and Western Digital WD3200JS drives on both
>> the sil and nv controllers.  This was working in 2.6.21.6, but I haven't
>> had a chance to try and isolate the problem any further.
> 
> Hmmm... Incidentally, Jeff told me yesterday he was seeing the same
> problem on sil.  Maybe it's something in the core.  I'll investigate.

What about attached patch?  Seems to make my mcp61 happy... (it is sent 
from Mozilla, so patch below is most probably whitespace challenged... 
attachment should be fine)
							Petr


Fix reported task file values in sense data

ata_tf_read was setting HOB bit when lba48 command was submitted, but
was not clearing it before reading "normal" data.  Maybe it would be
better to just clear HOB bit immediately after reading upper halves
for lba48 command, but I just decided to clear HOB bit in each
ata_tf_read...

Signed-off-by: Petr Vandrovec <petr@vandrovec.name>

---
commit de1eff411670a3e5dfadcc281754cb26035779fa
tree 5fbcc8f667a34aa9688ce3aa19b9c92944a12862
parent c2e8a9b937eb84d1b712874f458790d2df25641a
author Petr Vandrovec <petr@vandrovec.name> Sat, 14 Jul 2007 05:11:03 -0700
committer root <root@gwy.hsd1.ca.comcast.net> Sat, 14 Jul 2007 05:11:03 
-0700

  drivers/ata/libata-sff.c |    1 +
  1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index a74afea..507ab69 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -196,6 +196,7 @@ void ata_tf_read(struct ata_port *ap, struct 
ata_taskfile *t
f)
  {
         struct ata_ioports *ioaddr = &ap->ioaddr;

+       iowrite8(tf->ctl, ioaddr->ctl_addr);
         tf->command = ata_check_status(ap);
         tf->feature = ioread8(ioaddr->error_addr);
         tf->nsect = ioread8(ioaddr->nsect_addr);

--------------060508000603080206010003
Content-Type: text/plain;
 name="unbreak-smart"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="unbreak-smart"

Fix reported task file values in sense data

ata_tf_read was setting HOB bit when lba48 command was submitted, but
was not clearing it before reading "normal" data.  Maybe it would be
better to just clear HOB bit immediately after reading upper halves
for lba48 command, but I just decided to clear HOB bit in each
ata_tf_read...

Signed-off-by: Petr Vandrovec <petr@vandrovec.name>

---
commit de1eff411670a3e5dfadcc281754cb26035779fa
tree 5fbcc8f667a34aa9688ce3aa19b9c92944a12862
parent c2e8a9b937eb84d1b712874f458790d2df25641a
author Petr Vandrovec <petr@vandrovec.name> Sat, 14 Jul 2007 05:11:03 -0700
committer root <root@gwy.hsd1.ca.comcast.net> Sat, 14 Jul 2007 05:11:03 -0700

 drivers/ata/libata-sff.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index a74afea..507ab69 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -196,6 +196,7 @@ void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
+	iowrite8(tf->ctl, ioaddr->ctl_addr);
 	tf->command = ata_check_status(ap);
 	tf->feature = ioread8(ioaddr->error_addr);
 	tf->nsect = ioread8(ioaddr->nsect_addr);

--------------060508000603080206010003--

