From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] libata: clean up scsi_host_templates and ata_port_operations,
 take #3
Date: Wed, 19 Mar 2008 14:43:49 +0900
Message-ID: <47E0A815.80906@gmail.com>
References: <12052371651181-git-send-email-htejun@gmail.com> <47DE63F2.2030404@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:62874 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965393AbYCSVDl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Mar 2008 17:03:41 -0400
Received: by wa-out-1112.google.com with SMTP id v27so637284wah.23
        for <linux-ide@vger.kernel.org>; Wed, 19 Mar 2008 14:03:40 -0700 (PDT)
In-Reply-To: <47DE63F2.2030404@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@arm.linux.org.uk, alessandro.zummo@towertech.it, domen.puncer@telargo.com, akira2.iguchi@toshiba.co.jp, leoli@freescale.com, florian@openwrt.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Hello, all.
>>
>> This is the third take of cleanup-sht-ops patchset.  As the name
>> suggests it reorganizes and cleans up scsi_host_template and
>> ata_port_operation tables used by libata core and low level drivers.
>>
>> Please read the head message of the first take[F] for more info.
>> Changes from the last take[L] are...
>>
>> * Updated to fit the current upstream-fixes.
>>
>> * pata_scc thaw change applied.
>>
>> * pata_rb500_cf newly converted.
>>
>> * Updated to accomodate drivers w/o any reset method available.
>>
>> The following drivers need specific platform to build, so they need
>> verification.  If you work on one of the following drivers, please
>> verify that the driver builds and works fine.  It would be best if you
>> can verify that the sht and ops don't change by the fifth and sixth
>> patches using the method I'll write in another message.
>>
>> * pata_at32
>> * pata_bf54x
>> * pata_icside
>> * pata_ixp4xx_cf
>> * pata_mpc52xx
>> * pata_scc
>> * sata_fsl
>> * pata_rb500_cf
>>
>> This patchset is on top of
>>
>>   upstream-fixes (3db691daa4f6c4b899e144ea54a65738402c94e3)
>> + [1] prefer-hardreset patchset, take#3 (the subject line is wrong)
>> + [2] devres-implement-pcim_iomap_regions_request_all
>> + [3] ahci-request-all-PCI-BARs
>> + [4] libata-PCI-device-should-be-powered-up-before-being-accessed
>>
>> This patchset is available as GIT branch.
>>
>> http://git.kernel.org/?p=linux/kernel/git/tj/libata-dev.git;a=shortlog;h=cleanup-sht-ops
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata-dev.git
>> cleanup-sht-ops
>>
>> The verification method is the same as before[B].
>>
>> Thanks.
> 
> ACK patchset; based on recent comments I will await one final resend --
> or simply do a 'git pull'?
> 

Okay, branches updated.  Please pull.  There are only two changes.

* "sata_promise: hardreset is broken" patch added before
  prefer-hardreset patchset.  It just passes NULL for hardreset
  method.  This later gets translated into ops->hardreset =
  ATA_OP_NULL while making reset methods ops.

* pmp ops moved to sata_pmp_port_ops from sata_port_ops as they should
  be.

I'll post the sata_promise-hardreset-is-broken patch as reply to this
message and the following is the difference between end results of the
previous and updated patchset.

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5498a5b..482765f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -87,10 +87,6 @@ const struct ata_port_operations sata_port_ops = {
 
 	.qc_defer		= ata_std_qc_defer,
 	.dev_select		= ata_noop_dev_select,
-};
-
-const struct ata_port_operations sata_pmp_port_ops = {
-	.inherits		= &sata_port_ops,
 
 	.pmp_prereset		= sata_pmp_std_prereset,
 	.pmp_hardreset		= sata_pmp_std_hardreset,
@@ -98,6 +94,10 @@ const struct ata_port_operations sata_pmp_port_ops = {
 	.error_handler		= sata_pmp_error_handler,
 };
 
+const struct ata_port_operations sata_pmp_port_ops = {
+	.inherits		= &sata_port_ops,
+};
+
 const struct ata_port_operations ata_sff_port_ops = {
 	.inherits		= &ata_base_port_ops,
 
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index 28e4664..39b8022 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -176,10 +176,6 @@ static const struct ata_port_operations pdc_common_ops = {
 static struct ata_port_operations pdc_sata_ops = {
 	.inherits		= &pdc_common_ops,
 	.cable_detect		= pdc_sata_cable_detect,
-	/* FIXME: hardreset is currently broken and causes hotplug
-	 * event loop.  Remove ATA_OP_NULL once hardreset is fixed.
-	 */
-	.hardreset		= ATA_OP_NULL,
 	.scr_read		= pdc_sata_scr_read,
 	.scr_write		= pdc_sata_scr_write,
 	.port_start		= pdc_sata_port_start,

-- 
tejun
