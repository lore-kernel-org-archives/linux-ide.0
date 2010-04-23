From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] drivers/ata/libata-eh.c: fix unused variable warning
Date: Fri, 23 Apr 2010 09:01:04 +0200
Message-ID: <4BD145B0.8080102@kernel.org>
References: <1271858846-1706-1-git-send-email-antonf@turbolinux.com.cn> <20100421152404.62699040@lxorguk.ukuu.org.uk> <4BCF1247.8080508@gmail.com> <4BCFA50E.80800@gmail.com> <4BD13E84.2040204@kernel.org> <20100423064332.GA22988@shell.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47202 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756092Ab0DWHBl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Apr 2010 03:01:41 -0400
In-Reply-To: <20100423064332.GA22988@shell.devel.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@redhat.com>
Cc: Fang Wenqi <anton.fang@gmail.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, antonf@turbolinux.com.cn

Hello, Jeff.

On 04/23/2010 08:43 AM, Jeff Garzik wrote:
> On Fri, Apr 23, 2010 at 08:30:28AM +0200, Tejun Heo wrote:
>> On 04/22/2010 03:23 AM, Fang Wenqi wrote:
>>> Sorry that the title should be:
>>>  "fix uninitialized variable warning"
>>>
>>> not
>>> "fix unused variable warning"
>>>
>>> Need I re-send the patch mail ?
>>
>> Yes, please do so.  gcc 4.4.1 generates a spurious warning on it too.
>>
>> Acked-by: Tejun Heo <tj@kernel.org>
> 
> It's not a spurious warning.  The code failed to fully initialize all
> fields of the ata_taskfile structure, prior to copying the ata_taskfile
> structure into qc->result_tf.

Hmmmm.... right, I've always thought it was gcc not noticing the
structure is being initialized in ata_eh_read_log_10h() but it
actually is noticing much more, so something like the following is
more appropriate?

Subject: libata: fully initialize @tf in ata_eh_read_log_10h()

ata_eh_read_log_10h() filled @tf only partially.  It didn't cause any
correctness issues but triggered spruious uninitialized variable
warning.  Do ata_tf_init() before filling in @tf.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-eh.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 9f6cfac..fa7e902 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1434,6 +1434,7 @@ static int ata_eh_read_log_10h(struct ata_device *dev,

 	*tag = buf[0] & 0x1f;

+	ata_tf_init(dev, tf);
 	tf->command = buf[2];
 	tf->feature = buf[3];
 	tf->lbal = buf[4];
