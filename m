From: Tejun Heo <htejun@gmail.com>
Subject: Re: Fwd: [LIBATA] drives not detected
Date: Wed, 21 Feb 2007 15:49:07 +0900
Message-ID: <45DBEB63.3010905@gmail.com>
References: <8d158e1f0702150048x4eb73acawc3c3b87d0d80a6d4@mail.gmail.com>	 <8d158e1f0702160010k2ed986ddtaccf8d2678ae1231@mail.gmail.com>	 <45D56FE4.3090900@tw.ibm.com>	 <8d158e1f0702160056j11ab6df1v99b4d72866f3e1b2@mail.gmail.com>	 <45D574B1.8080109@tw.ibm.com>	 <8d158e1f0702160148v366ce96bm8e3ff3e7c64a7198@mail.gmail.com>	 <45D58270.4080909@tw.ibm.com>	 <8d158e1f0702170236h51756aadh6539f5d782774764@mail.gmail.com>	 <45DAD8DA.4000108@gmail.com>	 <8d158e1f0702200405w6a0e817bx3d809540d28b843d@mail.gmail.com> <8d158e1f0702201400w622bbcb2lc7711b5c8974bfcd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000301070403060304060503"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.225]:30944 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbXBUHAI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Feb 2007 02:00:08 -0500
Received: by nz-out-0506.google.com with SMTP id s1so2155397nze
        for <linux-ide@vger.kernel.org>; Tue, 20 Feb 2007 23:00:07 -0800 (PST)
In-Reply-To: <8d158e1f0702201400w622bbcb2lc7711b5c8974bfcd@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Patrick Ale <patrick.ale@gmail.com>
Cc: albertl@mail.com, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------000301070403060304060503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Patrick Ale wrote:
> On 2/20/07, Patrick Ale <patrick.ale@gmail.com> wrote:
> Hi,
> 
> Here is the output of the dmesg after inserting pata_pdc207x
> 
> I seriously start to think that one of my drives is acting in a way
> that makes it unable for libata to detect the disks but makes the
> legacy ide drivers do detect the disks...
> 
> I see things like "Port is frozen" in the dmesg output.

That's normal but your drives are failing classification.  Can you
please apply the attached patch and report what the kernel says.  You
can turn off DEBUG options.

Thanks.

-- 
tejun

--------------000301070403060304060503
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2cf8251..1263d1b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -716,6 +716,8 @@ ata_dev_try_classify(struct ata_port *ap, unsigned int device, u8 *r_err)
 	memset(&tf, 0, sizeof(tf));
 
 	ap->ops->tf_read(ap, &tf);
+	ata_port_printk(ap, KERN_INFO, "CLASSIFY: device %u %02x:%02x %02x:%02x:%02x\n",
+			device, tf.command, tf.feature, tf.lbal, tf.lbam, tf.lbah);
 	err = tf.feature;
 	if (r_err)
 		*r_err = err;

--------------000301070403060304060503--
