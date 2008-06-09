From: Tejun Heo <htejun@gmail.com>
Subject: Re: Port Multiplier drives not always all found on cold plug
Date: Mon, 09 Jun 2008 10:47:32 +0900
Message-ID: <484C8BB4.7050303@gmail.com>
References: <482DB79F.2030204@rtr.ca> <482DBA62.4020209@rtr.ca> <482DBC5C.3020904@rtr.ca> <482DC41F.9080901@rtr.ca> <482DCD1F.4090503@rtr.ca> <482EE9E1.5000805@gmail.com> <482F16AB.1040003@rtr.ca> <482F1B5C.2000006@gmail.com> <482F2F1C.9030102@rtr.ca> <482FBD41.7020604@gmail.com> <loom.20080602T033723-77@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:42640 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121AbYFIBri (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Jun 2008 21:47:38 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1890471wfd.4
        for <linux-ide@vger.kernel.org>; Sun, 08 Jun 2008 18:47:37 -0700 (PDT)
In-Reply-To: <loom.20080602T033723-77@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: JR Wilbert <jr.wilbert@gmail.com>
Cc: linux-ide@vger.kernel.org

JR Wilbert wrote:
> Forgive me if I am posting off topic or in the wrong place. 
> 
> I am also experiencing the same problem but with sata_sil24 running  Fedora Core
> 9  with kernel 2.6.25.3-18.fc9.i686.  And I think you are right about it not
> being contained with sata_mv  
> 
> On cold boot with all drives in the array the system fails to see any drives. If
>  I boot without the drives I can connect them , up to 3 drives. 
> 
> 
> If do  rmmod sata_sil24 && modprobe sata_sil24 with 3 out of 4 drives connected. 
> And it takes some time to load sata_sil24 
> 
> If I am wrong for posting here please let me know.  If I can help in anyway also
> let me know. 

Can you please try the following git tree?

http://git.kernel.org/?p=linux/kernel/git/tj/libata-dev.git;a=shortlog;h=improve-timeout

-- 
tejun
