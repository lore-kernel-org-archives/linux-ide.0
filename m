From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: fixed a bug of adma in rhel4u5 with HDS7250SASUN500G.
Date: Wed, 23 Jan 2008 18:43:28 -0600
Message-ID: <4797DF30.6050208@shaw.ca>
References: <4781F008.9070404@gmail.com> <4782422C.8020202@rtr.ca>
 <4782B73B.8080309@shaw.ca> <4782BC48.4000309@gmail.com>
 <4782C008.3030902@shaw.ca> <4782CB62.7040901@gmail.com>
 <4782CEF9.3040708@gmail.com> <4782DFFE.50301@shaw.ca>
 <4782E5A8.9010305@gmail.com> <4782E63E.1000606@gmail.com>
 <4782E78F.9050205@shaw.ca> <4782E912.1050204@gmail.com>
 <4783493A.7070800@gmail.com> <47838B57.8020407@shaw.ca>
 <47842A54.2060107@gmail.com> <47842ABA.2060605@gmail.com>
 <47844471.4070705@shaw.ca> <47845708.6060900@gmail.com>
 <478567D8.10601@shaw.ca>
 <15F501D1A78BD343BE8F4D8DB854566B1BFE2ABF@hkemmail01.nvidia.com>
 <478812C9.1000901@shaw.ca>
 <15F501D1A78BD343BE8F4D8DB854566B1BFE2AC0@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:29713 "EHLO
	pd2mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbYAXAo1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jan 2008 19:44:27 -0500
In-reply-to: <15F501D1A78BD343BE8F4D8DB854566B1BFE2AC0@hkemmail01.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kuan Luo <kluo@nvidia.com>
Cc: Tejun Heo <htejun@gmail.com>, Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Allen Martin <AMartin@nvidia.com>, Peer Chen <pchen@nvidia.com>, linux-kernel <linux-kernel@vger.kernel.org>, David Milburn <dmilburn@redhat.com>

Kuan Luo wrote:
> First thank  davide to help to send the attachment.
> 
> Robert,
> The patch is to solve the error message "ata1: CPB flags CMD err,
> flags=0x11" when testing HDS7250SASUN500G in rhel4u5.
> I tested this hd in 2.6.24-rc7 which needed to remove the mask in
> blacklist to run the ncq and the same error also showed up. 
> 
> I traced the  bug and found that the interrupt finished a command (for
> example, tag=0) when the driver got that adma status is
> NV_ADMA_STAT_DONE  and  cpb->resp_flags is NV_CPB_RESP_DONE.
> However, For this hd, the drive maybe didn't clear bit 0 at this moment.
> It meaned the hardware  had not completely finished the command.
> If at the same time  the driver freed the command(tag 0) and sended
> another command (tag 0), the error happened.
> 
> The notifier register is 32-bit register containing notifier value.
> Value is bit vector containing one bit per tag number (0-31) in
> corresponding bit positions (bit 0 is for tag 0, etc). When bit is set
> then ADMA indicates that command with corresponding tag number completed
> execution.
> 
> So i added the check notifier code. Sometimes i saw that the notifier
> reg set some bits  , but the adma status set NV_ADMA_STAT_CMD_COMPLETE
> ,not NV_ADMA_STAT_DONE. So i added the NV_ADMA_STAT_CMD_COMPLETE check
> code.

Kuan, does this patch (using the notifiers to see if the command is 
really done) still work if one port on the controller has ADMA disabled 
because it's in ATAPI mode? I seem to recall Allen Martin mentioning 
that notifiers wouldn't work in this case.
