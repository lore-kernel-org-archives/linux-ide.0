From: Tejun Heo <tj@kernel.org>
Subject: Re: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Wed, 15 Oct 2008 16:03:55 +0900
Message-ID: <48F595DB.4030301@kernel.org>
References: <20081011142735.GB5904@cleopatra.jogback.se> <48F4337A.50307@kernel.org> <20081014201917.GA5974@cleopatra.jogback.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000008050707090303010707"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45519 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751518AbYJOHF3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Oct 2008 03:05:29 -0400
In-Reply-To: <20081014201917.GA5974@cleopatra.jogback.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lars Michael Jogback <lm@jogback.se>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------000008050707090303010707
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Lars Michael Jogback wrote:
> * Tejun Heo <tj@kernel.org> [2008-10-14 14:51:54]:
> 
>> Hmmm.. drives usually make reset wait while they're spinning up so
>> that's where the spin wait logic is implemented.  Strange.  Can you
>> post full boot log and the result of "hdparm -I" on the drive?  Also,
>> if you first spin up the drive by conneciting only the power connector
>> and then connect the SATA cable a bit later, does it work?
> 
> OK, The drives are placed in hotswap-cages in an external enclosure with
> it's own powersupply. I have no possibility to connect the power to the
> actual drive before signal when I'm hotswapping. I don't think that'll
> make a difference though, since I have the same issue when I do a "cold
> boot".
> 
> With "cold boot" I mean that I turn the power on the enclosure first and
> then boot the PC. With a "warm boot" I reboot the PC a second time 
> without powercycling the disc enclosure or the discs.

Okay, that's enough.  That means spinning up doesn't have anything to
do with the detection failure.

> When I boot the first drive on the PMP is detected by the Sil3124. If
> it's a "cold boot", the second drive is not detected in Linux with the
> same error as when I hotplug the drive.
> 
> When I "warm boot" everything detects and is fine until I hotplug a
> disc.
> 
> Attached is dmesg from cold and warm boot, and hdparm -I on one of the
> disks.

Can you please try the followings?

1. If you swap the drive on the second slot with another one, does the
   detection problem stay with the port or follow the drive?

2. Does "libata.force=1.5Gbps" make any difference?

3. Apply the patch and post log after failed hotplug.

Thanks.

-- 
tejun

--------------000008050707090303010707
Content-Type: text/plain;
 name="pmp-detection-debug"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="pmp-detection-debug"

LS0tCiBkcml2ZXJzL2F0YS9zYXRhX3NpbDI0LmMgfCAgICAxICsKIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQoKSW5kZXg6IHRyZWUwL2RyaXZlcnMvYXRhL3NhdGFfc2lsMjQu
Ywo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09Ci0tLSB0cmVlMC5vcmlnL2RyaXZlcnMvYXRhL3NhdGFfc2lsMjQu
YworKysgdHJlZTAvZHJpdmVycy9hdGEvc2F0YV9zaWwyNC5jCkBAIC05NzgsNiArOTc4LDcg
QEAgc3RhdGljIHZvaWQgc2lsMjRfZXJyb3JfaW50cihzdHJ1Y3QgYXRhXwogCWVoaSA9ICZs
aW5rLT5laF9pbmZvOwogCWF0YV9laGlfY2xlYXJfZGVzYyhlaGkpOwogCisJYXRhX3BvcnRf
cHJpbnRrKGFwLCAiWFhYIGVycm9yX2ludHIgaXJxX3N0YXQ9MHgleFxuIiwgaXJxX3N0YXQp
OwogCWF0YV9laGlfcHVzaF9kZXNjKGVoaSwgImlycV9zdGF0IDB4JTA4eCIsIGlycV9zdGF0
KTsKIAogCWlmIChpcnFfc3RhdCAmIFBPUlRfSVJRX1NEQl9OT1RJRlkpIHsK
--------------000008050707090303010707--
